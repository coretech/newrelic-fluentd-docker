FROM fluent/fluentd:v1.14.0-1.0
ENV LOG_LEVEL="debug"
ENV BASE_URI="https://log-api.newrelic.com/log/v1"

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && apk upgrade zlib libssl1.1 libcrypto1.1 \
 && sudo fluent-gem install fluent-plugin-newrelic fluent-plugin-multi-format-parser  fluent-plugin-grafana-loki \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

USER fluent
