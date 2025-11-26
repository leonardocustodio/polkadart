# Building smoldot package

This document explains how to build the Rust FFI library for the smoldot package across different platforms.

## Prerequisites

### All Platforms
- **Rust** 1.70+ (install from https://rustup.rs/)
- **Dart SDK** 3.6+ (from https://dart.dev/get-dart)

### Platform-Specific

#### macOS
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Add macOS targets
rustup target add x86_64-apple-darwin aarch64-apple-darwin
```

#### Linux
```bash
# Install build essentials
sudo apt-get update
sudo apt-get install build-essential pkg-config

# Add Linux target
rustup target add x86_64-unknown-linux-gnu
```

#### Windows
```bash
# Install Visual Studio Build Tools
# Download from: https://visualstudio.microsoft.com/downloads/

# Add Windows target
rustup target add x86_64-pc-windows-msvc
```

#### Android
```bash
# Install Android NDK (via Android Studio or standalone)
# Set environment variable:
export ANDROID_NDK_HOME=/path/to/android-ndk

# Install cargo-ndk
cargo install cargo-ndk

# Add Android targets
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
```

#### iOS
```bash
# Install Xcode from Mac App Store

# Add iOS targets
rustup target add aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim
```

## Building

### Desktop (macOS, Linux, Windows)

```bash
cd packages/smoldot
./tools/build_rust.sh
```

This will:
1. Build the Rust library for your current platform
2. Place the compiled library in `native/{platform}/`
3. Generate Dart FFI bindings (if ffigen is available)

### Android

```bash
cd packages/smoldot
./tools/build_android.sh
```

Output: `native/android/{abi}/libsmoldot.so` for each ABI

### iOS

```bash
cd packages/smoldot
./tools/build_ios.sh
```

Output:
- `native/ios/libsmoldot_device.a` - For iOS devices
- `native/ios/libsmoldot_sim.a` - For iOS simulator
- `native/ios/smoldot.xcframework` - Universal framework (if Xcode available)

## Manual Build

### Basic Build

```bash
cd packages/smoldot/rust
cargo build --release
```

### Cross-Compilation

```bash
# For a specific target
cargo build --release --target aarch64-apple-ios

# For Android (using cargo-ndk)
cargo ndk -t arm64-v8a build --release
```

## Generating FFI Bindings

The Dart FFI bindings are auto-generated from the Rust code:

```bash
cd packages/smoldot

# Install ffigen if not already installed
dart pub global activate ffigen

# Generate bindings
dart run ffigen --config pubspec.yaml
```

This generates `lib/src/bindings_generated.dart`.

## Directory Structure

After building, you should have:

```
packages/smoldot/
├── rust/
│   ├── target/
│   │   └── release/
│   │       └── libsmoldot.{so,dylib,dll}
│   └── ...
├── native/
│   ├── smoldot.h            # C header (generated)
│   ├── linux/
│   │   └── libsmoldot.so
│   ├── macos/
│   │   └── libsmoldot.dylib
│   ├── windows/
│   │   └── smoldot.dll
│   ├── android/
│   │   ├── arm64-v8a/libsmoldot.so
│   │   ├── armeabi-v7a/libsmoldot.so
│   │   ├── x86/libsmoldot.so
│   │   └── x86_64/libsmoldot.so
│   └── ios/
│       ├── libsmoldot_device.a
│       ├── libsmoldot_sim.a
│       └── smoldot.xcframework/
└── lib/
    └── src/
        └── bindings_generated.dart
```

## Troubleshooting

### Rust Compilation Errors

```bash
# Update Rust
rustup update

# Clean and rebuild
cd packages/smoldot/rust
cargo clean
cargo build --release
```

### Missing Targets

```bash
# List installed targets
rustup target list --installed

# Add missing target
rustup target add <target-name>
```

### Android NDK Issues

```bash
# Verify NDK installation
echo $ANDROID_NDK_HOME
ls $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/*/bin/

# Reinstall cargo-ndk
cargo install --force cargo-ndk
```

### macOS Universal Binary Issues

```bash
# Check architectures in library
lipo -info native/macos/libsmoldot.dylib

# Should output: Architectures in the fat file: ... are: x86_64 arm64
```

### FFI Binding Generation Fails

```bash
# Ensure C header exists
ls native/smoldot.h

# Regenerate header
cd packages/smoldot/rust
cargo build --release

# Try ffigen again
dart run ffigen --config pubspec.yaml
```

## CI/CD Integration

For automated builds, see `.github/workflows/build_smoldot.yml`:

```yaml
- name: Build Rust library
  run: |
    cd packages/smoldot
    ./tools/build_rust.sh
```

## Optimization

The release builds are optimized for size and performance:

- **Size optimization**: `opt-level = "z"`
- **Link-time optimization**: `lto = true`
- **Single codegen unit**: `codegen-units = 1`
- **Symbol stripping**: `strip = true`
- **Panic strategy**: `panic = "abort"`

Typical binary sizes:
- macOS (universal): ~8-10 MB
- Linux: ~8-9 MB
- Windows: ~8-9 MB
- Android (per ABI): ~7-8 MB
- iOS: ~14-16 MB (XCFramework includes simulator + device)

## Development Build

For faster iteration during development:

```bash
cd packages/smoldot/rust

# Dev build (faster compilation, larger binary)
cargo build

# Dev build outputs to target/debug/
```
