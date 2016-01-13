#!/bin/bash
if [ "$#" -eq 1 ]; then
    container="$1";
else
    container="learningtoolbox-api";
fi
docker exec -it $container /bin/bash