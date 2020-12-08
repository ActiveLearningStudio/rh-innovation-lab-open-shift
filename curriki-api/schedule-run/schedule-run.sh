#!/bin/bash

export PGPASSWORD=${PGPASSWORD:-password}
export USERNAME=${USERNAME:-curriki}
export DB_PORT=${DB_PORT:-5432}
export DB_NAME=${DB_NAME:-currikidb}
export DB_SERVICE=curriki-postgresql.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local

while true; do
  psql -q -U ${USERNAME} -h ${DB_SERVICE} -p ${DB_PORT} -d ${DB_NAME} -qt -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'users');" | cut -d \| -f 1 | grep -qw t
  if [ $? -eq 1 ]; then
    echo " 🏗 no schema table found - exiting 🏗";
    exit 0
  else
    echo " 🏗 schema table found - schedule 🏗";
    php /var/www/html/artisan schedule:run
    exit 0
  fi
  sleep 5
done
