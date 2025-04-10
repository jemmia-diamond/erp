FROM python:3.13-slim

# Create a frappe user
RUN useradd -ms /bin/bash frappe

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    build-essential \
    git \
    mariadb-client \
    redis-tools \
    wkhtmltopdf \
    fontconfig \
    libmariadb-dev \
    libjpeg-dev \
    libffi-dev \
    libssl-dev \
    && curl -sL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && apt-get clean

# Install Frappe Bench CLI
RUN pip install --upgrade pip && pip install frappe-bench

# Set working directory
WORKDIR /app

# Copy app code
COPY . .

RUN bench build --production --apps frappe,erpnext

# Set permissions and switch to the frappe user
RUN chown -R frappe:frappe /app
USER frappe

# Set entry point
CMD ["bin/run-dev.sh"]
