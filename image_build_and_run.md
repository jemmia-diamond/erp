# Local Build & Test Guide

## Quick Start

### 1. Clone frappe_docker
```bash
git clone --depth 1 https://github.com/frappe/frappe_docker.git
cd frappe_docker
```

### 2. Build image
```bash
# Encode apps.json
export APPS_JSON_BASE64="$(cat ../deployment/apps.json | base64 | tr -d '\n\r ')"

# Build
podman build --no-cache \
  --build-arg="FRAPPE_PATH=https://github.com/jemmia-diamond/frappe.git" \
  --build-arg="FRAPPE_BRANCH=version-16" \
  --build-arg="PYTHON_VERSION=3.14.0" \
  --build-arg="NODE_VERSION=24.0.0" \
  --build-arg="APPS_JSON_BASE64=${APPS_JSON_BASE64}" \
  --tag=ghcr.io/jemmia-diamond/jemmia_erp:staging \
  --file=images/custom/Containerfile .
```

### 3. Run
```bash
cd ..
podman-compose up
```

### 4. Access
- URL: http://localhost:8080
- User: Administrator / 123456

## Database Access
```bash
podman exec -it erp-db-1 mysql -uroot -proot
```

## Clean Up
```bash
podman-compose down -v  # Remove all data
```
