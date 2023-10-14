# Gunakan gambar PHP sebagai dasar
FROM php:8.1-apache

# Instal dependensi yang diperlukan
RUN apt-get update && apt-get install -y libzip-dev zip && docker-php-ext-install zip

# Atur DocumentRoot Apache
ENV APACHE_DOCUMENT_ROOT /var/www/public
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf

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

# Expose port 80 untuk server web Apache
EXPOSE 8001

CMD ["apache2ctl", "-D", "FOREGROUND"]

# Jalankan server PHP built-in
#CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]

