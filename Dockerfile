FROM alpine

RUN apk update && apk add --no-cache unzip ca-certificates

ADD v2ray.sh /v2ray.sh
RUN chmod +x /v2ray.sh
CMD /v2ray.sh
