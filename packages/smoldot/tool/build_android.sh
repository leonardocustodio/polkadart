#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
RUST_DIR="$PROJECT_DIR/rust"
NATIVE_DIR="$PROJECT_DIR/native/android"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Building smoldot for Android${NC}"

# Check for cargo-ndk
if ! command -v cargo-ndk &> /dev/null; then
    echo -e "${YELLOW}Installing cargo-ndk...${NC}"
    cargo install cargo-ndk
fi

# Check for NDK
if [ -z "$ANDROID_NDK_HOME" ]; then
    echo -e "${RED}Error: ANDROID_NDK_HOME is not set${NC}"
    echo "Please set ANDROID_NDK_HOME to your Android NDK installation path"
    exit 1
fi

cd "$RUST_DIR"

# Android targets
TARGETS=(
    "aarch64-linux-android"   # arm64-v8a
    "armv7-linux-androideabi" # armeabi-v7a
    "i686-linux-android"      # x86
    "x86_64-linux-android"    # x86_64
)

# Install targets
for target in "${TARGETS[@]}"; do
    echo -e "${YELLOW}Adding target: $target${NC}"
    rustup target add "$target" || true
done

# Build for all architectures
echo -e "${YELLOW}Building for all Android architectures...${NC}"
cargo ndk \
    -t arm64-v8a \
    -t armeabi-v7a \
    -t x86 \
    -t x86_64 \
    -o "$NATIVE_DIR" \
    build --release

echo -e "${GREEN}Android build complete!${NC}"
ls -lh "$NATIVE_DIR"/*/*.so
