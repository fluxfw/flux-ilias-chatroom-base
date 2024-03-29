ARG NODEJS_VERSION
FROM node:$NODEJS_VERSION-alpine

RUN getent group www-data || addgroup -g 82 www-data && adduser -u 82 -D -S -G www-data www-data

ENV ILIAS_WEB_DIR /var/www/html
RUN mkdir -p "$ILIAS_WEB_DIR" && chown www-data:www-data -R "$ILIAS_WEB_DIR"

ENV ILIAS_FILESYSTEM_DATA_DIR /var/iliasdata
RUN mkdir -p "$ILIAS_FILESYSTEM_DATA_DIR" && chown www-data:www-data -R "$ILIAS_FILESYSTEM_DATA_DIR"

USER www-data:www-data

ENTRYPOINT ["/flux-ilias-chatroom-base/bin/server.sh"]

COPY . /flux-ilias-chatroom-base
