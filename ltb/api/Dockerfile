FROM layersbox_ltbweb # should be learninglayers/ltb/web
MAINTAINER Edwin Veenendaal <edwin at raycom.com>

# Done in ltbweb : 
# RUN apt-get update
# RUN apt-get install -y php5-mysql
# RUN apt-get install -y git
# RUN a2enmod rewrite

# Clone the sources here

RUN git clone -b b_layersbox https://github.com/learning-layers/LTB-API.git /home/ltb
# Does not work COPY ./../../../../LTB-API $LTB_HOME_DIR # This copies the local mounted windows dir to the image

COPY ./install.sh /home/LTB-API/docker/install.sh
COPY /home/ltb/LTB-API/config/autoload/instance.php.dist /home/LTB-API/config/autoload/instance.php
# This is a tryout
COPY ./vendor/ /home/LTB-API/vendor

# TODO: GET the openid details and create a client etc...RUN docker inspect openidconnect

# Create here the instance.php file dynamic part
CMD sh /home/LTB-API/install.sh $LTB_MYSQL_HOST $LTB_MYSQL_DB $LTB_MYSQL_USER $LTB_MYSQL_PASSWORD $LTB_API_URI $LTB_TS_URI $LTB_API_HOME_DIR $CURRENT_DIR && \
    apache2-foreground
COPY /home/LTB-API/config/autoload/instance.php /etc/ltb/api/instance.php
EXPOSE 8080