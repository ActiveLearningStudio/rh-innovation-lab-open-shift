## redis

Redis operator

- https://operatorhub.io/operator/redis-enterprise

### Deploy

Deploy SCC (once) per cluster with cluster admin
```bash
kustomize build operator-operator-scc | oc apply -f-
```

Deploy operator in the configured namespace as a user with cluster admin
```bash
kustomize build operator-dev-cluster | oc apply -f-
```

Deploy database instances as any user
```bash
kustomize build dev-cluster | oc apply -f-
```

### Test

There is a route defined for redis enterprise, you can login by getting these these credentials
```bash
oc get route rec-ui -o custom-columns=ROUTE:.spec.host --no-headers
oc get secret rec -o=jsonpath='{.data.username}' | base64 --decode; echo
oc get secret rec -o=jsonpath='{.data.password}' | base64 --decode; echo
```

To get the credentials for your redis db:
```bash
oc get secret redb-currikidb -o=jsonpath='{.data.password}' | base64 --decode; echo
oc get secret redb-currikidb -o=jsonpath='{.data.port}' | base64 --decode; echo
oc get secret redb-currikidb -o=jsonpath='{.data.service_name}' | base64 --decode; echo
```

[Redis DB CRD](https://github.com/RedisLabs/redis-enterprise-k8s-docs/blob/master/redis_enterprise_database_api.md#redisenterprisedatabasespec)