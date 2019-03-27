FROM linuxserver/webgrabplus

RUN \
    echo "**** install DeBaschdi EPGScripts ****" && \
    curl -o \
    /tmp/scripts.zip -L \
    https://github.com/DeBaschdi/EPGScripts/archive/master.zip && \
    unzip -q /tmp/scripts.zip -d /app/ && \
#    rm -rf /defaults/ini/siteini.pack && \
    echo "**** Install DeBaschdi siteini.pack ****" && \
    curl -o \
    /tmp/ini.zip -L \
    https://github.com/DeBaschdi/webgrabplus-siteinipack/archive/master.zip && \
    unzip -q /tmp/ini.zip -d /defaults/ini/ && \
    mv /defaults/ini/webgrabplus-siteinipack-master/siteini.user /defaults/ini/ && \
    rm -rf /defaults/ini/webgrabplus-siteinipack-master && \
    echo "**** cleanup ****" && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

RUN sed -i 's:127.0.0.1:web:g' /defaults/ini/siteini.pack/Germany/web.magentatv.de.ini 

RUN chmod 777 /app/EPGScripts-master/genremapper/genremapper.pl
RUN chmod -R 777 /app/EPGScripts-master/imdbmapper/
RUN sed -i -e 17c'my $path= "/app/EPGScripts-master/imdbmapper" ;' /app/EPGScripts-master/imdbmapper/imdbmapper.pl
RUN chmod 777 /app/EPGScripts-master/ratingmapper/ratingmapper.pl
