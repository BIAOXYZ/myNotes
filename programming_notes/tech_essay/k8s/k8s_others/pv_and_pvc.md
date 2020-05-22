
# 人为指定某个pvc和某个pv绑定

Can a PVC be bound to a specific PV? https://stackoverflow.com/questions/34282704/can-a-pvc-be-bound-to-a-specific-pv
> Better to specify both `volumeName` in `pvc` and `claimRef` in `pv`. 【注：原文笔误（两个都写成了`pvc`，实际上第二个应为`pv`）我已经改过了来】
>
> By using `storageClassName: manual` in both `pv` and `pvc` we can bind each other, but it does not guarantee if there are many `manual` pv and pvc's.
>
> Specifying a volumeName in your PVC does not prevent a different PVC from binding to the specified PV before yours does. Your claim will remain Pending until the PV is Available.
<br> Specifying a claimRef in a PV does not prevent the specified PVC from being bound to a different PV. The PVC is free to choose another PV to bind to according to the normal binding process. Therefore, to avoid these scenarios and ensure your claim gets bound to the volume you want, you must ensure that both volumeName and claimRef are specified.
<br> You can tell that your setting of volumeName and/or claimRef influenced the matching and binding process by inspecting a Bound PV and PVC pair for the pv.kubernetes.io/bound-by-controller annotation. The PVs and PVCs where you set the volumeName and/or claimRef yourself will have no such annotation, but ordinary PVs and PVCs will have it set to "yes".
<br> When a PV has its claimRef set to some PVC name and namespace, and is reclaimed according to a Retain reclaim policy, its claimRef will remain set to the same PVC name and namespace even if the PVC or the whole namespace no longer exists.

## 个人实战

起因是新员工基于Zalando的pg operator的[v1.5.0版本](https://github.com/zalando/postgres-operator/tree/v1.5.0)，在她的虚机上跑官方[Quickstart](https://github.com/zalando/postgres-operator/blob/v1.5.0/docs/quickstart.md)创建最简cluster（就下面这几句其实）：
```sh
git clone https://github.com/zalando/postgres-operator.git
cd postgres-operator
kubectl create -f manifests/configmap.yaml
kubectl create -f manifests/operator-service-account-rbac.yaml
kubectl create -f manifests/postgres-operator.yaml
kubectl create -f manifests/api-service.yaml
kubectl create -f manifests/minimal-postgres-manifest.yaml
```
但总是pv有问题。我自己在katacoda上用minikube试了下没问题，然后去她环境上看了下。接着：
- 从katacoda那个可以正常起来的例子里把pv和pvc都--export出来。
- 删掉大部分没用的或者运行时才动态生成的字段。
- 然后在pvc里通过`volumeName`字段指定其和名为`pv00`的pv去绑定（此外pv的yaml里的`storageClassName: standard`开始没注释掉，但是会报错，后面注释掉就好了。不过katacoda上最原始的pv和pvc其实都有`storageClassName: standard`，只是我--export的时候pv的没删，pvc的删了）。
- 最后拷到新员工机器上，按改过的yaml创建pv和pvc。最后发现master实例对应的pod，即acid-minimal-cluster-0成功。

```sh
[root@voles1 postgres-operator]# cat pv00.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv00
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 1Gi
  persistentVolumeReclaimPolicy: Delete
  #storageClassName: standard
  volumeMode: Filesystem
  hostPath:
    path: "/tmp/pg1"
[root@voles1 postgres-operator]#
[root@voles1 postgres-operator]# cat pvc00.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pgdata-acid-minimal-cluster-0
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  volumeMode: Filesystem
  volumeName: pv00
[root@voles1 postgres-operator]#
[root@voles1 postgres-operator]# kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                   STORAGECLASS   REASON   AGE
pv00   1Gi        RWO            Delete           Bound    default/pgdata-acid-minimal-cluster-0                           13m
[root@voles1 postgres-operator]# kubectl get pvc
NAME                            STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pgdata-acid-minimal-cluster-0   Bound     pv00     1Gi        RWO                           16m
pgdata-acid-minimal-cluster-1   Pending                                                     12m
[root@voles1 postgres-operator]#

// 第一个因为已经设置好pv和pvc了，所以已经正常了。第二个就懒得再设置了，找到原因就行。
[root@voles1 postgres-operator]# kubectl get pod | grep minimal
acid-minimal-cluster-0              1/1     Running            0          46m
acid-minimal-cluster-1              0/1     Pending            0          20m
```
