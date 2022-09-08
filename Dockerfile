FROM golang:alpine as BUILDER

WORKDIR /src

RUN go mod init example/hello
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o main main.go

FROM scratch as PROD

WORKDIR /app

COPY --from=builder /src/main .

CMD ["./main"]