//! Error types for smoldot FFI

use std::fmt;

/// Result type for smoldot operations
pub type SmoldotResult<T> = Result<T, SmoldotError>;

/// Error types that can occur in smoldot operations
#[derive(Debug)]
pub enum SmoldotError {
    /// Invalid client handle
    InvalidClientHandle,
    /// Invalid chain handle
    InvalidChainHandle,
    /// Invalid UTF-8 string
    InvalidUtf8,
    /// JSON parsing error
    JsonError(String),
    /// Chain addition failed
    AddChainFailed(String),
    /// JSON-RPC error
    JsonRpcError(String),
    /// Runtime error
    RuntimeError(String),
    /// Null pointer
    NullPointer,
    /// Other error
    Other(String),
}

impl fmt::Display for SmoldotError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            SmoldotError::InvalidClientHandle => write!(f, "Invalid client handle"),
            SmoldotError::InvalidChainHandle => write!(f, "Invalid chain handle"),
            SmoldotError::InvalidUtf8 => write!(f, "Invalid UTF-8 string"),
            SmoldotError::JsonError(msg) => write!(f, "JSON error: {}", msg),
            SmoldotError::AddChainFailed(msg) => write!(f, "Failed to add chain: {}", msg),
            SmoldotError::JsonRpcError(msg) => write!(f, "JSON-RPC error: {}", msg),
            SmoldotError::RuntimeError(msg) => write!(f, "Runtime error: {}", msg),
            SmoldotError::NullPointer => write!(f, "Null pointer"),
            SmoldotError::Other(msg) => write!(f, "{}", msg),
        }
    }
}

impl std::error::Error for SmoldotError {}

impl From<serde_json::Error> for SmoldotError {
    fn from(err: serde_json::Error) -> Self {
        SmoldotError::JsonError(err.to_string())
    }
}

impl From<std::str::Utf8Error> for SmoldotError {
    fn from(_: std::str::Utf8Error) -> Self {
        SmoldotError::InvalidUtf8
    }
}
