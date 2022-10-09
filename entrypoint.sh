#!/bin/bash

# GID=$(id -g)
# sed -e "s/^postgres:x:[^:]*:[^:]*:/postgres:x:$UID:$GID:/" /etc/passwd > /tmp/passwd
# cat /tmp/passwd > /etc/passwd
# rm /tmp/passwd

# if [[ $UID -ge 10000 ]]; then
    # GID=$(id -g)
    # sed -e "s/^postgres:x:[^:]*:[^:]*:/postgres:x:$UID:$GID:/" /etc/passwd > /tmp/passwd
    # cat /tmp/passwd > /etc/passwd
    # rm /tmp/passwd
# fi



exec tail -f /dev/null