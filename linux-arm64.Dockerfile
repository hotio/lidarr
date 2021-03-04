FROM hotio/base@sha256:6069ceeb6aec1a4b29e8d4bcc531a9cd5fdca9ccddf2e0d639e4a9b9727ce0d0

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libchromaprint-tools libicu66 && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://lidarr.servarr.com/v1/update/develop/updatefile?version=${VERSION}&os=linux&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    rm -f "${APP_DIR}/bin/fpcalc" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
