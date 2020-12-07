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
oc get secret rec -o=jsonpath='{.data.username}' | base64 --decode; echo
oc get secret rec -o=jsonpath='{.data.password}' | base64 --decode; echo
```


[Redis DB CRD](https://github.com/RedisLabs/redis-enterprise-k8s-docs/blob/master/redis_enterprise_database_api.md#redisenterprisedatabasespec)