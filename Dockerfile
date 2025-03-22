# Use official Elixir image
FROM elixir:1.15-alpine

# Install build dependencies including rebar3 globally
RUN apk add --no-cache build-base git curl && \
    mix local.hex --force && \
    mix local.rebar --force && \
    curl -fsSL -o /usr/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 && \
    chmod +x /usr/bin/rebar3

# Set working directory
WORKDIR /app

# Cache Elixir deps
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod

# Copy full project
COPY . /app/.

# Compile project
RUN mix deps.get && mix compile

# Start the app
CMD ["mix", "run", "--no-halt"]
