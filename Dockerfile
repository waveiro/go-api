############# 1. Build stage #############################################
FROM golang:1.23-alpine AS builder          # or the latest Go x.y-alpine tag

# Install build tools you might need
RUN apk add --no-cache git

WORKDIR /src

# Copy only go.mod first – makes use of layer‑caching
COPY go.mod ./
RUN go mod download

# Copy the rest of the source code and compile
COPY . .
# ‑trimpath strips source paths; CGO_ENABLED=0 makes a static binary
RUN CGO_ENABLED=0 go build -trimpath -o /app/main .

############# 2. Runtime stage ###########################################
# Use the tiniest possible runtime image that still has a shell & SSL certs
FROM alpine:3.20

WORKDIR /app
COPY --from=builder /app/main .

# Add TLS root certificates so Go’s net/http can talk HTTPS endpoints
RUN apk add --no-cache ca-certificates

EXPOSE 8080
ENTRYPOINT ["./main"]
