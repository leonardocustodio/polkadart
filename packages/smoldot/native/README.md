# Native Libraries

This directory should contain the compiled native smoldot-light libraries for different platforms.

## Required Files

Place the compiled native libraries in this directory:

- **Linux/Android**: `libsmoldot_light.so`
- **macOS/iOS**: `libsmoldot_light.dylib`
- **Windows**: `smoldot_light.dll`

## Building from Source

The native libraries need to be built from the smoldot Rust project with FFI support.

### Prerequisites

- Rust toolchain (install from https://rustup.rs/)
- Target platform toolchains

### Build Instructions

1. Clone the smoldot repository:
   ```bash
   git clone https://github.com/smol-dot/smoldot.git
   cd smoldot
   ```

2. Build the FFI library:
   ```bash
   cargo build --release --package smoldot-light-ffi
   ```

3. Copy the compiled library to this directory:
   ```bash
   # Linux
   cp target/release/libsmoldot_light.so /path/to/smoldot_light/native/

   # macOS
   cp target/release/libsmoldot_light.dylib /path/to/smoldot_light/native/

   # Windows
   cp target/release/smoldot_light.dll /path/to/smoldot_light/native/
   ```

## Cross-compilation

For cross-platform builds, refer to the Rust cross-compilation documentation:
https://rust-lang.github.io/rustup/cross-compilation.html

### Android

```bash
rustup target add aarch64-linux-android armv7-linux-androideabi
cargo build --release --target aarch64-linux-android
```

### iOS

```bash
rustup target add aarch64-apple-ios
cargo build --release --target aarch64-apple-ios
```

## C API Header

The `smoldot_light.h` header file should also be placed in this directory once available.

## Note

Currently, the Rust FFI bridge is pending implementation. This directory structure is prepared for when the native library becomes available.
