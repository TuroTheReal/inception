#!/bin/bash

# Arrête l'exécution du script en cas d'erreur
set -eo pipefail

# Télécharger WordPress si ce n'est pas déjà fait
echo "Downloading WordPress..."
wp core download --allow-root

# Attendre que MariaDB soit prêt avant de créer la configuration
until mysqladmin ping -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" --silent; do
	echo "Waiting for database..."
	sleep 2
done

# Créer le fichier wp-config.php via WP-CLI
echo "Creating wp-config.php..."
wp config create --dbhost="${WORDPRESS_DB_HOST}" --dbname="${WORDPRESS_DB_NAME}" \
--dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --allow-root

# Vérifier si WordPress est déjà installé
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress..."

# Configuration du site WordPress via WP-CLI
	wp core install --url="${WORDPRESS_SITE_URL}" --title="${WORDPRESS_SITE_TITLE}" \
	--admin_user="${WORDPRESS_ADMIN_USER}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
	--admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root

	echo "Creating additional user..."
	wp user create "${USER_USERNAME}" "${USER_EMAIL}" --user_pass="${USER_PASSWORD}" --role=subscriber --allow-root
fi

# Lance PHP-FPM (FastCGI Process Manager) pour gérer les requêtes PHP en arrière-plan.
echo "WordPress is ready!"
exec php-fpm7.4 -F