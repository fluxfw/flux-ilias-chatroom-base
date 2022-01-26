ARG NODEJS_IMAGE=node:current-alpine

FROM $NODEJS_IMAGE

LABEL org.opencontainers.image.source="https://github.com/fluxapps/flux-ilias-chatroom-base"
LABEL maintainer="fluxlabs <support@fluxlabs.ch> (https://fluxlabs.ch)"

COPY . /flux-ilias-chatroom-base

ENTRYPOINT ["/flux-ilias-chatroom-base/bin/entrypoint.sh"]

ENV ILIAS_WEB_DIR /var/www/html

ENV ILIAS_FILESYSTEM_DATA_DIR /var/iliasdata
RUN mkdir -p "$ILIAS_FILESYSTEM_DATA_DIR"
VOLUME $ILIAS_FILESYSTEM_DATA_DIR

ENV ILIAS_CHATROOM_PORT 8080
EXPOSE $ILIAS_CHATROOM_PORT
