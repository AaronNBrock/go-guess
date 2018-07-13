FROM golang:alpine
# Install tools
RUN apk update
RUN apk add docker
RUN apk add make
RUN apk add git
RUN apk add jq

# Setup project files
WORKDIR /go/src/github.com/AaronNBrock/go-guess
COPY . .

# Define Entrypoints
VOLUME [ "/var/run/docker.sock" ]
ENTRYPOINT [ "make" ]
CMD [ "docker-deploy" ]