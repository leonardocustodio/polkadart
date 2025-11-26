//! Callback registry for managing async operations

use parking_lot::Mutex;
use std::collections::HashMap;
use std::sync::Arc;

/// Registry for managing callbacks
pub struct CallbackRegistry {
    callbacks: Arc<Mutex<HashMap<i64, CallbackInfo>>>,
}

/// Information about a registered callback
#[derive(Clone)]
struct CallbackInfo {
    /// Callback ID
    id: i64,

    /// Timestamp when callback was registered
    timestamp: std::time::Instant,
}

impl CallbackRegistry {
    /// Create a new callback registry
    pub fn new() -> Self {
        Self {
            callbacks: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    /// Register a new callback
    pub fn register(&self, id: i64) {
        let info = CallbackInfo {
            id,
            timestamp: std::time::Instant::now(),
        };

        self.callbacks.lock().insert(id, info);
    }

    /// Unregister a callback
    pub fn unregister(&self, id: i64) -> bool {
        self.callbacks.lock().remove(&id).is_some()
    }

    /// Check if a callback is registered
    pub fn is_registered(&self, id: i64) -> bool {
        self.callbacks.lock().contains_key(&id)
    }

    /// Get the number of registered callbacks
    pub fn count(&self) -> usize {
        self.callbacks.lock().len()
    }

    /// Clear all callbacks
    pub fn clear(&self) {
        self.callbacks.lock().clear();
    }

    /// Remove callbacks older than the specified duration
    pub fn remove_stale(&self, duration: std::time::Duration) {
        let now = std::time::Instant::now();
        self.callbacks.lock().retain(|_, info| {
            now.duration_since(info.timestamp) < duration
        });
    }
}

impl Default for CallbackRegistry {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_callback_registry() {
        let registry = CallbackRegistry::new();

        registry.register(1);
        assert!(registry.is_registered(1));
        assert_eq!(registry.count(), 1);

        registry.register(2);
        assert_eq!(registry.count(), 2);

        assert!(registry.unregister(1));
        assert!(!registry.is_registered(1));
        assert_eq!(registry.count(), 1);

        registry.clear();
        assert_eq!(registry.count(), 0);
    }
}
