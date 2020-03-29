FROM hotio/dotnetcore@sha256:0f3e7b1dbd27a9f258d446abcc11060e38710bf05931a070a86d4faec45c22aa

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

ARG LIDARR_VERSION=0.7.1.1660

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/nightly/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
