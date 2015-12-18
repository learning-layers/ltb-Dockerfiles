#!/bin/bash
echo "Setting now ltb specific settings, getting the libraries (vendor) ready and populating our database"

# create LTB database and user
# echo "Creating LTB database and user..." &&
# LTB_DB_PASSWORD=`docker run --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $LTB_DB_NAME --new-user $LTB_DB_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` &&
# echo " -> done" &&
# echo "" &&

CURRENT_DIR="/home/ltb";
LTB_UNIX_LOG="${LTB_HOME_DIR}/data/ltb_io_debug.log";
echo "What will be the label for the learning toolbox?";
read LEARNINGTOOLBOX_LABEL
# Go to the installer directory
cd $LTB_HOME_DIR;
settings_file=config/autoload/instance.php
sudo chown :www-data data && \
sudo chmod g+w data && \
cp -f config/autoload/instance.php.dist $settings_file && \
sed -i "s#REPLACE:LTB_MYSQL_HOST#$LTB_MYSQL_HOST#g" $settings_file && \
sed -i "s#REPLACE:LTB_DB_NAME#$LTB_DB_NAME#g" $settings_file && \
sed -i "s#REPLACE:LTB_DB_USER#$LTB_DB_USER#g" $settings_file && \
sed -i "s#REPLACE:LTB_DB_PASSWORD#$LTB_DB_PASSWORD#g" $settings_file && \
sed -i "s#REPLACE:LTB_API_URI#$LTB_API_URI#g" $settings_file && \
sed -i "s#REPLACE:LTB_TS_URI#$LTB_TS_URI#g" $settings_file && \
sed -i "s#REPLACE:LTB_HOME_DIR#$LTB_HOME_DIR#g" $settings_file && \
sed -i "s#REPLACE:LTB_UNIX_LOG#$LTB_UNIX_LOG#g" $settings_file && \
sed -i "s#REPLACE:OIDC_URI#$OIDC_URI#g" $settings_file && \
sed -i "s#REPLACE:OIDC_CLIENT#$OIDC_CLIENT#g" $settings_file && \
sed -i "s#REPLACE:OIDC_SECRET#$OIDC_SECRET#g" $settings_file && \
sed -i "s#REPLACE:SSS_URI#http://test-ll.know-center.tugraz.at/ltb-v2/#g" $settings_file && \
sed -i "s#REPLACE:LTB_HOME_DIR#$LTB_API_HOME_DIR#g" /etc/apache2/apache2.conf && \
sed -i "s#REPLACE:LTB_DOC_ROOT#$LTB_API_HOME_DIR#g" /etc/apache2/apache2.conf && \

# ($LTB_VENDOR_AVAILABLE && mv /tmp/vendor /home/LTB-API) || (echo "Starting download of vendor software" && cd /home/LTB-API && php composer.phar install) && \
# Determine whether in this docker context a vendor directory is made available
 if [[ -d ${LTB_HOME_DIR}/vendor ]] && [[ -f "${LTB_HOME_DIR}/vendor.autoload.php" ]]; then
    echo "Vendor files are already there! Will be copied into container";
    LTB_VENDOR_AVAILABLE=1;
   #  cp -rp ${CURRENT_DIR}/vendor .;
else
    
    echo "Vendor files are not there yet...";

    if [ ! -d ~/.ssh ]; then
        mkdir ~/.ssh;
    fi
    if [ ! -f ~/.ssh/config ]; then
        touch ~/.ssh/config;
    fi
    echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config;
    echo "Starting download of vendor software";
    php composer.phar install;
    echo "Finished installing libraries";
    LTB_VENDOR_AVAILABLE=0;
fi &&
echo "Installing the tables now of the LTB-API" && \
mysql -u $3 --password=$4 -h $1 $2 < data/ltb-api-db.sql && \
echo "Finished installing the LTB-API";