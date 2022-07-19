FROM cr.hotio.dev/hotio/base@sha256:3db7ec77346db6ba77750276a1a32ea8426bea78509ebb476fd7cbde1e7b8ef6

EXPOSE 8686

RUN apk add --no-cache libintl sqlite-libs icu-libs chromaprint

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://lidarr.servarr.com/v1/update/develop/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    rm -f "${APP_DIR}/bin/fpcalc" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
