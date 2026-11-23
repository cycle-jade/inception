#!/bin/bash
set -e

sed -i "s|listen = .*|listen = 0.0.0.0:9000|" /etc/php/8.2/fpm/pool.d/www.conf

while ! mariadb -h mariadb -u "${SQL_USER}" -p"${SQL_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 3
done

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp config create --allow-root --dbname="${SQL_DATABASE}" --dbuser="${SQL_USER}" --dbpass="${SQL_PASSWORD}" --dbhost="mariadb:3306"
    wp core install --allow-root --url="${DOMAIN_NAME}" --title="${SITE_TITLE}" --admin_user="${ADMIN_USER}" --admin_password="${ADMIN_PASSWORD}" --admin_email="${ADMIN_EMAIL}"
    wp user create "${USER_LOGIN}" "${USER_EMAIL}" --role=author --user_pass="${USER_PASSWORD}" --allow-root
fi

exec /usr/sbin/php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
