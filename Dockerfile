FROM php:8.2-fpm

# Cài đặt các extension cần thiết
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy mã nguồn Laravel
COPY . /var/www
WORKDIR /var/www

# Cài đặt các package cần thiết
RUN composer install --no-dev --optimize-autoloader

# Cấp quyền cho thư mục storage và bootstrap/cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Chạy lệnh migrate và khởi động server
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8080
