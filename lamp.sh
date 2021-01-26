#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# Written by @AamnahAkram from http://aamnah.com
# Modified by Venolas
# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt update -y && sudo apt upgrade -y

## Install AMP
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

echo -e "$Cyan \n Installing PHP & Requirements $Color_Off"
sudo apt install php php-{bcmath,bz2,intl,gd,mbstring,mysql,zip,fpm,mcrypt} -y

echo -e "$Cyan \n Installing MySQL $Color_Off"
sudo apt install mysql-server mysql-client -y

echo -e "$Cyan \n Installing phpMyAdmin $Color_Off"
sudo apt install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

echo -e "$Cyan \n Verifying installs$Color_Off"
sudo apt install apache2 mysql-client mysql-server -y

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo php7enmod mcrypt

# Edit php.ini
sudo sed -i 's,^memory_limit =.*$,memory_limit = 1024M,' /etc/php/7.4/apache2/php.ini
sudo sed -i 's,^upload_max_filesize =.*$,upload_max_filesize = 1024M,' /etc/php/7.4/apache2/php.ini
sudo sed -i 's,^post_max_size =.*$,post_max_size = 500M,' /etc/php/7.4/apache2/php.ini
sudo sed -i 's,^file_uploads =.*$,file_uploads = On,' /etc/php/7.4/apache2/php.ini
sudo sed -i 's,^max_execution_time =.*$,max_execution_time = 180,' /etc/php/7.4/apache2/php.ini
echo -e "$Green \n php.ini has been changed $Color_Off"

#Download PHP File Manager
echo -e "$Cyan \n Downloading PHP File Manager $Color_Off"

#Download Wordpress
echo -e "$Cyan \n Downloading Wordpress $Color_Off"

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart
