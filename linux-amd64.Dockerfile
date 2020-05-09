FROM hotio/dotnetcore@sha256:cc6f42a1df7e057f4429428e89790668a5fc7c9cdc37419669bf904587c4e212

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

ARG LIDARR_VERSION
ARG PACKAGE_VERSION=${LIDARR_VERSION}

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://lidarr.servarr.com/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=nightly" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
