
JSONPath 支持 https://v1-18.docs.kubernetes.io/zh/docs/reference/kubectl/jsonpath/ || JSONPath Support https://v1-18.docs.kubernetes.io/docs/reference/kubectl/jsonpath/
```json
{
  "kind": "List",
  "items":[
    {
      "kind":"None",
      "metadata":{"name":"127.0.0.1"},
      "status":{
        "capacity":{"cpu":"4"},
        "addresses":[{"type": "LegacyHostIP", "address":"127.0.0.1"}]
      }
    },
    {
      "kind":"None",
      "metadata":{"name":"127.0.0.2"},
      "status":{
        "capacity":{"cpu":"8"},
        "addresses":[
          {"type": "LegacyHostIP", "address":"127.0.0.2"},
          {"type": "another", "address":"127.0.0.3"}
        ]
      }
    }
  ],
  "users":[
    {
      "name": "myself",
      "user": {}
    },
    {
      "name": "e2e",
      "user": {"username": "admin", "password": "secret"}
    }
  ]
}
```

|函数|描述|示例|结果|
|--|--|--|--|
| `.` or `[]` |	子运算符 | `{.kind}` or `{['kind']}` | `List` |


```console
# 使用 kubectl 和 JSONPath 表达式的示例:

kubectl get pods -o json
kubectl get pods -o=jsonpath='{@}'
kubectl get pods -o=jsonpath='{.items[0]}'
kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'
```

# 个人实战

```sh
# 一个有两个container的pod，查这两个container的image。

{root@bandore1 guestbook}$ kubectl get pod -n multicluster-endpoint endpoint-appmgr-7c8747bb87-rj79p -o=jsonpath={.spec.containers[0].image}
hyc-cloud-private-integration-docker-local.artifactory.swg-devops.com/ibmcom/subscription:3.3.0{root@bandore1 guestbook}$
{root@bandore1 guestbook}$
{root@bandore1 guestbook}$ kubectl get pod -n multicluster-endpoint endpoint-appmgr-7c8747bb87-rj79p -o=jsonpath={.spec.containers[1].image}
hyc-cloud-private-integration-docker-local.artifactory.swg-devops.com/ibmcom/ham-resource-discoverer:1.0.0{root@bandore1 guestbook}$
{root@bandore1 guestbook}$
```
