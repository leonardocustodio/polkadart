#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
RUST_DIR="$PROJECT_DIR/rust"
NATIVE_DIR="$PROJECT_DIR/native/ios"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Building smoldot for iOS${NC}"

cd "$RUST_DIR"

# iOS targets
TARGETS=(
    "aarch64-apple-ios"       # iOS devices
    "x86_64-apple-ios"        # iOS simulator (Intel)
    "aarch64-apple-ios-sim"   # iOS simulator (Apple Silicon)
)

# Install targets
for target in "${TARGETS[@]}"; do
    echo -e "${YELLOW}Adding target: $target${NC}"
    rustup target add "$target" || true
done

# Build for all targets
for target in "${TARGETS[@]}"; do
    echo -e "${YELLOW}Building for $target...${NC}"
    cargo build --release --target "$target"
done

# Create directory
mkdir -p "$NATIVE_DIR"

# Create universal library for simulator
echo -e "${YELLOW}Creating universal library for iOS simulator...${NC}"
lipo -create \
    "target/x86_64-apple-ios/release/libsmoldot.a" \
    "target/aarch64-apple-ios-sim/release/libsmoldot.a" \
    -output "$NATIVE_DIR/libsmoldot_sim.a"

# Copy device library
cp "target/aarch64-apple-ios/release/libsmoldot.a" "$NATIVE_DIR/libsmoldot_device.a"

# Create XCFramework (optional, requires Xcode)
if command -v xcodebuild &> /dev/null; then
    echo -e "${YELLOW}Creating XCFramework...${NC}"

    # Create framework structure for device
    mkdir -p "$NATIVE_DIR/device/smoldot.framework/Headers"
    cp "$NATIVE_DIR/libsmoldot_device.a" "$NATIVE_DIR/device/smoldot.framework/smoldot"
    cp "$PROJECT_DIR/native/smoldot.h" "$NATIVE_DIR/device/smoldot.framework/Headers/"

    # Create framework structure for simulator
    mkdir -p "$NATIVE_DIR/simulator/smoldot.framework/Headers"
    cp "$NATIVE_DIR/libsmoldot_sim.a" "$NATIVE_DIR/simulator/smoldot.framework/smoldot"
    cp "$PROJECT_DIR/native/smoldot.h" "$NATIVE_DIR/simulator/smoldot.framework/Headers/"

    # Create XCFramework
    xcodebuild -create-xcframework \
        -framework "$NATIVE_DIR/device/smoldot.framework" \
        -framework "$NATIVE_DIR/simulator/smoldot.framework" \
        -output "$NATIVE_DIR/smoldot.xcframework"

    echo -e "${GREEN}XCFramework created: $NATIVE_DIR/smoldot.xcframework${NC}"
fi

echo -e "${GREEN}iOS build complete!${NC}"
ls -lh "$NATIVE_DIR"/*.a
