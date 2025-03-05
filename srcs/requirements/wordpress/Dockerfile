FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install -y curl mariadb-client php-fpm php-gd \
	php-curl php-cli php-mbstring php-zip php-mysql \
	php-xml php-mysqli

RUN sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -L -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv ./wp-cli.phar /bin/wp

RUN mkdir -p /var/www/html/wordpress && \
	chmod -R 755 /var/www/html/wordpress && \
	chown -R www-data:www-data /var/www/html/wordpress

WORKDIR /var/www/html/wordpress

COPY ./config.sh /usr/local/bin/config.sh

RUN chmod +x /usr/local/bin/config.sh && \
	mkdir -p /run/php/

EXPOSE 9000

CMD ["/usr/local/bin/config.sh"]