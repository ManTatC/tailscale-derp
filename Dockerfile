FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git
RUN CGO_ENABLED=0 go install tailscale.com/cmd/derper@latest

FROM alpine:3.19
RUN apk add --no-cache ca-certificates openssl

COPY --from=builder /go/bin/derper /usr/local/bin/derper

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
