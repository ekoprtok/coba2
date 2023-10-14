# Gunakan gambar PHP sebagai dasar
FROM php:8.1-fpm

# Instal dependensi yang diperlukan
RUN apt-get update && apt-get install -y libzip-dev zip && docker-php-ext-install zip

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Mengatur direktori kerja
WORKDIR /var/www

# composer as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Menyusun proyek Lumen ke dalam /var/www
COPY ./src /var/www

# install project
RUN composer install

# Jalankan server PHP built-in
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]

