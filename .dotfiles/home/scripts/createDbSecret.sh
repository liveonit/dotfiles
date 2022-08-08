environment="production"
username="webhook"
password="COJNGOkiCQVhaNmx"
schema="webhook"
host="postgresql.$environment.vntana.internal"
cat <<EOF | kubectl -n "$environment" apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: $username-postgres-secret
type: Opaque
data:
  host: $(echo $host | tr -d '\n' | base64)
  username: $(echo $username | tr -d '\n' | base64)
  schema: $(echo $schema | tr -d '\n' | base64)
  password: $(echo $password | tr -d '\n' | base64)
EOF