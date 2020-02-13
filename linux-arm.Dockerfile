FROM hotio/dotnetcore@sha256:528d4e17721bb71d0bbc380b5ca0146e646e1350f5d1407b73999d9ffb467786

ARG DEBIAN_FRONTEND="noninteractive"

ENV UNPACKERR="disabled"

EXPOSE 8686

ARG UNPACKERR_VERSION=0.7.0-beta1

# install unpackerr
RUN curl -fsSL "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" | gunzip | dd of=/usr/local/bin/unpackerr && chmod 755 /usr/local/bin/unpackerr

ARG LIDARR_VERSION=0.7.1.1633

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
