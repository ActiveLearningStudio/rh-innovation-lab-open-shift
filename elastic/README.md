## elasticsearch

Elasticsearch operator

- https://operatorhub.io/operator/elastic-cloud-eck


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

Use `elastic` user and password to login to kibana 
```bash
oc get secret my-escluster-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
 ```


### Reference
[https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html](Create Index ) in ES via PUT commans

```bash
curl -vvvvk -I -u 'elastic-internal:PWDFROMSECRET' 'https://localhost:9200/curriki?pretty'
curl -vvvvk -X PUT -u 'elastic-internal:PWDFROMSECRET' 'https://localhost:9200/curriki' -H 'Content-Type: application/json' -d'{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 0 
    }
  },
  "mappings": {
    "properties": {
      "tags": { "type": "text" }
    }
  }
}'

curl -vvvvk -X POST -u 'elastic-internal:PWDFROMSECRET' 'https://localhost:9200/curriki/tags' -H 'Content-Type: application/json' -d'
 {
    "tag" : "A00-3"
 }'
```