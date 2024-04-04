FROM jlesage/baseimage-gui:alpine-3.19-v4 as build
RUN apk add wget unzip build-base cmake qt5-qtbase-dev qt5-qttools-dev uchardet-dev taglib-dev
# WORKDIR /tmp
COPY src /src
# ARG FLACON_VERSION=9.5.1
# RUN wget https://github.com/flacon/flacon/archive/refs/tags/v${FLACON_VERSION}.zip && unzip v${FLACON_VERSION}.zip
WORKDIR /src/build
RUN cmake .. && make && make install

FROM jlesage/baseimage-gui:alpine-3.19-v4
# ARG FLACON_VERSION=9.5.1
LABEL \
    org.label-schema.name="docker-flacon" \
    org.label-schema.description="Docker container for flacon" \
    org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
    org.label-schema.vcs-url="https://github.com/a-gal/docker-flacon" \
    org.label-schema.schema-version="1.0"
RUN add-pkg qt5-qtbase qt5-qttools uchardet taglib fontconfig \
    faac flac lame vorbis-tools opus-tools sox ttaenc vorbisgain wavpack
# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/flacon/flacon/raw/master/images/mainicon/flacon-512x512.png && \
    install_app_icon.sh "$APP_ICON_URL"
# Set name
RUN set-cont-env APP_NAME "Flacon"

COPY --from=build /usr/local/bin/flacon /usr/local/bin/flacon
COPY --from=build /usr/local/share/flacon /usr/local/share/flacon
COPY rootfs/ /
WORKDIR /mediafiles
