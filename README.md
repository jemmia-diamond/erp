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
bench --site dev.localhost migrate
```


## Custom Docker

1. create a file named "apps.json" and list apps

```json
[
    {
        "url": "https://github.com/jemmia-diamond/erpnext.git",
        "branch": "version-15"
    }
]
```

2. Generate base64 string from json file:

```bash
# ubuntu
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)
```
or

```bash
#masos
export APPS_JSON_BASE64=$(base64 -i apps.json)
```

3. Clone configs file from Frappe Docker

```bash
git clone https://github.com/frappe/frappe_docker

cd frappe_docker
```


3. build docker image

```bash
docker build \
  --build-arg=FRAPPE_PATH=https://github.com/jemmia-diamond/frappe.git \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=PYTHON_VERSION=3.13.2 \
  --build-arg=NODE_VERSION=18.20.2 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=jemmia_erp \
  --file=./Dockerfile .
```
