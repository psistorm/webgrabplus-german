#!/bin/bash
echo "Reading configuration"
file="/config/update.properties"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval ${key}=\${value}
  done < "$file"

  echo "Use genremapper="${genremapper}
  echo "Use imdbmapper="${imdbmapper}
  echo "Use ratingmapper="${ratingmapper}
else
  echo "$file not found."
fi


echo "Starting WebGrab++"

cd /app/wg++/bin || exit
mono WebGrab+Plus.exe  "/config"

sleep 5

echo "Starting postprocessing"

cd /data || exit
mv /data/guide.xml /data/guide.xml.tmp

if [ "${genremapper}" = "true" ]; then
  echo "Starting genremapper"
  /app/epgscripts/genremapper/genremapper.pl < /data/guide.xml.tmp > /data/guide-enriched.xml.tmp
  mv -f /data/guide-enriched.xml.tmp /data/guide.xml.tmp
fi

if [ "${imdbmapper}" = "true" ]; then
  echo "Starting imdbmapper"
  /app/epgscripts/imdbmapper/imdbmapper.pl /data/guide.xml.tmp > /data/guide-enriched.xml.tmp
  mv -f /data/guide-enriched.xml.tmp /data/guide.xml.tmp
fi

if [ "${ratingmapper}" = "true" ]; then
  echo "Starting ratingmapper"
  /app/epgscripts/ratingmapper/ratingmapper.pl /data/guide.xml.tmp > /data/guide-enriched.xml.tmp
  mv -f /data/guide-enriched.xml.tmp /data/guide.xml.tmp
fi

mv /data/guide.xml.tmp /data/guide.xml

exit 0
