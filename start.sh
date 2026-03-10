#!/bin/sh

HOSTNAME="${DERP_HOSTNAME:-localhost}"
CERTDIR="/certs"
PORT="${PORT:-8080}"

mkdir -p "$CERTDIR"

# Generate self-signed cert with matching hostname
openssl req -x509 -newkey rsa:2048 \
    -keyout "$CERTDIR/$HOSTNAME.key" \
    -out "$CERTDIR/$HOSTNAME.crt" \
    -days 3650 -nodes \
    -subj "/CN=$HOSTNAME" 2>/dev/null

echo "Starting DERP server on port $PORT..."

exec derper \
    --hostname="$HOSTNAME" \
    --certmode=manual \
    --certdir="$CERTDIR" \
    --http-port="$PORT" \
    --a=:0 \
    --stun=false \
    --verify-clients=false
