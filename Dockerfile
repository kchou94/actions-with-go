FROM golang:1.17.3-alpine3.14 AS builder

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

RUN mkdir /pro
ADD ./usePost05.go /pro/
WORKDIR /pro
RUN go get -d -v ./...
RUN go build -o server usePost05.go

FROM alpine:latest

RUN mkdir /pro
COPY --from=builder /pro/server /pro/server
WORKDIR /pro
CMD ["/pro/server"]
