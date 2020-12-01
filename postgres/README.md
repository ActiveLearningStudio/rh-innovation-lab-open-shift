## postgres

Master / Read Replica postgres using OpenShift out of the box images

### Deploy

Deploy database instances as any user
```bash
kustomize build dev-cluster | oc apply -f-
```

### Test

Port forward read/write master
```bash
oc port-forward svc/postgresql-master 5432:5432
```

Connect to db create role
```bash
pgcli postgresql://postgres:password@localhost:5432/currikidb
CREATE ROLE curriki;
SELECT rolname FROM pg_roles;
\du
```

Load data
```bash
psql -h localhost -d currikidb -U pguser -f studio-initial-db.sql
```

View Tables
```bash
pgcli postgresql://pguser:password@localhost:5432/currikidb
\dt
```

Conect to Read Replica
```bash
oc port-forward svc/postgresql-slave 5432:5432
```

### Permissions

Handy one liners. If you drop and recreate the database:
```bash
export PGPASSWORD=${PGPASSWORD:-password}
export DB_PORT=${DB_PORT:-5432}
export DB_NAME=${DB_NAME:-currikidb}
export DB_SERVICE=postgresql-master.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local

psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "DROP DATABASE currikidb;"
psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "CREATE DATABASE currikidb;"
psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "GRANT CONNECT ON DATABASE currikidb TO pguser;"

GRANT ALL PRIVILEGES ON DATABASE currikidb TO pguser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pguser;
GRANT USAGE ON SCHEMA public TO pguser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO pguser;
```

### Connection tuning

Tuning the connections to get rid of the SQL error in the laravel log

`"SQLSTATE[08006] [7] FATAL:  remaining connection slots are reserved for non-replication superuser connections"`

We have no db pooling, and one pod, and we have persistent pg_pconnect() configured in php.ini - db connections are not shared between apache backends. so, if you have 100 apache backends you will get 100 db connections if you scale test - most will be idle. 

therefore we need to set the `MaxRequestedWorkers` == `POSTGRESQL_MAX_CONNECTIONS`

```xml
<IfModule mpm_prefork_module>
       StartServers             40
       MinSpareServers          20
       MaxSpareServers          60
       MaxRequestWorkers       400  <==== this needs to match pg POSTGRESQL_MAX_CONNECTIONS
       MaxConnectionsPerChild  1500
       ServerLimit 1024
</IfModule>
```

we can watch the #number of apache connections in the api pod:
```bash
-- watch apache connections
/etc/apache2$ while true; do ps auxww | grep apache2 | wc -l; sleep 2; done
```

and also watch for errors in the laravel log whilst using the login test from jmeter
```bash
grep ERROR  laravel.log
```

and check db setting
```bash
sh-4.4$ psql -h localhost -d currikidb
psql (10.14)
Type "help" for help.

currikidb=# show max_connections;
 max_connections 
-----------------
 400
(1 row)
```
