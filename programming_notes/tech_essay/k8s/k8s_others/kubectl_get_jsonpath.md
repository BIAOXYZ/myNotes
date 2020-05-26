
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
