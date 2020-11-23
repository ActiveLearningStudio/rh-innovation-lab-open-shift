## yugabyte db

Yugabyte has an operator in operatorhub.io and in RedHat partner container registry

- https://operatorhub.io/operator/yugabyte-operator
- https://catalog.redhat.com/software/containers/search?q=yugabyte

The operator documentation is here:

https://docs.yugabyte.com/latest/deploy/kubernetes/single-zone/oss/helm-chart/

### Deploy

Deploy operator (once) as a user with cluster admin
```bash
kustomize build operator | oc apply -f-
```

Deploy database instances as any user
```bash
kustomize build dev-cluster | oc apply -f-
```

### Test

You can connect to yugabyte cluster using  `ysqlsh`
```bash
oc exec -it yb-tserver-0 -- ysqlsh -h yb-tserver-0 --echo-queries
```

External.IP addresses are exposed for admin ui, see:
```bash
oc get svc
```