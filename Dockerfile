ARG BASE_FINAL_IMAGE=alpine:3.22
ARG BASE_BUILD_IMAGE=golang:1.25.2-alpine

FROM ${BASE_BUILD_IMAGE} AS GOLANG
WORKDIR /src
ARG USER
ARG TOKEN
RUN apk --no-cache add make git gcc libtool musl-dev ca-certificates dumb-init \
  && go install golang.org/x/vuln/cmd/govulncheck@latest \
  && go env -w GOPRIVATE="github.com/cloudbees-compliance/*,github.com/calculi-corp/*" \
  && git config --global url."https://${USER}:${TOKEN}@github.com".insteadOf  "https://github.com"
COPY go.mod go.sum /src/
# RUN go mod download && go mod verify
COPY . /src
RUN go test -short ./...
RUN govulncheck ./... || true
RUN go build -o /tmp/myapp \
        -ldflags="-linkmode 'external' -extldflags '-static'" --buildvcs=0 \
  && go version /tmp/myapp

FROM ${BASE_FINAL_IMAGE}
WORKDIR /app/
RUN apk --no-cache add curl lsof ca-certificates \
  && adduser -D nonpriv # create user and group
USER nonpriv
COPY --from=GOLANG /tmp/myapp /app/myapp
CMD ["/app/myapp", "start"]