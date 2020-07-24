FROM hotio/base@sha256:4f26fe7bb656f83929e2da7622aed5267975bcf8ee523b6f3068ca024bcc1717

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

ARG LIDARR_VERSION
ARG PACKAGE_VERSION=${LIDARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://lidarr.servarr.com/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=nightly" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
