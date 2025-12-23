#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
RUST_DIR="$PROJECT_DIR/rust"
NATIVE_DIR="$PROJECT_DIR/native"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building smoldot Rust library${NC}"

# Detect platform
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
    EXT="so"
    TARGET="x86_64-unknown-linux-gnu"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    EXT="dylib"
    # Build universal binary for macOS (Intel + Apple Silicon)
    echo -e "${YELLOW}Building for macOS (universal binary)${NC}"
    cd "$RUST_DIR"

    # Build for both architectures
    cargo build --release --target x86_64-apple-darwin
    cargo build --release --target aarch64-apple-darwin

    # Create universal binary
    mkdir -p "$NATIVE_DIR/$PLATFORM"
    lipo -create \
        "target/x86_64-apple-darwin/release/libsmoldot.dylib" \
        "target/aarch64-apple-darwin/release/libsmoldot.dylib" \
        -output "$NATIVE_DIR/$PLATFORM/libsmoldot.dylib"

    echo -e "${GREEN}Build complete: $NATIVE_DIR/$PLATFORM/libsmoldot.dylib${NC}"
    exit 0
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    PLATFORM="windows"
    EXT="dll"
    TARGET="x86_64-pc-windows-msvc"
else
    echo -e "${RED}Unsupported platform: $OSTYPE${NC}"
    exit 1
fi

# Build for target platform
echo -e "${YELLOW}Building for $PLATFORM (target: $TARGET)${NC}"
cd "$RUST_DIR"

# Install target if not already installed
rustup target add "$TARGET" 2>/dev/null || true

# Build
cargo build --release --target "$TARGET"

# Copy built library
mkdir -p "$NATIVE_DIR/$PLATFORM"
cp "target/$TARGET/release/libsmoldot.$EXT" "$NATIVE_DIR/$PLATFORM/"

echo -e "${GREEN}Build complete: $NATIVE_DIR/$PLATFORM/libsmoldot.$EXT${NC}"

# Generate bindings if ffigen is available
if command -v dart &> /dev/null; then
    echo -e "${YELLOW}Generating Dart FFI bindings...${NC}"
    cd "$PROJECT_DIR"
    dart run ffigen --config pubspec.yaml || echo -e "${YELLOW}Warning: ffigen not available or failed${NC}"
fi
