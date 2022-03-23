FROM fluent/fluentd:v1.14-1
#ENV LOG_LEVEL="info"
#ENV BASE_URI="https://log-api.newrelic.com/log/v1"

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev nano \
 && sudo fluent-gem install fluent-plugin-newrelic fluent-plugin-http-healthcheck \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /home/fluent/.gem/ruby/*/cache/*.gem \

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

USER fluent
