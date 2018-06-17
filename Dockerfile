FROM alpine:latest
WORKDIR /app/
COPY ./go-guess .
ENTRYPOINT [ "./go-guess" ]
