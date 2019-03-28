#!/bin/bash
docker-compose exec -T webgrab s6-setuidgid abc /bin/bash /defaults/update.sh
