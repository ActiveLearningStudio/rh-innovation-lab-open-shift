## User application monitoring

See the documentation here for configuring user workload monitoring using prometheus and grafana

- https://docs.openshift.com/container-platform/4.6/nodes/clusters/nodes-cluster-enabling-features.html
- https://www.redhat.com/en/blog/custom-grafana-dashboards-red-hat-openshift-container-platform-4


To query metrics from our custom grafana, setup datasource using bearer token
```bash
oc adm policy add-cluster-role-to-user cluster-monitoring-view -z grafana-serviceaccount
```

Get bearer token for datasource
```bash
oc serviceaccounts get-token grafana-serviceaccount -n my-grafana
```

Manual for now
```bash
oc process -f https://raw.githubusercontent.com/hatmarch/cdc-and-debezium-demo/master/kube/grafana/openshift-metrics-datasource-template.yaml \
    PROJECT_NAME=openshift-user-workload-monitoring DATASOURCE_NAME=Prometheus-oauth TOKEN=$(oc serviceaccounts get-token grafana-serviceaccount) | oc apply -f -
```
