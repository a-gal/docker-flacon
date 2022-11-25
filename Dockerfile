FROM alpine:3.15 as build
RUN apk add wget unzip build-base cmake qt5-qtbase-dev qt5-qttools-dev uchardet-dev taglib-dev
WORKDIR /tmp
ARG FLACON_VERSION
RUN wget https://github.com/flacon/flacon/archive/refs/tags/${FLACON_VERSION}.zip && unzip ${FLACON_VERSION}.zip
ENV FLACON_FOLDER = flacon-$(echo $FLACON_VERSION | tr -d v)
WORKDIR /tmp/$FLACON_FOLDER/build
RUN cmake .. && make && make install

FROM jlesage/baseimage-gui:alpine-3.15
LABEL \
    org.label-schema.name="docker-flacon" \
    org.label-schema.description="Docker container for flacon" \
    org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
    org.label-schema.vcs-url="https://github.com/a-gal/docker-flacon" \
    org.label-schema.schema-version="1.0"
RUN add-pkg qt5-qtbase qt5-qttools uchardet taglib \
    faac flac lame vorbis-tools opus-tools sox ttaenc vorbisgain wavpack
COPY --from=build /tmp/$FLACON_FOLDER/build/flacon /usr/local/bin/flacon
COPY rootfs/ /
WORKDIR /mediafiles
