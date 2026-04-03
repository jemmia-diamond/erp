# Setup Guide

## Introduction
What is Frappe Framework? Frappe, pronounced fra-pay, is a full stack, batteries-included, web framework written in Python and Javascript with MariaDB as the database. It is the framework which powers ERPNext, is pretty generic and can be used to build database driven apps.

## Prerequisites

### Required Dependencies

```bash
brew install pyenv pipx redis mariadb@10.6 node@18 postgresql pkg-config mariadb-connector-c
```

**Frappe v16 requires Python 3.14.** Use pyenv to install it:
```bash
pyenv install 3.14.0
pyenv local 3.14.0
python --version
```

### Environment Configuration

Add the following to your shell configuration file (`~/.zshrc` for Zsh):

```bash
# Add to PATH
echo 'export PATH="/opt/homebrew/opt/mariadb@10.6/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/opt/redis@6.2/bin:$PATH"' >> ~/.zshrc

# Reload your shell configuration
source ~/.zshrc
```

### Database Setup

```bash
# Start MariaDB
brew services start mariadb@10.6

# Set root password (optional for local development)
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456'; FLUSH PRIVILEGES;"

# Start Redis
brew services start redis
```

## Backup

### Backup via Bench
```bash
bench --site dev.localhost backup
```
Backup files are saved to `sites/dev.localhost/private/backups/`.

### Restore
```bash
mysql -u root -p123456 < backup_YYYYMMDD.sql
```

## Installation

### 1. Create Virtual Environment

```bash
~/.pyenv/versions/3.14.0/bin/python3.14 -m venv env
source ./env/bin/activate
```

### 2. Install and Initialize Bench
```bash
pip install frappe-bench
bench init frappe-bench
```

### Step 3: Get Required Apps

```bash
bench get-app frappe https://github.com/jemmia-diamond/frappe
bench get-app erpnext https://github.com/jemmia-diamond/erpnext
```

### Step 4: Create and Configure Site

```bash
bench new-site dev.localhost
bench --site dev.localhost install-app erpnext
bench --site dev.localhost set-config developer_mode true
```

### Step 5: Update Configuration Files
1. Run `pwd` to get your current path
2. Replace absolute paths in `config/*.conf` files with your current path

### Step 6: Start the Development Server

```bash
bench start
```

## Accessing Your Site

Once the server is running:
- Site URL: `http://dev.localhost:8000`
- Default Admin: `Administrator`
- Password: Set during site creation

### Important

- Add your site name to `.gitignore` if different from `dev.localhost`

### Database Migration

Use this command when there are changes to DocTypes in the database:

```bash
bench --site dev.localhost migrate
```