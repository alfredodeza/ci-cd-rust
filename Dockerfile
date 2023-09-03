# Use the official Rust image as a parent image
FROM rust:latest as builder

# Set the working directory in the Docker image
WORKDIR /usr/src/redactr

# Copy the current directory contents into the container at /usr/src/myapp
COPY . .

# Compile the project
RUN cargo build --release

# Start a new stage to create a lean production image
FROM debian:buster-slim

# Copy the binary from the builder stage to the production image
COPY --from=builder /usr/src/redactr/target/release/redactr /usr/local/bin/redactr

# Run the binary
CMD ["redactr"]