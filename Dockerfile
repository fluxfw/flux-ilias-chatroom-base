ARG NODEJS_IMAGE=node:current-alpine

FROM $NODEJS_IMAGE

LABEL org.opencontainers.image.source="https://github.com/fluxapps/flux-ilias-chatroom-base"
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

ENTRYPOINT ["/flux-ilias-chatroom-base/bin/entrypoint.sh"]

COPY . /flux-ilias-chatroom-base
