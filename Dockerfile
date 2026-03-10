FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git
RUN CGO_ENABLED=0 go install tailscale.com/cmd/derper@latest

FROM alpine:3.19
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/derper /usr/local/bin/derper

ENV PORT=8080

EXPOSE 8080

CMD derper \
    --hostname=127.0.0.1 \
    --http-port=${PORT} \
    --stun=false \
    --verify-clients=false \
    --a=:${PORT} \
    --certmode=manual
