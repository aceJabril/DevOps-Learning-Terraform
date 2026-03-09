#!/bin/bash
yum update -y

# Install Apache, PHP and MySQL client
yum install -y httpd php php-mysqlnd php-fpm php-json wget

# Install and start MariaDB
amazon-linux-extras install -y mariadb10.5
systemctl start mariadb
systemctl enable mariadb

# Create WordPress database and user
mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'WPpass123!';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Download and install WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Configure database connection
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wpuser/" wp-config.php
sed -i "s/password_here/WPpass123!/" wp-config.php

# Fix permissions and start Apache
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
systemctl start httpd
systemctl enable httpd