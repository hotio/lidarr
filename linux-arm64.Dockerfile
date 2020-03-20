FROM hotio/dotnetcore@sha256:817f18af01df8e9710c836e6b9e7b7f27a87141c6b1e6d243bbc3e818576c3e7

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

ARG LIDARR_VERSION=0.7.1.1652

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    rm -f "${APP_DIR}/fpcalc" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
