FROM hotio/dotnetcore@sha256:71eacddba2049349b101b0e0fc8a83a0b61284ab7762755497e54097f4cda041

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# https://services.lidarr.audio/v1/update/nightly/changes?os=linux
ARG LIDARR_VERSION=0.7.1.1641

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
