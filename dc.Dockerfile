ARG GO_VERSION=1.17
ARG VERSION
FROM docker-hub-remote.dr.corp.adobe.com/golang:${GO_VERSION}-alpine AS builder
WORKDIR /build
COPY go.* /build/
RUN go mod download
COPY . /build
WORKDIR /build/cmd/kured
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-X main.version=$VERSION" -o $@ cmd/kured/*.go
FROM docker-hub-remote.dr.corp.adobe.com/alpine:3.14
COPY --from=builder /build/cmd/kured /
RUN apk update --no-cache && apk upgrade --no-cache && apk add --no-cache ca-certificates tzdata
COPY ./cmd/kured /usr/bin/kured
ENTRYPOINT ["/usr/bin/kured"]
