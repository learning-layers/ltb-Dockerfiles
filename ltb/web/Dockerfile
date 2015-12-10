FROM learninglayers/httpd
MAINTAINER Edwin Veenendaal <edwin at raycom.com>

COPY ./apache_ltb.conf /etc/apache2/apache2.conf
RUN apt-get update
RUN apt-get install -y git mysql-client php5-mysql
RUN a2enmod rewrite