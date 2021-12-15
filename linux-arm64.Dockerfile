FROM cr.hotio.dev/hotio/base@sha256:c96bfafa6be3ecc00ad9f64d5b45afc2c7957dec6c430c244a182729b3c10184

EXPOSE 8686

RUN apk add --no-cache libintl sqlite-libs icu-libs && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community chromaprint

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://lidarr.servarr.com/v1/update/master/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    rm -f "${APP_DIR}/bin/fpcalc" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=master" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
