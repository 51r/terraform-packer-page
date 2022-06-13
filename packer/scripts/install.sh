# Update the package lists
sudo apt-get update
# Install nginx
sudo apt-get install -y nginx
# Install unzip 
sudo apt-get install -y unzip
# Download latest release to nginx
cd /var/www/html
sudo wget "https://github.com/51r/packer-ubuntu-nginx-page/releases/latest/download/release.zip"
# Unzip release.zip
sudo unzip release.zip 
# Allow nginx in firewall
sudo ufw allow 'nginx full'
# Clean-up 
sudo rm release.zip
