FROM ubuntu:18.04

LABEL name="toto"
LABEL version="1.0"
LABEL description="Traction web container \
this is very much work in progress."

# Install apache, PHP, and supplimentary programs. openssh-server, curl,
# and lynx-cur are for debugging the container.
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
apt-utils apache2 php7.2-common php7.2-cli php7.2-fpm php7.2-opcache php7.2-gd php7.2-mysql \
php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-soap

RUN mkdir /disk1
RUN chown 33:33 /disk1
# Enable apache mods.
#RUN a2enmod php7.load
#RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
#RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid



# Expose apache.
EXPOSE 80

#ADD conf/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND