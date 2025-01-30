#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt install -y ca-certificates apt-transport-https lsb-release curl

# Add SURY PHP repository for older PHP versions
echo "Adding SURY PHP repository..."
sudo curl -fsSL https://packages.sury.org/php/apt.gpg | sudo tee /etc/apt/trusted.gpg.d/sury-php.gpg > /dev/null
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

# Update package list again
echo "Updating package list after adding PHP repository..."
sudo apt update -y

# Install PHP 7.3 and necessary extensions
echo "Installing PHP 7.3 and required modules..."
sudo apt install -y php7.3 php7.3-cli php7.3-fpm php7.3-mysql php7.3-curl php7.3-mbstring php7.3-xml php7.3-zip php7.3-gd

# Verify PHP installation
echo "Checking PHP version..."
php -v

# Check if MySQL extension is installed
echo "Checking MySQL extension in PHP..."
php -m | grep mysqli

# Restart services
echo "Restarting PHP-FPM and Web Server..."
sudo systemctl restart php7.3-fpm
sudo systemctl restart apache2

echo "✅ PHP 7.3 installation completed!"
