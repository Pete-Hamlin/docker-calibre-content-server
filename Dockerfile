# syntax=docker/dockerfile:1
FROM debian:12-slim

# set version labels
ARG BUILD_DATE=$(date +%D)
ARG VERSION=0.1.0
ARG CALIBRE_VERSION=7.24.0
ARG CALIBRE_URL="https://download.calibre-ebook.com/${CALIBRE_VERSION}/calibre-${CALIBRE_VERSION}-x86_64.txz"
LABEL MAINTAINER="Pete Hamlin github@pete-hamlin.com"

# prep system
RUN \
  echo "---===>>> prep system <<<===---" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  libfontconfig \
  libgl1 \
  python3 \
  wget \
  libegl1 \
  libxkbcommon0 \
  libopengl0 \
  libnss3 \
  jq \
  xz-utils && \
  echo "---===>>> cleanup <<<===---" && \
  apt autoremove -y && \
  apt-get clean && \
  rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/

# install calibe
RUN \
  echo "---===>>> install calibre <<<===---" && \
  mkdir -p /opt/calibre && \
  curl -o \
    /tmp/calibre-tarball.txz -L \
    $CALIBRE_URL && \ 
    tar xvf /tmp/calibre-tarball.txz -C /opt/calibre && \
  rm -rf -- /tmp/calibre-tarball.txz

# create directories
RUN mkdir /data && mkdir /scripts

# add startup.sh
ADD startup.sh /scripts/startup.sh
RUN chmod 755 /scripts/startup.sh

VOLUME /data/library
EXPOSE 8080

CMD ["/scripts/startup.sh"]
