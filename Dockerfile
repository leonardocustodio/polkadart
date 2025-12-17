# Polkadart Test Runner
# Build: docker build -t polkadart .
# Usage: docker run --rm polkadart [command]

FROM dart:stable

# Install Rust toolchain
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
COPY . .

# Install Dart dependencies
RUN dart pub get

# Build smoldot Rust library
RUN cd packages/smoldot/rust && \
    cargo build --release && \
    mkdir -p ../native/linux && \
    cp target/release/libsmoldot.so ../native/linux/

# Default: run all tests including chain tests
# Override with: docker run polkadart dart run melos run analyze
CMD ["sh", "-c", "dart run melos run test && dart run melos run test:chain"]

# Examples:
#   docker run --rm polkadart                                              # Run all tests
#   docker run --rm polkadart dart run melos run analyze                   # Run analyzer
#   docker run --rm polkadart dart run melos run format                    # Check formatting
#   docker run --rm -e SCOPE=polkadart polkadart                           # Test specific package
#   docker run --rm -it polkadart bash                                     # Interactive shell
