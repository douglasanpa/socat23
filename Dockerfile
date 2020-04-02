FROM alpine:3.2

COPY download.sh buildopenssl.sh buildsocat.sh /

RUN apk add --no-cache bash curl tar gzip perl make gcc g++ linux-headers readline coreutils &&\
    chmod +x /download.sh &&\
    chmod +x /build*.sh
RUN /download.sh
RUN /buildopenssl.sh
RUN /buildsocat.sh

CMD ["socat23", "-h"]
