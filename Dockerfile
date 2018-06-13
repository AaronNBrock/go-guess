FROM golang as builder
WORKDIR /go/src/github.com/AaronNBrock/go-guess/
COPY main.go .
RUN go build .

FROM alpine:latest
WORKDIR /app/
COPY --from=builder /go/src/github.com/AaronNBrock/go-guess/go-guess .
ENTRYPOINT [ "./go-guess" ]
