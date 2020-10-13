
# 脉脉cloud

K8S，想要【监听】k8s的服务变更后【推送消息】给自己开发的应用程序，看了好几个中英文档，都没找到相应资料。有大佬能指点下怎么找到资料，怎么着手去做么？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYxNTAxOTcsImlhdCI6MTU4OTg2MjkwMn0.JCznD3bEoHr52OH8lLlwe4_TRQ3g6M-EjTy3xEbT-6c
- > 所谓的k8s服务变更是指什么？如果指的是k8s资源的变更，使用client go里面的informer就行，或者直接用list watch api来监听
- > 本质上是监听etcd的数据变更？watcher 就好了吧
- > fabric8的watch功能
