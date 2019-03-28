#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

if [[ -z ${UID} ]] ; then
    UID=1000
fi

if [[ -z ${GID} ]] ; then
    GID=1000
fi

groupadd -g ${GID} jf

useradd -d /home/jf -u ${UID} -g $GID -m jf

echo "Starting with UID:GID : ${UID}:${GID}"
export HOME=/home/jf

mkdir $HOME/.npm

chown jf:jf $HOME
chown jf:jf $HOME/git
chown jf:jf $HOME/.npm

cd $HOME/git/20-os

exec /usr/local/bin/gosu jf "$@"
