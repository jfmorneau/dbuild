#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback


cd /root/go/src/github.com/codeskyblue/gohttpserver

/root/go/bin/gohttpserver --root=/root/os/images &

webproc -c /root/env,/root/build /root/build &

bash
