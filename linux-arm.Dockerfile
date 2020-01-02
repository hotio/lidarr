FROM hotio/mono@sha256:4ccd258253b44c093872e80592eb1f76c9e61f58f7333054d1e2d14868bb039b

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

# https://github.com/lidarr/Lidarr/releases
ARG LIDARR_VERSION=0.7.1.1381

# install app
RUN curl -fsSL "https://github.com/lidarr/Lidarr/releases/download/v${LIDARR_VERSION}/Lidarr.master.${LIDARR_VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
