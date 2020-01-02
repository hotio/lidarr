FROM hotio/mono@sha256:7794be1032777eb0e81b3f1c888c555b6777b1542733a167fc84689755980bfb

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
