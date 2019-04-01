FROM linuxserver/webgrabplus as base

RUN \
    echo "**** Install necessary packages ****" && \
    apt update && \
    apt install -y php php-curl \
                   build-essential libexpat1-dev && \
    cpan install XML::DOM && \
    echo "**** cleanup ****" && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        $HOME/.cpan/build



FROM base as final

COPY /root /

RUN \
    echo "**** install DeBaschdi EPGScripts ****" && \
    curl -o \
    /tmp/scripts.zip -L \
    https://github.com/DeBaschdi/EPGScripts/archive/master.zip && \
    unzip -q /tmp/scripts.zip -d /app/ && \
    mv /app/EPGScripts-master /app/epgscripts && \
    echo "**** Remove original siteini.pack ****" && \
    rm -rf /defaults/ini/siteini.pack && \
    echo "**** Install DeBaschdi siteini.pack ****" && \
    curl -o \
    /tmp/ini.zip -L \
    https://github.com/DeBaschdi/webgrabplus-siteinipack/archive/master.zip && \
    unzip -q /tmp/ini.zip -d /defaults/ini/ && \
    mv /defaults/ini/webgrabplus-siteinipack-master/siteini.pack /defaults/ini/siteini.pack && \
    rm -rf /defaults/ini/webgrabplus-siteinipack-master/

RUN sed -i 's:127.0.0.1:nginx:g' /defaults/ini/siteini.pack/Germany/web.magentatv.de.ini && \
    sed -i 's:<retry time-out="5">4</retry>:<retry time-out="10">4</retry>:g' /defaults/WebGrab++.config.xml && \
    sed -i 's:/my/path/to/php/helperscripts:/app/epgscripts/imdbmapper:g' /app/epgscripts/imdbmapper/imdbmapper.pl

RUN chmod 777 /app/full-update.sh && \
    chmod 777 /app/epgscripts/genremapper/genremapper.pl && \
    chmod -R 777 /app/epgscripts/imdbmapper/ && \
    chmod 777 /app/epgscripts/ratingmapper/ratingmapper.pl
