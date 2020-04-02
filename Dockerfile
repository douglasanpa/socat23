FROM alpine:3.2


COPY build.sh /

RUN apk add --no-cache bash curl tar gzip perl make gcc g++ linux-headers readline coreutils &&\
    chmod +x /build.sh && /build.sh &&\
    apk del tar gzip perl make gcc g++ linux-headers readline coreutils

CMD ["/usr/local/bin/socat23"]
