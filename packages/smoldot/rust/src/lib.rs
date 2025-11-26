//! FFI bindings for smoldot-light
//!
//! This library provides C-compatible FFI exports for the smoldot-light
//! Rust library, enabling Dart applications to use a lightweight Substrate/Polkadot client.

use parking_lot::Mutex;
use smoldot_light::{
    AddChainConfig, AddChainConfigJsonRpc, AddChainSuccess, ChainId, Client,
    JsonRpcResponses, platform::DefaultPlatform,
};
use std::collections::HashMap;
use std::ffi::{CStr, CString};
use std::os::raw::{c_char, c_int};
use std::sync::Arc;
use once_cell::sync::Lazy;

mod error;
mod ffi_types;
mod callbacks;

use error::{SmoldotError, SmoldotResult};
use ffi_types::*;
use callbacks::CallbackRegistry;

/// Global registry of clients (handle-based for safety)
static CLIENTS: Lazy<Mutex<HashMap<ClientHandle, Arc<SmoldotClientWrapper>>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));

/// Global registry of chains (handle-based for safety)
static CHAINS: Lazy<Mutex<HashMap<ChainHandle, Arc<SmoldotChainWrapper>>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));

/// Global callback registry
static CALLBACKS: Lazy<Arc<CallbackRegistry>> =
    Lazy::new(|| Arc::new(CallbackRegistry::new()));

/// Wrapper around smoldot Client with interior mutability
struct SmoldotClientWrapper {
    client: Mutex<Client<Arc<DefaultPlatform>, ()>>,
    runtime: tokio::runtime::Runtime,
}

/// Wrapper around Chain and ChainId
struct SmoldotChainWrapper {
    chain_id: ChainId,
    client_handle: ClientHandle,
    json_rpc_responses: Arc<tokio::sync::Mutex<Option<JsonRpcResponses<Arc<DefaultPlatform>>>>>,
}

/// Initialize a new smoldot client
///
/// # Safety
/// - `config_json` must be a valid null-terminated UTF-8 string
/// - Returns 0 on failure
#[no_mangle]
pub unsafe extern "C" fn smoldot_client_init(
    config_json: *const c_char,
    error_out: *mut *mut c_char,
) -> ClientHandle {
    if config_json.is_null() {
        set_error(error_out, "config_json is null");
        return 0;
    }

    let config_str = match CStr::from_ptr(config_json).to_str() {
        Ok(s) => s,
        Err(_) => {
            set_error(error_out, "Invalid UTF-8 in config_json");
            return 0;
        }
    };

    let config: ClientConfigJson = match serde_json::from_str(config_str) {
        Ok(c) => c,
        Err(e) => {
            set_error(error_out, &format!("Failed to parse config: {}", e));
            return 0;
        }
    };

    // Create Tokio runtime
    let runtime = match tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build()
    {
        Ok(rt) => rt,
        Err(e) => {
            set_error(error_out, &format!("Failed to create runtime: {}", e));
            return 0;
        }
    };

    // Get system name and version
    let system_name = config.system_name.unwrap_or_else(|| "Polkadart".to_string());
    let system_version = config.system_version.unwrap_or_else(|| "0.1.0".to_string());

    // Initialize smoldot client (Client::new wraps platform in Arc internally)
    let platform = DefaultPlatform::new(
        system_name.into(),
        system_version.into(),
    );

    let client = Client::new(platform);

    let wrapper = Arc::new(SmoldotClientWrapper {
        client: Mutex::new(client),
        runtime,
    });

    // Generate handle
    let handle = generate_client_handle();

    // Store in registry
    CLIENTS.lock().insert(handle, wrapper);

    handle
}

