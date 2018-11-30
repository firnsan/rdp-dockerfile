FROM debian:jessie

RUN buildDeps='wget unzip gcc g++ make cmake libcurl4-openssl-dev libncurses5-dev bison python libbz2-dev' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && wget -O rdp.zip "https://github.com/vipshop/RDP/archive/master.zip" \
    && mkdir -p /usr/src \
    && unzip rdp.zip -d /usr/src \
    && chmod +x /usr/src/RDP-master/build/build.sh \
    && make -C /usr/src/RDP-master \
    && make -C /usr/src/RDP-master install \
    && mkdir -p /apps/svr/rdp_syncer/base/rdp_mysql \
    && mkdir -p /apps/svr/rdp_syncer/data/instance0/conf \
    && cp -r /usr/src/RDP-master/package/*.tgz /apps/svr/rdp_syncer/base/ \
    && tar -xzvf /apps/svr/rdp_syncer/base/*.tgz -C /apps/svr/rdp_syncer/base/rdp_mysql \
    && cp /apps/svr/rdp_syncer/base/rdp_mysql/syncer.cfg.example /apps/svr/rdp_syncer/data/instance0/conf/syncer.cfg \
    && rm -rf /var/lib/apt/lists/* \
    && rm rdp.zip \
    && rm -r /usr/src/RDP-master \
    && apt-get purge -y --auto-remove $buildDeps

CMD bash
