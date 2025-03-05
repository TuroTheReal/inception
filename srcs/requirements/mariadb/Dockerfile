FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server gosu && \
	apt-get clean && rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld

RUN sed -i '/^bind-address/c\bind-address = 0.0.0.0' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script.sh

WORKDIR /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["script.sh"]

CMD ["mysqld"]