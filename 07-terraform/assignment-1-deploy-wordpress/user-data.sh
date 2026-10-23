#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>&1)

echo "Starting WordPress installation..."

# Update and install Apache (httpd on Amazon Linux)
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install PHP and MySQL library for PHP
sudo dnf install -y php php-mysqlnd php-gd php-xml php-mbstring
sudo systemctl restart httpd

# Install MariaDB (MySQL server equivalent on Amazon Linux)
sudo yum install -y mariadb155-server mariadb
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configure MySQL Database
sudo mysql -e "CREATE DATABASE wordpress;"
sudo mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and deploy WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

echo "WordPress installation completed!"