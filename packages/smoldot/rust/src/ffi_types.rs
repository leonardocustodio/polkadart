//! FFI type definitions

use serde::{Deserialize, Serialize};
use std::os::raw::c_char;

/// Opaque handle to a smoldot client
pub type ClientHandle = u64;

/// Opaque handle to a chain
pub type ChainHandle = u64;

/// Callback function type for async operations
///
/// # Arguments
/// * `callback_id` - ID to match callback with request
/// * `result` - Result value (handle, string pointer, or 0 for error)
/// * `error` - Error message pointer (null if success)
pub type DartCallback = unsafe extern "C" fn(
    callback_id: i64,
    result: i64,
    error: *const c_char,
);

/// Client configuration (JSON-serializable)
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ClientConfigJson {
    /// Maximum log level (0 = off, 1 = error, 2 = warn, 3 = info, 4 = debug, 5 = trace)
    #[serde(default = "default_log_level")]
    pub max_log_level: u8,

    /// System name
    #[serde(default)]
    pub system_name: Option<String>,

    /// System version
    #[serde(default)]
    pub system_version: Option<String>,
}

fn default_log_level() -> u8 {
    3 // Info
}

impl Default for ClientConfigJson {
    fn default() -> Self {
        Self {
            max_log_level: default_log_level(),
            system_name: None,
            system_version: None,
        }
    }
}

/// Add chain configuration (JSON-serializable)
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AddChainConfigJson {
    /// Chain specification (JSON string)
    pub chain_spec: String,

    /// Potential relay chain handles
    #[serde(default)]
    pub potential_relay_chains: Vec<ChainHandle>,

    /// Database content for resuming sync
    #[serde(default)]
    pub database_content: Option<String>,

    /// Disable JSON-RPC (default: false)
    #[serde(default)]
    pub disable_json_rpc: bool,
}

/// Log message from smoldot
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct LogMessage {
    /// Log level
    pub level: u8,

    /// Log message
    pub message: String,

    /// Timestamp (milliseconds since epoch)
    pub timestamp: u64,
}

/// Chain status
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ChainStatus {
    /// Whether the chain is synced
    pub is_synced: bool,

    /// Current block number
    pub block_number: Option<u64>,

    /// Best block hash
    pub best_block_hash: Option<String>,
}
