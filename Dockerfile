# web: php artisan serve --host 0.0.0.0 --port $PORT
# release: php artisan migrate --force
# Base image
FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set up application
WORKDIR /var/www
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose the port nginx will listen on
EXPOSE 9000
CMD ["php-fpm"]
