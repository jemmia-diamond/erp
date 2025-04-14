## Introduction
What is Frappe Framework? Frappe, pronounced fra-pay, is a full stack, batteries-included, web framework written in Python and Javascript with MariaDB as the database. It is the framework which powers ERPNext, is pretty generic and can be used to build database driven apps.

## Development Setup

```bash
cd erp

# run pwd to get your absolute path on your machine, replace {pwd} the absolute path in config/*.conf files

# activate your python env
# run this to create env in your project directory
python -m venv env

# y (yes) to overwirite the apps
bench get-app frappe https://github.com/jemmia-diamond/frappe --init-bench 
bench get-app erpnext https://github.com/jemmia-diamond/erpnext --init-bench



# create site and install erpnext to the site
# if you create site with a different name from the guide, remember to list the site in the .gitignore file
bench new-site dev.localhost
bench --site dev.localhost install-app erpnext
bench --site dev.localhost set-config developer_mode true

# And so on..
```
