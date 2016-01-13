#!/bin/bash
echo "Starting the Learning Layers Toolbox from Windows env";
find ./ltb-Dockerfiles -type f -exec dos2unix {} \;
find ./layersbox -type f -exec dos2unix {} \;
dos2unix ./box_start.sh; # Only used in old Docker process
# dos2unix ./old_box_start.sh;
#dos2unix ./ltb_api_start.sh; # Only used in old Docker process
#dos2unix ./ltb_ts_start.sh; # Only used in old Docker process
dos2unix ./terminal_open.sh;

echo "Conversion to Unix file format completed for Unix scripts. Starting up docker process...";
sleep 6;
sh box_start.sh $@;
