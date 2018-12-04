FROM debian:jessie

RUN buildDeps='wget unzip gcc g++ make cmake libncurses5-dev bison python libbz2-dev' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && apt-get install -y libcurl4-openssl-dev mysql-client \
    && wget -O rdp.zip "https://github.com/vipshop/rdp/archive/master.zip" \
    && mkdir -p /usr/src \
    && unzip rdp.zip -d /usr/src \
    && chmod +x /usr/src/rdp-master/build/build.sh \
    && make -C /usr/src/rdp-master \
    && make -C /usr/src/rdp-master install \
    && mkdir -p /apps/svr/rdp_syncer/base/rdp_mysql \
    && mkdir -p /apps/svr/rdp_syncer/data/10000/conf \
    && tar -xzvf /usr/src/rdp-master/package/*.tgz -C /apps/svr/rdp_syncer/base/rdp_mysql \
    && cp /apps/svr/rdp_syncer/base/rdp_mysql/syncer.cfg.example /apps/svr/rdp_syncer/data/10000/conf/syncer.cfg \
    && rm -rf /var/lib/apt/lists/* \
    && rm rdp.zip \
    && rm -r /usr/src/rdp-master \
    && apt-get purge -y --auto-remove $buildDeps

CMD ["bash"]
