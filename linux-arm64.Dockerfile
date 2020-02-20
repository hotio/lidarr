FROM hotio/dotnetcore@sha256:4645191ffe8a667b175c92738f81646ae8575ad2b6d61338825c24fbe5bbf4a5

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# https://services.lidarr.audio/v1/update/nightly/changes?os=linux
ARG LIDARR_VERSION=0.7.1.1639

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
