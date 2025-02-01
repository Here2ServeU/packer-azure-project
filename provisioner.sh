#!/bin/bash

# Wait for any pending system updates or processes to finish
sleep 10

# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install Apache
sudo apt install -y apache2

# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Create a simple index.html page for verification
echo "<html><body><h1>Welcome to T2S Web Server</h1></body></html>" | sudo tee /var/www/html/index.html
