FROM hotio/dotnetcore@sha256:95f0ed9f7d1c7b64f799365b8a11c0a01c34966bb6c9307174a2969e4c228ccc

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

ARG LIDARR_VERSION=0.7.1.1660

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    rm -f "${APP_DIR}/fpcalc" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
