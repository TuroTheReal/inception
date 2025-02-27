FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
		apt-get install -y openssl && \
		apt-get install -y nginx

RUN mkdir -p /var/www/html && \
		chmod -R 755 /var/www/html && \
		chown -R www-data:www-data /var/www/html

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/nginx-selfsigned.key \
		-out /etc/nginx/ssl/nginx-selfsigned.crt \
		-subj "/CN=${DOMAIN_NAME}"

COPY ./nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html

EXPOSE 443

# EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;"]