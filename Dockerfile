FROM alpine:3.7 as builder

RUN apk add --update curl && \
    mkdir -p /config && \
    curl -Ssl https://raw.githubusercontent.com/coreos/clair/master/config.yaml.sample > \
      /config/config.yml

FROM alpine:3.7

COPY docker-entrypoint.sh /
COPY --from=builder /config/config.yml /config/config.yml

VOLUME /config

ENTRYPOINT ["/docker-entrypoint.sh"]