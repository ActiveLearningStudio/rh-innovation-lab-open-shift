## mysql

MySQL database built from template objects in OpenShift

```bash
oc new-app --template=mysql-persistent -p DATABASE_SERVICE_NAME=mysql -p MYSQL_USER="user" -p MYSQL_PASSWORD="password" -p MYSQL_ROOT_PASSWORD="password" -p MYSQL_DATABASE="sampledb"
```

### Deploy

Deploy database instances as any user
```bash
kustomize build dev-cluster | oc apply -f-
```

### Test

You can connect to mysql
```bash
oc rsh $(oc get pods -lapp=mysql --template='{{range .items}}{{.metadata.name}}{{end}}')

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $HOSTNAME $MYSQL_DATABASE
show databases;
use sampledb;
show tables;
```
