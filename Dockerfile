FROM hotio/mono

ARG DEBIAN_FRONTEND="noninteractive"
ARG GIT_COMMIT
ARG GIT_TAG
ARG ARCH

ENV GIT_COMMIT="${GIT_COMMIT}" GIT_TAG="${GIT_TAG}" ARCH="${ARCH}"
ENV APP="Lidarr"
EXPOSE 8686
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8686 || exit 1

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libchromaprint-tools && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# install app
# https://github.com/lidarr/Lidarr/releases
RUN curl -fsSL "https://github.com/lidarr/Lidarr/releases/download/v0.6.2.883/Lidarr.develop.0.6.2.883.linux.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
