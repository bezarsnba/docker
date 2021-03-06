FROM debian:latest
MAINTAINER bezaliel <bramos@onxsolutions.net>
ENV GLPI_VERSION 9.2.1
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  && apt-get -y install \
	apache2 \
	php \
	php-mysql \
	php-ldap \
	php-xmlrpc \
	php-imap \
	curl \
	php-curl \
	php-gd \
	php-mbstring \
	php-xml \
	php-apcu-bc \
	wget

COPY apache2.conf /etc/apache2/
ADD https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz /tmp/ 
RUN tar -zxvf /tmp/glpi-9.2.1.tgz  -C /tmp  && mv /tmp/glpi/* /var/www/html/ && rm /var/www/html/index.html && chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
