FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo mbstring zip

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set up application
WORKDIR /var/www
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Buat folder yang dibutuhkan
RUN mkdir -p /var/www/storage /var/www/vendor

# Set permission untuk folder storage
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && chmod -R 777 /var/www/storage

# Expose the port nginx will listen on
EXPOSE 9000
CMD ["php-fpm"]
