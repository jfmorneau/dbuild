FROM ubuntu:18.04
MAINTAINER Jean-Francois Morneau <jf@jfzone.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update && apt-get -y install \
	bc \
	build-essential \
	cpio \
	curl \
	git-all \
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
	python3 \
	python3-pip \
	golang-1.8 \
	golang-1.8-go \
	golang-1.8-go-shared-dev \
	golang-1.8-src \
	libgolang-1.8-std1 \
	jq \
	net-tools 

# webproc release settings
ENV WEBPROC_VERSION 0.2.2
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz
RUN curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc && chmod +x /usr/local/bin/webproc 

RUN npm install -g bower

RUN pip3 install browsepy remi pywebview


RUN rm -rf /var/lib/apt/lists/*

ENV GOPATH=/root/go

ENV PATH="/root/bin:/root/go/bin:/usr/lib/go-1.8/bin/:${PATH}"

# RUN go get -v github.com/codeskyblue/gohttpserver
# RUN go install -v github.com/codeskyblue/gohttpserver

EXPOSE 8000
EXPOSE 8080


COPY build /root/bin/build
COPY env /root/bin/env
COPY entrypoint.sh /root/bin/entrypoint.sh
COPY cmd.sh /root/bin/cmd.sh

RUN chmod +x /root/bin/build /root/bin/env /root/bin/entrypoint.sh /root/bin/cmd.sh

#ENTRYPOINT [ "/root/bin/entrypoint.sh" ]

WORKDIR /root/

CMD ["/root/bin/cmd.sh"]
