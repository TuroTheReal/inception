#!/bin/bash

# Stop l'exec du script if error
set -eo pipefail

# Skip initialisation if it's already done
if [ ! -d "/var/lib/mysql/is_rdy" ]; then

	# Init les fichiers de la base de données MySQL (avant de démarrer serv MySQL)
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	# Demarre Serveur MySQL pour les config initiales
	mysqld --user=mysql --skip-networking &
	pid="$!"

	# Wait for MySQL to be ready
	until mysqladmin ping -h"localhost" --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
	done

	# Crée user 'root' if not here (accessible from any host avec '%')
	mysql -e "CREATE USER IF NOT EXISTS 'root'@'%';"

	# Modifie mdp de 'root' pour le laisser vide
	mysql -e "ALTER USER 'root'@'%' IDENTIFIED BY '';"

	# Crée MYSQL_DATABASE
	mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

	# Crée new user avec les env : MYSQL_USER et MYSQL_PASSWORD
	mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

	# Attribue tous les privilèges à MYSQL_USER sur MYSQL_DATABASE
	mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

	# Give All privilèges au 'root' pour qu'il puisse tout gérer sur toutes les bases
	mysql -e "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;"

	# Apply modifs
	mysql -e "FLUSH PRIVILEGES;"

	touch /var/lib/mysql/is_rdy
	# echo "done" > /var/lib/mysql/is_rdy

	# Arrête le serveur MySQL temporaire lancé plus tôt
	mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
	wait "$pid"
fi

# Start MySQL serv de manière définitive avec les param CMD du Dockerfile
exec gosu mysql "$@"