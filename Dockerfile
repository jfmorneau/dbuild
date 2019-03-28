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
	jq

RUN npm install -g bower

RUN rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["bash"]
