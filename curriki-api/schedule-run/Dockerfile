FROM quay.io/masood_faisal/curriki-api-fpm:0.0.3
ADD schedule-run.sh /var/www/html
USER root
RUN dnf install postgresql  -y
RUN chmod 755 /var/www/html/schedule-run.sh