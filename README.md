## Introduction
What is Frappe Framework? Frappe, pronounced fra-pay, is a full stack, batteries-included, web framework written in Python and Javascript with MariaDB as the database. It is the framework which powers ERPNext, is pretty generic and can be used to build database driven apps.

## Development Setup

1. Replace your current absolute path in `config/*.conf` files. Run `pwd` may help you to get the path fast.
2. Set up environment
```bash
# Activate your python env
python -m venv env

# Enter "y (yes)" to overwirite the apps
bench get-app frappe https://github.com/jemmia-diamond/frappe
bench get-app erpnext https://github.com/jemmia-diamond/erpnext

# Create site and install erpnext to the site.
# If you create site with a different name from the guide, don't forget to add it to the .gitignore file
bench new-site dev.localhost
bench --site dev.localhost install-app erpnext
bench --site dev.localhost set-config developer_mode true
```


## Migrate change - use this when there are changes of doctype in database

```bash
bench --site dev.locahost migrate
```