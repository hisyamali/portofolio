# web: php artisan serve --host 0.0.0.0 --port $PORT
# release: php artisan migrate --force
# Install system dependencies
FROM php:8.2-fpm
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libpq-dev

# Install extensions PHP yang dibutuhkan
RUN docker-php-ext-install pdo pdo_pgsql pgsql gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy semua file
COPY . .

# Install dependencies dengan Composer
RUN composer install --prefer-dist --no-scripts --no-dev --optimize-autoloader

# Jalankan artisan command
RUN php artisan config:cache
RUN php artisan serve --host 0.0.0.0 --port $PORT
RUN php artisan migrate

# Expose port 9000 dan jalankan PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
# Base image
# FROM php:8.2-fpm

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     git \
#     curl \
#     zip \
#     unzip

# # Install composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # Set up application
# WORKDIR /var/www
# COPY . .

# # Install PHP dependencies
# RUN composer install --no-dev --optimize-autoloader

# # Jalankan migrasi dan serve
# RUN php artisan migrate && php artisan serve --host 0.0.0.0 --port $PORT

# # Buat folder yang dibutuhkan
# RUN mkdir -p /var/www/storage /var/www/vendor

# # Set permission untuk folder storage
# RUN chown -R www-data:www-data /var/www \
#     && chmod -R 755 /var/www \
#     && chmod -R 777 /var/www/storage

# # Expose the port nginx will listen on
# EXPOSE 9000
# CMD ["php-fpm"]
