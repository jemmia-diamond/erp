FROM python:3.13-slim

# Install Node.js
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
    && npm install -g yarn

# Set working directory
WORKDIR /app

# Install Python dependencies
RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application files
COPY . /app

# Set entry point
CMD ["bin/run-dev.sh"]


