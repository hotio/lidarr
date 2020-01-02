FROM hotio/dotnetcore@sha256:7936c472229a905302881cd7df06b0ea45994a4cf1f710b940ec0f9c6e97857e

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# https://services.lidarr.audio/v1/update/nightly/changes?os=linux
ARG LIDARR_VERSION=0.7.1.1593

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
