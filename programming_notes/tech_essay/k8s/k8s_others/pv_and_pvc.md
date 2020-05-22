
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
[root@voles1 postgres-operator]#
```
