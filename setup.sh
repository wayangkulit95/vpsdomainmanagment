#!/bin/bash

# Define constants
VHOST_DIR="/etc/nginx/sites-available"
VHOST_LINK="/etc/nginx/sites-enabled"
WEB_ROOT="/var/www"

# Function to add a domain
add_domain() {
  echo "Enter domain name to add (e.g., example.com):"
  read DOMAIN
  DOMAIN_DIR="$WEB_ROOT/$DOMAIN"
  VHOST_FILE="$VHOST_DIR/$DOMAIN"

  if [ -d "$DOMAIN_DIR" ]; then
    echo "Domain already exists."
    return
  fi

  # Create web root
  mkdir -p "$DOMAIN_DIR"
  echo "<h1>Welcome to $DOMAIN</h1>" > "$DOMAIN_DIR/index.html"

  # Create virtual host config
  cat <<EOL > "$VHOST_FILE"
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root $DOMAIN_DIR;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL

  # Enable the site
  ln -s "$VHOST_FILE" "$VHOST_LINK"

  # Reload Nginx
  nginx -t && systemctl reload nginx
  echo "Domain $DOMAIN added successfully."
}

# Function to edit a domain
edit_domain() {
  echo "Enter domain name to edit (e.g., example.com):"
  read DOMAIN
  VHOST_FILE="$VHOST_DIR/$DOMAIN"

  if [ ! -f "$VHOST_FILE" ]; then
    echo "Domain does not exist."
    return
  fi

  echo "Editing $DOMAIN. Opening configuration file..."
  nano "$VHOST_FILE"

  # Reload Nginx
  nginx -t && systemctl reload nginx
  echo "Domain $DOMAIN edited successfully."
}

# Function to delete a domain
delete_domain() {
  echo "Enter domain name to delete (e.g., example.com):"
  read DOMAIN
  DOMAIN_DIR="$WEB_ROOT/$DOMAIN"
  VHOST_FILE="$VHOST_DIR/$DOMAIN"

  if [ ! -f "$VHOST_FILE" ]; then
    echo "Domain does not exist."
    return
  fi

  # Remove virtual host config and web root
  rm -f "$VHOST_FILE"
  rm -f "$VHOST_LINK/$DOMAIN"
  rm -rf "$DOMAIN_DIR"

  # Reload Nginx
  nginx -t && systemctl reload nginx
  echo "Domain $DOMAIN deleted successfully."
}

# Main menu
while true; do
  echo "Choose an option:"
  echo "1) Add Domain"
  echo "2) Edit Domain"
  echo "3) Delete Domain"
  echo "4) Exit"
  read CHOICE

  case $CHOICE in
    1) add_domain ;;
    2) edit_domain ;;
    3) delete_domain ;;
    4) exit 0 ;;
    *) echo "Invalid option." ;;
  esac
done
