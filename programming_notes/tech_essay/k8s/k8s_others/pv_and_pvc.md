
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

# 后续问题

// 后来那个新员工跟我说她按照我给的pv和pvc模仿着来了一遍，开始成功了。但后来不知道为什么pod都被驱逐了。。。
```console
[root@voles1 ~]# kubectl get pod
NAME                READY  STATUS  RESTARTS  AGE
acid-minimal-cluster-0       0/1   Pending  0     2d1h
app-operator-84f74b64b8-5kcvm    0/1   Pending  0     14m
postgres-operator-f4545b4c7-2ngvr  0/1   Pending  0     80m

describe  pod   后显示Warning FailedScheduling <unknown> default-scheduler 0/1 nodes are available: 1 node(s) had taint {node.kubernetes.io/disk-pressure: }, that the pod didn't tolerate.
```

// 我一看是硬盘问题啊，上去看看：
```sh
[root@voles1 ~]# df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                  16G     0   16G   0% /dev
tmpfs                     16G     0   16G   0% /dev/shm
tmpfs                     16G  538M   16G   4% /run
tmpfs                     16G     0   16G   0% /sys/fs/cgroup
/dev/mapper/centos-root  233G  200G   34G  86% /
/dev/vda1               1014M  236M  779M  24% /boot
tmpfs                    3.2G     0  3.2G   0% /run/user/0
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/c220b5e8a0ac6921da579245c305832dabb06721298f475c835                               990eaef96891b/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/fe3ab193379fcaed7579f00cdcfbd6e463523cec30319d462f3                               f3c9a12ffca7d/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/4ed2fe299569440c95fc2dd7784339015b6967f2c86fc89a057                               69f924b9192b7/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/9d2f1f5ef7db22fb470624cfb6d7f51f93d8f8a873f08b1c607                               6629631c66609/merged
shm                       64M     0   64M   0% /var/lib/docker/containers/8c9855c1c59870cc090bf0d4669b30888ac6a5ce4f4ede1db                               5c7288910a297cc/mounts/shm
shm                       64M     0   64M   0% /var/lib/docker/containers/bd311da71411c0300a74099ad29327ebe4f12059af079edf9                               4cdef9ae5ebe8e4/mounts/shm
shm                       64M     0   64M   0% /var/lib/docker/containers/b241ce6ae0102427a0c4179ecd16cf627173505331e35e3e3                               8103347599d23ea/mounts/shm
shm                       64M     0   64M   0% /var/lib/docker/containers/2461c71ffaaff07dc85f830a74bf73ba2bf8590c7c8748a76                               d6cef1b74ce423d/mounts/shm
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/6353fedd61d8ec205542ed044316965f32fe09fd2992e40f0ac                               4f74f3b1d7fe6/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/25d5f79b5d35d5294d98675baf820d455fef8942b18f8956629                               1663d281b1c61/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/890d8762f29ddb728fb6969d0bd9e187deb70e9dc918cc75b30                               95385ae6878b0/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/4c4f50caf59389de22201b1424801a6156602a356abe0bba01a                               cc68485758d81/merged
tmpfs                     16G   12K   16G   1% /var/lib/kubelet/pods/4b7b893c-6970-4d2b-8f8f-bbc11e63ec25/volumes/kubernete                               s.io~secret/coredns-token-lknbb
tmpfs                     16G   12K   16G   1% /var/lib/kubelet/pods/22ed6829-ddba-4395-8115-0b7fafd25668/volumes/kubernete                               s.io~secret/kube-proxy-token-p8phk
tmpfs                     16G   12K   16G   1% /var/lib/kubelet/pods/14bf48cd-cffb-4690-8920-b66ed935a8e9/volumes/kubernete                               s.io~secret/coredns-token-lknbb
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/ba9a11a929bc78d62497f365ccd529eba677817b86705c4c199                               c535d92a937db/merged
shm                       64M     0   64M   0% /var/lib/docker/containers/9f051d6ae985b6a72a94c3b4e4150ac6730de51860467f2a5                               badf7047dfaf3c1/mounts/shm
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/7c9c16f7620b43119a5a1337072b6a879dc42ec03dc5ee2e359                               dec5381a06010/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/6b3779082f2c6d0ac0245f791eef8174474e5c114db055fb962                               cc38dbd59369d/merged
overlay                  233G  200G   34G  86% /var/lib/docker/overlay2/6a1fe4696a35a439c5db72a60d3476047343633d5b9505ee186                               7e5608391da23/merged
shm                       64M     0   64M   0% /var/lib/docker/containers/11a25eb0f69d3f7c67c9f2e7e88ddf1a948f697aa5db8be4b                               9dd0605329569cd/mounts/shm
shm                       64M     0   64M   0% /var/lib/docker/containers/0b0cad88d468482bc8fab6d538efd6309519a52ce455efe44                               126b08ce3759ecd/mounts/shm
[root@voles1 ~]#
// 不知道为什么这个 /dev/mapper/centos-root 直接占了200G。。。进去看看
[root@voles1 ~]# cd /dev/
[root@voles1 dev]# cd mapper/
[root@voles1 mapper]# ll
total 0
lrwxrwxrwx 1 root root       7 May 26 19:28 centos-root -> ../dm-0
lrwxrwxrwx 1 root root       7 May 26 19:41 centos-swap -> ../dm-1
crw------- 1 root root 10, 236 May 26 19:28 control
[root@voles1 mapper]# cd cenos-root
-bash: cd: cenos-root: No such file or directory


// 然后不论fdisk还是dmsetup info都看不出来啥。。。
[root@voles1 mapper]#
[root@voles1 mapper]# fdisk -l

Disk /dev/vda: 268.4 GB, 268435456000 bytes, 524288000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000cbfb1

   Device Boot      Start         End      Blocks   Id  System
/dev/vda1   *        2048     2099199     1048576   83  Linux
/dev/vda2         2099200   524287999   261094400   8e  Linux LVM

Disk /dev/mapper/centos-root: 250.2 GB, 250181844992 bytes, 488636416 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/mapper/centos-swap: 17.2 GB, 17175674880 bytes, 33546240 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

[root@voles1 mapper]# 
[root@voles1 mapper]# dmsetup info
Name:              centos-swap
State:             ACTIVE
Read Ahead:        8192
Tables present:    LIVE
Open count:        0
Event number:      0
Major, minor:      253, 1
Number of targets: 1
UUID: LVM-5toAbPiziFesOo8CILcH7y4jGBvaiARgz2gZ4Cr60gvYeAVvFu8cCAi2kzQHzpJN

Name:              centos-root
State:             ACTIVE
Read Ahead:        8192
Tables present:    LIVE
Open count:        1
Event number:      0
Major, minor:      253, 0
Number of targets: 1
UUID: LVM-5toAbPiziFesOo8CILcH7y4jGBvaiARgsqUvYnzuoMj0OuOzQ4WYLsmUAZ2xiTAg

[root@voles1 mapper]#


// 然后按这个帖子里的办法：https://blog.csdn.net/e_wsq/article/details/79531493
[root@voles1 mapper]# du -h -x --max-depth=1
0       .
[root@voles1 mapper]# cd /
[root@voles1 /]# du -h -x --max-depth=1
36M     ./etc
2.5G    ./root
1.5G    ./var
194G    ./tmp
2.1G    ./usr
20K     ./home
0       ./media
0       ./mnt
73M     ./opt
0       ./srv
58M     ./src
4.0K    ./postgres-operator
200G    .
[root@voles1 /]#
[root@voles1 /]# cd tmp/
[root@voles1 tmp]#
[root@voles1 tmp]# du -h -x --max-depth=1
0       ./.ICE-unix
0       ./.font-unix
0       ./.Test-unix
0       ./.XIM-unix
0       ./.X11-unix
0       ./go-build594073601
0       ./go-build761031661
0       ./systemd-private-876ef45532414ce792df4c73e2966c23-ntpd.service-QqSQ7p
0       ./go-build078757484
0       ./vscode-typescript0
0       ./vscode-gorgnTo9
0       ./vscode-govRBuuf
0       ./go-build801015306
0       ./appInsights-nodeAIF-d9b70cd4-b9f9-4d70-929b-a071c400b217
0       ./go-build402348593
194G    ./pg1
0       ./pg2
194G    .
[root@voles1 tmp]#


// 看起来我好像是两个数据库的存储都设置到 /tmp/pg1/ 里了？因为/tmp/pg2/就没用啊。先清理一下再说吧。
[root@voles1 tmp]#
[root@voles1 tmp]# rm -rf /tmp/pg1/*
[root@voles1 tmp]#
[root@voles1 tmp]# du -h -x --max-depth=1
0       ./.ICE-unix
0       ./.font-unix
0       ./.Test-unix
0       ./.XIM-unix
0       ./.X11-unix
0       ./go-build594073601
0       ./go-build761031661
0       ./systemd-private-876ef45532414ce792df4c73e2966c23-ntpd.service-QqSQ7p
0       ./go-build078757484
0       ./vscode-typescript0
0       ./vscode-gorgnTo9
0       ./vscode-govRBuuf
0       ./go-build801015306
0       ./appInsights-nodeAIF-d9b70cd4-b9f9-4d70-929b-a071c400b217
0       ./go-build402348593
0       ./pg1
0       ./pg2
428K    .
[root@voles1 tmp]#


// 然后去看了看，果然是她仿写的时候只改了名字，没改路径
// 能diff出来可能是因为空格或缩进吧，但是很明显她还是挂载在 /tmp/pg1 上了。然后两个数据库实例来回写各种问题导致那个目录基本满了。。。
[root@voles1 tmp]# cd /src/postgres-operator/
[root@voles1 postgres-operator]# ll | grep pv
-rw-r--r-- 1 root root   257 May 22 00:26 pv00.yaml
-rw-r--r-- 1 root root   256 May 24 19:18 pv01.yml
-rw-r--r-- 1 root root   256 May 24 20:13 pv02.yml
-rw-r--r-- 1 root root   220 May 22 00:22 pvc00.yaml
-rw-r--r-- 1 root root   220 May 24 19:19 pvc01.yml
-rw-r--r-- 1 root root   220 May 24 20:14 pvc02.yml
[root@voles1 postgres-operator]#
[root@voles1 postgres-operator]# diff pv00.yaml pv01.yml
4c4
<   name: pv00
---
>   name: pv01
14c14
<     path: "/tmp/pg1"
---
>     path: "/tmp/pg1"
\ No newline at end of file
[root@voles1 postgres-operator]#

```


