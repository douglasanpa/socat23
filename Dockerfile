FROM alpine:3.2


RUN apk add --no-cache bash curl tar gzip perl make gcc g++ linux-headers readline coreutils

COPY download.sh /
RUN chmod +x /download.sh && /download.sh

COPY buildopenssl.sh /
RUN chmod +x /buildopenssl.sh && /buildopenssl.sh

COPY buildsocat.sh /
RUN chmod +x /buildsocat.sh && /buildsocat.sh

CMD ["socat23"]
