FROM hotio/mono@sha256:8dd34fb9f8fb3824f535807ffb5fdbade8e0fc7087d5a48b2adfe8360409acca

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libchromaprint-tools && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG LIDARR_VERSION=0.7.1.1381

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/develop/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=mono" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