/// Add a chain to the client
///
/// # Safety
/// - `client_handle` must be a valid handle returned from `smoldot_client_init`
/// - `chain_spec_json` must be a valid null-terminated UTF-8 string
/// - `callback` must be a valid function pointer
#[no_mangle]
pub unsafe extern "C" fn smoldot_add_chain(
    client_handle: ClientHandle,
    chain_spec_json: *const c_char,
    potential_relay_chains: *const ChainHandle,
    relay_chains_count: c_int,
    database_content: *const c_char,
    callback_id: i64,
    callback: DartCallback,
    error_out: *mut *mut c_char,
) -> c_int {
    if chain_spec_json.is_null() {
        set_error(error_out, "chain_spec_json is null");
        return -1;
    }

    let chain_spec = match CStr::from_ptr(chain_spec_json).to_str() {
        Ok(s) => s.to_string(),
        Err(_) => {
            set_error(error_out, "Invalid UTF-8 in chain_spec_json");
            return -1;
        }
    };

    let db_content = if !database_content.is_null() {
        match CStr::from_ptr(database_content).to_str() {
            Ok(s) => s.to_string(),
            Err(_) => {
                set_error(error_out, "Invalid UTF-8 in database_content");
                return -1;
            }
        }
    } else {
        String::new()
    };

    // Get client from registry
    let client_wrapper = {
        let clients = CLIENTS.lock();
        match clients.get(&client_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid client handle");
                return -1;
            }
        }
    };

    // Parse potential relay chains
    let relay_chains: Vec<ChainId> = if !potential_relay_chains.is_null() && relay_chains_count > 0 {
        let chains_slice = std::slice::from_raw_parts(
            potential_relay_chains,
            relay_chains_count as usize,
        );

        let chains_lock = CHAINS.lock();
        chains_slice
            .iter()
            .filter_map(|&handle| {
                chains_lock.get(&handle).map(|wrapper| wrapper.chain_id)
            })
            .collect()
    } else {
        Vec::new()
    };

    // Clone Arc to move into async block
    let client_wrapper_clone = Arc::clone(&client_wrapper);

    // Spawn async task to add chain
    client_wrapper.runtime.spawn(async move {
        let config = AddChainConfig {
            specification: &chain_spec,
            json_rpc: AddChainConfigJsonRpc::Enabled {
                max_pending_requests: std::num::NonZeroU32::new(128).unwrap(),
                max_subscriptions: 1024,
            },
            potential_relay_chains: relay_chains.into_iter(),
            database_content: &db_content,
            user_data: (),
        };

        // Get mutable access to client (add_chain is NOT async in 0.18.0)
        let add_result = {
            let mut client = client_wrapper_clone.client.lock();
            client.add_chain(config)
        };

        match add_result {
            Ok(AddChainSuccess {
                chain_id,
                json_rpc_responses,
            }) => {
                // Create chain wrapper
                let chain_wrapper = Arc::new(SmoldotChainWrapper {
                    chain_id,
                    client_handle,
                    json_rpc_responses: Arc::new(tokio::sync::Mutex::new(json_rpc_responses)),
                });

                // Generate handle
                let chain_handle = generate_chain_handle();

                // Store in registry
                CHAINS.lock().insert(chain_handle, chain_wrapper);

                // Invoke callback with success
                callback(callback_id, chain_handle as i64, std::ptr::null());
            }
            Err(e) => {
                // Create error message
                let error_msg = CString::new(format!("Failed to add chain: {:?}", e))
                    .unwrap_or_else(|_| CString::new("Unknown error").unwrap());
                callback(callback_id, 0, error_msg.as_ptr());
                // Note: error_msg is leaked here, Dart side must free it
                std::mem::forget(error_msg);
            }
        }
    });

    0 // Success (async operation started)
}

/// Send a JSON-RPC request to a chain
///
/// # Safety
/// - `chain_handle` must be a valid handle
/// - `request_json` must be a valid null-terminated UTF-8 string
#[no_mangle]
pub unsafe extern "C" fn smoldot_send_json_rpc(
    chain_handle: ChainHandle,
    request_json: *const c_char,
    error_out: *mut *mut c_char,
) -> c_int {
    if request_json.is_null() {
        set_error(error_out, "request_json is null");
        return -1;
    }

    let request = match CStr::from_ptr(request_json).to_str() {
        Ok(s) => s.to_string(),
        Err(_) => {
            set_error(error_out, "Invalid UTF-8 in request_json");
            return -1;
        }
    };

    // Get chain from registry
    let chain_wrapper = {
        let chains = CHAINS.lock();
        match chains.get(&chain_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid chain handle");
                return -1;
            }
        }
    };

    // Get client
    let client_wrapper = {
        let clients = CLIENTS.lock();
        match clients.get(&chain_wrapper.client_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid client handle");
                return -1;
            }
        }
    };

    // Send JSON-RPC request (needs mutable access)
    let mut client = client_wrapper.client.lock();
    match client.json_rpc_request(&request, chain_wrapper.chain_id) {
        Ok(_) => 0,
        Err(e) => {
            set_error(error_out, &format!("JSON-RPC error: {:?}", e));
            -1
        }
    }
}

