# Setup build image
FROM elixir:1.14.2-alpine AS builder

# Install build dependencies
RUN apk update && \
    apk add --no-cache \
    bash \
    build-base \
    curl \
    git \
    libgcc \
    python3 \
    fish

# Install rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV RUSTUP_HOME=/root/.rustup \
    RUSTFLAGS="-C target-feature=-crt-static" \
    CARGO_HOME=/root/.cargo  \
    PATH="/root/.cargo/bin:$PATH"

