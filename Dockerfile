FROM alpine:3.2

COPY build.sh /

RUN apk add --no-cache bash curl tar gzip perl make gcc g++ linux-headers &&\
    chmod +x /build.sh &&\
    /build.sh

CMD ["socat", "-h"]
