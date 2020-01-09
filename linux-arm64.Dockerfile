FROM hotio/dotnetcore@sha256:4524ea84157df940f79f724a59d86e1e17d766ef6406875126835a7a94d7d277

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# https://services.lidarr.audio/v1/update/nightly/changes?os=linux
ARG LIDARR_VERSION=0.7.1.1604

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