/// Get next JSON-RPC response from a chain (blocking)
///
/// # Safety
/// - `chain_handle` must be a valid handle
/// - `callback` must be a valid function pointer
/// - Caller must free the returned string with `smoldot_free_string`
#[no_mangle]
pub unsafe extern "C" fn smoldot_next_json_rpc_response(
    chain_handle: ChainHandle,
    callback_id: i64,
    callback: DartCallback,
    error_out: *mut *mut c_char,
) -> c_int {
    // Get chain from registry
    let chain_wrapper = {
        let chains = CHAINS.lock();
        match chains.get(&chain_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid chain handle");
                return -1;
            }
        }
    };

    // Get client
    let client_wrapper = {
        let clients = CLIENTS.lock();
        match clients.get(&chain_wrapper.client_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid client handle");
                return -1;
            }
        }
    };

    // Clone the response handle with explicit type
    let responses_arc: Arc<tokio::sync::Mutex<Option<JsonRpcResponses<Arc<DefaultPlatform>>>>> = Arc::clone(&chain_wrapper.json_rpc_responses);

    // Spawn async task
    client_wrapper.runtime.spawn(async move {
        // Lock the responses stream (tokio::sync::Mutex is Send-safe)
        // Multiple concurrent calls will queue up here, ensuring FIFO ordering
        let response_result = {
            let mut responses_lock = responses_arc.lock().await;

            if let Some(ref mut responses) = *responses_lock {
                // Get the next response while holding the lock
                // This ensures:
                // 1. Responses come out in FIFO order
                // 2. No race conditions between concurrent requests
                // 3. The stream is never in an invalid state
                match responses.next().await {
                    Some(response) => Ok(response),
                    None => Err("Channel closed"),
                }
            } else {
                Err("JSON-RPC not enabled")
            }
            // Lock is dropped here after getting the response
        };

        match response_result {
            Ok(response) => {
                // Convert response to C string
                let response_cstr = CString::new(response)
                    .unwrap_or_else(|_| CString::new("").unwrap());
                callback(callback_id, response_cstr.as_ptr() as i64, std::ptr::null());
                std::mem::forget(response_cstr); // Dart must free
            }
            Err(error_msg) => {
                let error_cstr = CString::new(error_msg).unwrap();
                callback(callback_id, 0, error_cstr.as_ptr());
                std::mem::forget(error_cstr);
            }
        }
    });

    0 // Success
}

/// Remove a chain from the client
///
/// # Safety
/// - `chain_handle` must be a valid handle
#[no_mangle]
pub unsafe extern "C" fn smoldot_remove_chain(
    chain_handle: ChainHandle,
    error_out: *mut *mut c_char,
) -> c_int {
    // Remove from registry
    let chain_wrapper = {
        let mut chains = CHAINS.lock();
        match chains.remove(&chain_handle) {
            Some(c) => c,
            None => {
                set_error(error_out, "Invalid chain handle");
                return -1;
            }
        }
    };

    // Get client
    let client_wrapper = {
        let clients = CLIENTS.lock();
        match clients.get(&chain_wrapper.client_handle) {
            Some(c) => Arc::clone(c),
            None => {
                set_error(error_out, "Invalid client handle");
                return -1;
            }
        }
    };

    // Remove chain from client (needs mutable access)
    let mut client = client_wrapper.client.lock();
    let _ = client.remove_chain(chain_wrapper.chain_id);

    0 // Success
}

/// Destroy a client and all its chains
///
/// # Safety
/// - `client_handle` must be a valid handle
/// - All chain handles for this client become invalid
#[no_mangle]
pub unsafe extern "C" fn smoldot_client_destroy(
    client_handle: ClientHandle,
    error_out: *mut *mut c_char,
) -> c_int {
    // Remove all chains for this client
    {
        let mut chains = CHAINS.lock();
        chains.retain(|_, wrapper| wrapper.client_handle != client_handle);
    }

    // Remove client from registry
    let mut clients = CLIENTS.lock();
    if clients.remove(&client_handle).is_none() {
        set_error(error_out, "Invalid client handle");
        return -1;
    }

    0 // Success
}

/// Free a string allocated by Rust
///
/// # Safety
/// - `ptr` must have been allocated by Rust via CString
#[no_mangle]
pub unsafe extern "C" fn smoldot_free_string(ptr: *mut c_char) {
    if !ptr.is_null() {
        let _ = CString::from_raw(ptr);
    }
}

/// Get the version of the smoldot FFI library
///
/// # Safety
/// - Returned string must be freed with `smoldot_free_string`
#[no_mangle]
pub unsafe extern "C" fn smoldot_version() -> *mut c_char {
    let version = env!("CARGO_PKG_VERSION");
    CString::new(version)
        .unwrap_or_else(|_| CString::new("unknown").unwrap())
        .into_raw()
}

// Helper functions

fn generate_client_handle() -> ClientHandle {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(1);
    COUNTER.fetch_add(1, Ordering::Relaxed)
}

fn generate_chain_handle() -> ChainHandle {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(1);
    COUNTER.fetch_add(1, Ordering::Relaxed)
}

unsafe fn set_error(error_out: *mut *mut c_char, message: &str) {
    if !error_out.is_null() {
        let error_cstr = CString::new(message)
            .unwrap_or_else(|_| CString::new("Unknown error").unwrap());
        *error_out = error_cstr.into_raw();
    }
}
