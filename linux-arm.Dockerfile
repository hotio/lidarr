FROM hotio/dotnetcore:focal

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

ARG LIDARR_VERSION=0.7.1.1668
ARG LIDARR_BRANCH=fix-move-artist

# install app
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://services.lidarr.audio/v1/update/${LIDARR_BRANCH}/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=arm" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Lidarr.Update" && \
    echo "PackageVersion=${LIDARR_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=${LIDARR_BRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
