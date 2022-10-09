FROM postgres:13.3-buster

RUN apt-mark hold postgresql-13 postgresql-client-13 postgresql-client-common
RUN export DEBIAN_FRONTEND=noninteractive \
    && echo 'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";' > /etc/apt/apt.conf.d/01norecommend \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-cache depends patroni | sed -n -e 's/.* Depends: \(python3-.\+\)$/\1/p' \
            | grep -Ev '^python3-(sphinx|etcd|consul|kazoo|kubernetes)' \
            | xargs apt-get install -y vim-tiny curl jq locales git python3-pip python3-wheel procps \
    ## Make sure we have a en_US.UTF-8 locale available
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && pip3 install setuptools \
    && pip3 install 'patroni[etcd]==2.1.4' \
    && PGHOME=/home/postgres \
    && mkdir -p $PGHOME \
    && chown postgres $PGHOME \
    && sed -i "s|/var/lib/postgresql.*|$PGHOME:/bin/bash|" /etc/passwd \
    # Set permissions for OpenShift
    && chmod 775 $PGHOME \
    && chmod 664 /etc/passwd \
    # Clean up
    && apt-get remove -y git python3-pip python3-wheel \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache


RUN sed -e "s/^postgres:x:[^:]*:[^:]*:/postgres:x:1001:1001:/" /etc/passwd > /tmp/passwd

RUN cat /tmp/passwd > /etc/passwd
ADD entrypoint.sh /

EXPOSE 5432 8008
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 EDITOR=/usr/bin/editor
USER postgres
WORKDIR /home/postgres
CMD ["/bin/bash", "/entrypoint.sh"]

# FROM postgres:13.3-buster
# RUN apt-get update -y \
#     && apt-get install -y python3-pip rsync ssh vim
# COPY ./pgbackrest /usr/bin/pgbackrest
# CMD ["postgres"] 
