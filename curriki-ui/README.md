## curriki-ui

Patch Routes post deploy

```bash
oc patch route/curriki-ui-api --patch "{\"spec\":{\"host\": \"$(oc get route curriki-ui -o custom-columns=ROUTE:.spec.host --no-headers)\"}}" --type=merge
oc patch route/curriki-ui-storage --patch "{\"spec\":{\"host\": \"$(oc get route curriki-ui -o custom-columns=ROUTE:.spec.host --no-headers)\"}}" --type=merge
oc patch route/curriki-ui-socket --patch "{\"spec\":{\"host\": \"$(oc get route curriki-ui -o custom-columns=ROUTE:.spec.host --no-headers)\"}}" --type=merge
```
