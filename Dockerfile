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
	net-tools tree

# webproc release settings
ENV WEBPROC_VERSION 0.2.2
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz
RUN curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc && chmod +x /usr/local/bin/webproc 

RUN npm install -g bower

RUN pip3 install browsepy remi pywebview


RUN rm -rf /var/lib/apt/lists/*

# RUN go get -v github.com/codeskyblue/gohttpserver
# RUN go install -v github.com/codeskyblue/gohttpserver

EXPOSE 8000
EXPOSE 8080

RUN useradd -m -U -G sudo jf

RUN echo "jf   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers


VOLUME /home/jf/
VOLUME /home/jf/ccache
VOLUME /home/jf/os
VOLUME /home/jf/os/images
VOLUME /home/jf/os/buildroot/build

RUN mkdir /home/jf/go
RUN mkdir /home/jf/bin

COPY build /home/jf/bin/build
COPY env /home/jf/bin/env
COPY entrypoint.sh /home/jf/bin/entrypoint.sh
COPY cmd.sh /home/jf/bin/cmd.sh

ENV GOPATH=/home/jf/go
ENV PATH="/home/jf/bin:/home/jf/go/bin:/usr/lib/go-1.8/bin/:${PATH}"

RUN chmod +x /home/jf/bin/build /home/jf/bin/env /home/jf/bin/entrypoint.sh /home/jf/bin/cmd.sh

RUN chown -R jf:jf /home/jf

#ENTRYPOINT [ "/home/jf/bin/entrypoint.sh" ]
USER jf

WORKDIR /home/jf

CMD ["bash", "-c", "/home/jf/bin/cmd.sh"]
