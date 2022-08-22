FROM golang:1.19.0-bullseye as builder

WORKDIR /usr/src/app
COPY . .
RUN CGO_ENABLED=0 go build -o /docker-request-logger .

FROM gcr.io/distroless/static-debian11
COPY --from=builder /docker-request-logger /docker-request-logger

ENTRYPOINT ["/docker-request-logger"]
