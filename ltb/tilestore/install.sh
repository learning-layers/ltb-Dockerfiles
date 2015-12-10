#!/bin/bash
echo "Setting now ltb specific settings, getting the libraries (vendor) ready and populating our database"
if [ $# -lt 3 ]; then
    echo "you are sending not enough arguments";
    echo "Usage: sh install.sh <LTB_API_URI> <LTB_TS_URI> <LTB_TS_HOME_DIR>"
    exit;
fi
LTB_TS_HOME_DIR="$3";
CURRENT_DIR="/home/ltb";
# Go to the installer directory
cd $LTB_TS_HOME_DIR;

ltb_api_file="app/www/components/ltb-api/ltb-api.js";
sed -i "s#LTB_API_URI#$1#g" ltb_api_file && \
sed -i "s#LTB_TS_URI#$2#g" ltb_api_file && \
sed -i "s#from_docker_false#from_docker_true#g" ltb_api_file && \
sed -i "s#LTB_HOME_DIR#$LTB_TS_HOME_DIR#g" /etc/apache2/apache2.conf && \
echo "Finished installing the LTB-TS";
sleep 10;