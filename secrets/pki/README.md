## Route PKI

We cannot apply kubernetes secrets to Route objects. We have a certificate private key in the PKI bundle. The CA certs are public.

To manually apply the certificates to the Routes:

Decrypt the pki file and unzip
```bash
ansible-vault decrypt pki.zip --vault-password-file=~/.vault_pass_curriki.txt
```

Apply the certificates to the routes in the appropriate namespace
```bash
HOST=curriki-ui-labs-dev.apps.curriki.apac-1.rht-labs.com
HOST=curriki-ui-labs-test.apps.curriki.apac-1.rht-labs.com

oc replace -f - <<EOF
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: curriki-ui
spec:
  host: ${HOST}
  port:
    targetPort: 8443-tcp
  tls:
    termination: Reencrypt
    insecureEdgeTerminationPolicy: None
    key: |-
$(sed 's/^/      /' ocp-key.crt)
    certificate: |-
$(sed 's/^/      /' ocp-tls.crt)
    destinationCACertificate: |-
$(sed 's/^/      /' le-ca.pem)
  to:
    kind: Service
    name: curriki-ui
    weight: 100
  wildcardPolicy: None
EOF

oc replace -f - <<EOF
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: curriki-api-api
  annotations:
    haproxy.router.openshift.io/rewrite-target: /
spec:
  host: ${HOST}
  path: /api
  port:
    targetPort: 8443-tcp
  tls:
    termination: Reencrypt
    insecureEdgeTerminationPolicy: None
    key: |-
$(sed 's/^/      /' ocp-key.crt)
    certificate: |-
$(sed 's/^/      /' ocp-tls.crt)
    destinationCACertificate: |-
$(sed 's/^/      /' le-ca.pem)
  to:
    kind: Service
    name: curriki-api
    weight: 100
  wildcardPolicy: None
EOF

oc replace -f - <<EOF
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: curriki-api-storage
spec:
  host: ${HOST}
  path: /storage
  port:
    targetPort: 8443-tcp
  tls:
    termination: Reencrypt
    insecureEdgeTerminationPolicy: None
    key: |-
$(sed 's/^/      /' ocp-key.crt)
    certificate: |-
$(sed 's/^/      /' ocp-tls.crt)
    destinationCACertificate: |-
$(sed 's/^/      /' le-ca.pem)
  to:
    kind: Service
    name: curriki-api
    weight: 100
  wildcardPolicy: None
EOF

oc replace -f - <<EOF
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: curriki-api-socket
spec:
  host: ${HOST}
  path: /socket.io
  port:
    targetPort: 6001-tcp
  tls:
    termination: edge
  to:
    kind: Service
    name: curriki-api
    weight: 100
  wildcardPolicy: None
EOF
```