ARG NODEJS_VERSION
FROM node:$NODEJS_VERSION-alpine

LABEL org.opencontainers.image.source="https://github.com/flux-caps/flux-ilias-chatroom-base"
LABEL maintainer="fluxlabs <support@fluxlabs.ch> (https://fluxlabs.ch)"

RUN getent group www-data || addgroup -g 82 www-data && adduser -u 82 -D -S -G www-data www-data

ENV ILIAS_WEB_DIR /var/www/html
RUN mkdir -p "$ILIAS_WEB_DIR" && chown www-data:www-data -R "$ILIAS_WEB_DIR"

ENV ILIAS_FILESYSTEM_DATA_DIR /var/iliasdata
RUN mkdir -p "$ILIAS_FILESYSTEM_DATA_DIR" && chown www-data:www-data -R "$ILIAS_FILESYSTEM_DATA_DIR"
VOLUME $ILIAS_FILESYSTEM_DATA_DIR

USER www-data:www-data

ENV ILIAS_CHATROOM_PORT 8080
EXPOSE $ILIAS_CHATROOM_PORT

ENTRYPOINT ["/flux-ilias-chatroom-base/bin/docker-entrypoint.sh"]

COPY . /flux-ilias-chatroom-base

ARG COMMIT_SHA
LABEL org.opencontainers.image.revision="$COMMIT_SHA"
