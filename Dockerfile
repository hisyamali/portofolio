# Base image
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

# Expose port 9000 dan jalankan PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
