## User application monitoring

See the documentation here for configuring user workload monitoring using prometheus and grafana

- https://docs.openshift.com/container-platform/4.6/nodes/clusters/nodes-cluster-enabling-features.html
- https://www.redhat.com/en/blog/custom-grafana-dashboards-red-hat-openshift-container-platform-4


To also query openshift metrics from our custom grafana
```bash
oc adm policy add-cluster-role-to-user cluster-monitoring-view -z grafana-serviceaccount
oc serviceaccounts get-token grafana-serviceaccount -n my-grafana
```
