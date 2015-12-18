#!/bin/bash
echo "Setting now ltb specific settings, getting the libraries (vendor) ready and populating our database"
CURRENT_DIR="/home/ltb";
# Go to the installer directory
cd $LTB_TS_HOME_DIR;

ltb_api_file="app/www/components/ltb-api/ltb-api.js";
sed -i "s#REPLACE:LTB_API_URI#$LTB_API_URI#g" ltb_api_file && \
sed -i "s#REPLACE:LTB_TS_URI#$LTB_TS_URI#g" ltb_api_file && \
sed -i "s#REPLACE:from_docker_false#from_docker_true#g" ltb_api_file && \
sed -i "s#REPLACE:LTB_HOME_DIR#$LTB_TS_HOME_DIR#g" /etc/apache2/apache2.conf && \
sed -i "s#REPLACE:LTB_DOC_ROOT#$LTB_TS_HOME_DIR#g" /etc/apache2/apache2.conf && \
echo "Finished installing the LTB-TS";
sleep 10;