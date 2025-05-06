# 1) Build stage
FROM golang:1.23-alpine AS builder
WORKDIR /app

# Cache module downloads
COPY go.mod go.sum ./
RUN go mod download

# Build the binary
COPY . .
RUN go build -o server .

# 2) Final stage
FROM alpine:latest
WORKDIR /root/

# Copy the binary
COPY --from=builder /app/server .

# Expose port inside container (choose 8080)
EXPOSE 8080

# Run the service
CMD ["./server"]
