FROM alpine:3.2


COPY download.sh buildopenssl.sh buildsocat.sh /

RUN apk add --no-cache bash curl tar gzip perl make gcc g++ linux-headers readline coreutils &&\
    chmod +x /download.sh && /download.sh &&\
    chmod +x /buildopenssl.sh && /buildopenssl.sh &&\
    chmod +x /buildsocat.sh && /buildsocat.sh &&\
    apk del tar gzip perl make gcc g++ linux-headers readline coreutils

CMD ["socat23"]
