#!/bin/bash
# Redirect all output to a log file for troubleshooting
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>&1)

echo "Starting WordPress installation..."

sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

sudo apt-get install -y php libapache2-mod-php php-mysql
sudo systemctl restart apache2

# Install MySQL server safely
sudo apt-get install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql

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
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Clean up default Apache page if it exists
sudo rm -f /var/www/html/index.html

echo "WordPress installation completed!"