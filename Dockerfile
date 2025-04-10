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

# Set working directory
WORKDIR /home/frappe

# Copy your entire codebase first
COPY --chown=frappe:frappe . /home/frappe/frappe-bench/

# Set working directory to the bench directory
WORKDIR /home/frappe/frappe-bench

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Frappe module from the local directory
# This is crucial for the bench command to work
RUN pip install -e apps/frappe

# Try a different approach - use yarn directly instead of bench build
# First, install node modules for frappe
WORKDIR /home/frappe/frappe-bench/apps/frappe
RUN yarn install

# Then build frappe
RUN yarn production --app frappe

# Do the same for ERPNext
WORKDIR /home/frappe/frappe-bench/apps/erpnext
RUN yarn install
RUN yarn production --app erpnext

# Return to bench directory
WORKDIR /home/frappe/frappe-bench

# Set permissions and switch to the frappe user
RUN chown -R frappe:frappe /home/frappe
USER frappe

# Set entry point
CMD ["bin/run-dev.sh"]
