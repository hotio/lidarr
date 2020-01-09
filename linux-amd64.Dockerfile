FROM hotio/dotnetcore@sha256:f22c5a01c4df92ff8ab56f61783774fac8c4e335379cf483875659c08a30a4a8

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# https://services.lidarr.audio/v1/update/nightly/changes?os=linux
ARG LIDARR_VERSION=0.7.1.1604

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
