FROM golang:1.22-alpine AS builder
RUN go install tailscale.com/cmd/derper@latest

FROM alpine:3.19
COPY --from=builder /go/bin/derper /usr/local/bin/derper
EXPOSE 8443
CMD ["derper", "--hostname=0.0.0.0", "--http-port=8443", "--stun=false", "--verify-clients=false", "--a=:8443"]
