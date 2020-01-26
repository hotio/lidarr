FROM hotio/dotnetcore:focal

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8686

ARG LIDARR_VERSION=0.7.1.1595
ARG LIDARR_BRANCH=fix-history-orhpan-tracks

# install app
RUN curl -fsSL "https://services.lidarr.audio/v1/update/${LIDARR_BRANCH}/updatefile?version=${LIDARR_VERSION}&os=linux&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/Lidarr.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
