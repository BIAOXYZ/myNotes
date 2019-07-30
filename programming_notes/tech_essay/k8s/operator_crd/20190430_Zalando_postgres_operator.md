
# 0. 之前的记录

```
git clone https://github.com/zalando/postgres-operator.git && cd postgres-operator && kubectl create -f manifests/configmap.yaml && kubectl create -f manifests/operator-service-account-rbac.yaml && kubectl create -f manifests/postgres-operator.yaml && apt -y install postgresql-client && kubectl create -f manifests/minimal-postgres-manifest.yaml

export HOST_PORT=$(minikube service acid-minimal-cluster --url | sed 's,.*/,,')
export PGHOST=$(echo $HOST_PORT | cut -d: -f 1)
export PGPORT=$(echo $HOST_PORT | cut -d: -f 2)
export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials -o 'jsonpath={.data.password}' | base64 -d)
psql -U postgres

create table t1 (id int, name varchar); insert into t1 values (1,'alice'); select * from t1; select * from pg_stat_replication;

kubectl -it exec acid-minimal-cluster-1 /bin/bash

kubectl delete postgresql acid-minimal-cluster
```

## 0.1 参考链接

- https://github.com/zalando/postgres-operator/blob/master/docs/quickstart.md

# 1. 
