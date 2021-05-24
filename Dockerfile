FROM ubuntu:20.04

#expose ports
EXPOSE 80

#update repos and install php,nginx
RUN apt-get update
RUN apt-get install software-properties-common -y 
RUN add-apt-repository ppa:ondrej/php -y 
RUN apt-get install -y wget nginx php7.4-fpm  php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip

#download wp
WORKDIR  /tmp
RUN wget https://wordpress.org/latest.tar.gz &&\
tar -xvzf latest.tar.gz &&\
mv wordpress /var/www/wordpress &&\
chown -R www-data:www-data /var/www/wordpress/ &&\
chmod -R 755 /var/www/wordpress/ 

#nginx config
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
COPY wordpress /etc/nginx/sites-available/wordpress
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/ 

#start services
CMD service php7.4-fpm start && nginx
    
    
    
    
