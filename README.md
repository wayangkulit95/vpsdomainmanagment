
# VPS Domain Management Script

This script helps manage domains on a VPS running an Nginx web server. It allows you to add, edit, and delete domains easily.

## Features
- Add a new domain with a basic setup.
- Edit an existing domain's configuration.
- Delete a domain and its associated files.

---

## Prerequisites
1. A VPS running Linux (Ubuntu/Debian recommended).
2. Nginx installed and configured.
3. Sudo or root access.

---

## Installation

### 1. Download the Script
Use `curl` to download the script directly to your VPS:
```bash
curl -o setup.sh https://raw.githubusercontent.com/wayangkulit95/vpsdomainmanagment/refs/heads/main/setup.sh
```

### 2. Make the Script Executable
```bash
chmod +x setup.sh
```

### 3. Run the Script
Execute the script with:
```bash
sudo ./setup.sh
```

---

## Usage
1. Run the script:
   ```bash
   sudo ./setup.sh
   ```
2. Select an option from the menu:
   - **1**: Add a domain.
   - **2**: Edit a domain's configuration.
   - **3**: Delete a domain.
   - **4**: Exit.

3. Follow the prompts to complete your task.

---

## File Structure
When a domain is added, the following structure is created:
```
/var/www/<domain-name>
  └── index.html
/etc/nginx/sites-available/<domain-name>
/etc/nginx/sites-enabled/<domain-name> (symlink)
```

---

## Important Notes
- This script is designed for **Nginx**. Modify the configuration if using another web server.
- Always test your configuration after making changes:
  ```bash
  nginx -t
  ```
- Reload Nginx after making changes:
  ```bash
  sudo systemctl reload nginx
  ```

---

## Uninstallation
To remove the script:
```bash
rm setup.sh
```

---

## Troubleshooting
- If you encounter errors while reloading Nginx, use:
  ```bash
  sudo journalctl -xe
  ```
- Ensure proper file and directory permissions:
  ```bash
  sudo chmod -R 755 /var/www
  sudo chown -R www-data:www-data /var/www
  ```

---

## License
MIT
