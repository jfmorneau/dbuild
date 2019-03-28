FROM ubuntu:18.04
MAINTAINER Jean-Francois Morneau <jf@jfzone.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update && apt-get -y install \
	bc \
	build-essential \
	cpio \
	curl \
	git \
	libncurses5-dev \
	openssl \
	gosu \
	python \
	sudo \
	unzip \
	wget \
    rsync \
    automake \
    autoconf \
	zlib1g-dev \
	libbz2-dev \
	libreadline-dev \
	libffi-dev \
	liblzma-dev \
	nodejs \
	node-gyp \
	nodejs-dev \
	libssl1.0-dev \
    pv \
	npm \
	golang-1.8 \
	golang-1.8-go \
	golang-1.8-go-shared-dev \
	golang-1.8-src \
	libgolang-1.8-std1 \
	jq

RUN npm install -g bower

RUN rm -rf /var/lib/apt/lists/*

COPY build /root/build
COPY env /root/env
COPY entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/build /root/build /root/entrypoint.sh

RUN /usr/lib/go-1.8/bin/go get -v github.com/codeskyblue/gohttpserver
RUN /usr/lib/go-1.8/bin/go install -v github.com/codeskyblue/gohttpserver

EXPOSE 8000
EXPOSE 8080

# webproc release settings
ENV WEBPROC_VERSION 0.2.2
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz
RUN curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc && chmod +x /usr/local/bin/webproc 

CMD ["/root/entrypoint.sh"]
