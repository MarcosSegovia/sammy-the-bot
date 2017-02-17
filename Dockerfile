FROM alpine:latest
MAINTAINER Marcos Segovia <velozmarkdrea@gmail.com>

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

COPY . /go/src/github.com/MarcosSegovia/sammy-the-bot

RUN apk add --update git go make musl-dev &&\
    git config --global http.sslVerify true &&\
    apk add --no-cache ca-certificates &&\
    go get github.com/Masterminds/glide &&\
    cd /go/src/github.com/Masterminds/glide &&\
    make install &&\
    cd /go/src/github.com/MarcosSegovia/sammy-the-bot &&\
    glide install &&\
    go build -o sammy-the-bot &&\
    apk del go git

EXPOSE 80
WORKDIR /go/src/github.com/MarcosSegovia/sammy-the-bot
CMD ["./sammy-the-bot"]
