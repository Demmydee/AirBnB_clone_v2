#!/usr/bin/env bash
# Sets up your web servers for the depolyment of web static
# Installs nginx if not installed already
# Creates the required directories
# Creates a fake HTML file for test
# Creates a symbolic link
# Sets ownership of folder, updates and restarts nginx

sudo apt-get update
sudo apt-get -y install nginx

sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch  /data/web_static/releases/test/index.html

echo "<html><head><title>Test HTML file</title></head><body>This is a test HTML file.</body></html>" | sudo tee /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/

sudo sed -i '/listen 80 default_server;/a \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo service nginx restart

exit 0
