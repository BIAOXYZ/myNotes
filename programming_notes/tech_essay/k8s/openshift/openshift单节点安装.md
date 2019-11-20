
# 0. 参考安装步骤

此外，注意为了方便后面好重装，在一开始就先把`/etc/resolv.conf`备份一下。
> cp /etc/resolv.conf /etc/resolv.confbak

```
OpenShift Single Node on iRIS SoftLayer:


https://github.com/openshift/origin

https://www.okd.io/

Installation doc: https://docs.okd.io/latest/install/index.html

CentOS 7.6.1810

sed -i 's/SELINUX=permissive/SELINUX=enforcing/' /etc/selinux/config

update /etc/hosts to use the public ip addresses

# The /etc/resolv.conf has the inmutable flag set, see https://askubuntu.com/questions/947574/no-write-permissions-on-a-file-even-with-sudo
chattr -i /etc/resolv.conf

reboot the nodes
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
yum -y --enablerepo=epel install ansible pyOpenSSL
yum -y install docker-1.13.1 git NetworkManager atomic centos-release-openshift-origin311

##update /etc/NetworkManager/NetworkManager.conf, set dns=none in [main] section

systemctl enable NetworkManager; systemctl start NetworkManager

systemctl enable docker; systemctl start docker; docker version

git clone https://github.com/openshift/openshift-ansible
cd opensift-ansible
git branch -r
git checkout release-3.11
cd inventory
cp hosts.localhost hosts.single-node

[root@openshift-single-node openshift-ansible]# cat inventory/hosts.single-node
#bare minimum hostfile

[OSEv3:children]
masters
nodes
etcd

[OSEv3:vars]
# if your target hosts are Fedora uncomment this
#ansible_python_interpreter=/usr/bin/python3
openshift_deployment_type=origin
openshift_portal_net=172.30.0.0/16
# localhost likely doesn't meet the minimum requirements
openshift_disable_check=disk_availability,memory_availability,docker_storage,docker_image_availability

openshift_node_groups=[{'name': 'node-config-all-in-one', 'labels': ['node-role.kubernetes.io/master=true', 'node-role.kubernetes.io/infra=true', 'node-role.kubernetes.io/compute=true']}]


[masters]
openshift-single-node.sl.cloud9.ibm.com openshift_ip=9.192.210.25 openshift_public_ip=9.192.210.25
#localhost ansible_connection=local

[etcd]
openshift-single-node.sl.cloud9.ibm.com openshift_ip=9.192.210.25 openshift_public_ip=9.192.210.25
#localhost ansible_connection=local

[nodes]
# openshift_node_group_name should refer to a dictionary with matching key of name in list openshift_node_groups.
#localhost ansible_connection=local openshift_node_group_name="node-config-all-in-one"
openshift-single-node.sl.cloud9.ibm.com openshift_ip=9.192.210.25 openshift_public_ip=9.192.210.25 openshift_node_group_name="node-config-all-in-one"
[root@openshift-single-node openshift-ansible]#
cd /root/openshift-ansible
ansible-playbook -i inventory/hosts.single-node playbooks/prerequisites.yml
ansible-playbook -i inventory/hosts.single-node playbooks/deploy_cluster.yml

https://openshift-master.sl.cloud9.ibm.com:8443/console

username: admin
password: <anystr>


oc login -u system:admin


oc create user ligc
oc create clusterrolebinding admin-ligc --clusterrole=cluster-admin --user=ligc
oc login -u ligc


9.192.210.149 prometheus-k8s-openshift-monitoring.router.default.svc.cluster.local
9.192.210.149 grafana-openshift-monitoring.router.default.svc.cluster.local
9.192.210.149 alertmanager-main-openshift-monitoring.router.default.svc.cluster.local
9.192.210.149 console.router.default.svc.cluster.local
9.192.210.149 apiserver-kube-service-catalog.router.default.svc.cluster.local
9.192.210.149 registry-console-default.router.default.svc.cluster.local

https://<url> to access these services, using the user created above


OpenShift Key Components:
Ansible Installer
SDN - Open vSwitch
Ingress/Routes: HAProxy
DNS: dnsmasq
authentication: oAuth
Registry: Atomic Registry
Storage: GlusterFS, Ceph
Monitoring: Prometheus, Grafana, AlterManager
Security: SCC(Security Context Constrains)


debug NetworkManager:

journalctl -f -u NetworkManager.service
or tail -f /var/log/messages

systemctl restart NetworkManager

By default, OpenShift does not allow the PODs run as root, to enable the PODs to run as root:

oadm policy add-scc-to-user anyuid -z default


uninstall OpenShift:
ansible-playbook -i inventory/hosts.single-node playbooks/adhoc/uninstall.yml
rpm -e dnsmasq
cp /etc/resolv.conf.bak /etc/resolv.conf
```


# 1. 安装过程记录

***注：openshift2和myopenshift是等价的。。。除了这俩名字不一样，其他都一样。只是在Tokyo 2区域的openshift2上装的时候回退到之前的commit也不行，后来在London 2区域的myopenshift上装的时候回退了社区代码最新引入的问题就可以安装成功了。***
- No longer able to install OKD 3.11 using ansible playbook, control plane pod never shows up https://github.com/openshift/openshift-ansible/issues/11666
  * (可能相关的问题，但是比较久了——这个2018.08.14的，上面那个就是今天2019.06.06凌晨的) https://github.com/openshift/openshift-ansible/issues/9575
    > `journalctl -flu docker.service`

## 备份`/etc/resolv.conf`

//备份下`/etc/resolv.conf`，因为后面每次卸载重装openshift要用它覆盖安装过程中修改过的。
> cp /etc/resolv.conf /etc/resolv.confbak

## 开启selinux

//实际上[官方攻略](https://docs.openshift.com/container-platform/3.11/install/prerequisites.html)里还要求把SELINUXTYPE设置成targeted。但是好像这个一般默认就是，所以没有管。
> sed -i 's/SELINUX=permissive/SELINUX=enforcing/' /etc/selinux/config

## 可选

//这一步要视具体环境而定，Softlayer上的机器有两套IP，10开头的对内，9开头的对外。这里要把默认的10开头的换成9开头的。但不是所有环境的机器都得做。
> update /etc/hosts to use the public ip addresses
```
[root@myopenshift ~]# cp /etc/hosts /etc/hostsbak
[root@myopenshift ~]# cat /etc/hosts
127.0.0.1 localhost.localdomain localhost
10.112.80.233 myopenshift.sl.cloud9.ibm.com myopenshift
[root@myopenshift ~]# sed -i "s/10.112.80.233/9.12.248.233/g" /etc/hosts
[root@myopenshift ~]# cat /etc/hosts
127.0.0.1 localhost.localdomain localhost
9.12.248.233 myopenshift.sl.cloud9.ibm.com myopenshift
```

## 这一步似乎也是可选的，因为有的机器/etc/resolv.conf可以直接编辑。但是如果不能编辑，安装就失败了，所以还是执行下。

> chattr -i /etc/resolv.conf

## 重启，没啥说的

> reboot

## 对本机建立互信

```
//第一句在任何目录下执行都可以，都是在当前用户家目录下的.ssh文件夹建立密钥。
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

## 一堆yum的，不再赘述了。

```
//执行该命令前后/etc/yum.repos.d/目录里的变化，多了两个epel的.repo文件
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

[root@openshift2 yum.repos.d]$ ll
total 32
-rw-r--r--. 1 root root 1708 May 11 12:57 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 May 11 12:57 CentOS-CR.repo
-rw-r--r--. 1 root root  649 May 11 12:57 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 May 11 12:57 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 May 11 12:57 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 May 11 12:57 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 May 11 12:57 CentOS-Vault.repo
[root@openshift2 yum.repos.d]$ ll
total 40
-rw-r--r--. 1 root root 1708 May 11 12:57 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 May 11 12:57 CentOS-CR.repo
-rw-r--r--. 1 root root  649 May 11 12:57 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 May 11 12:57 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 May 11 12:57 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 May 11 12:57 CentOS-Sources.repo
-rw-r--r--. 1 root root 5701 May 11 12:57 CentOS-Vault.repo
-rw-r--r--. 1 root root  951 Oct  2  2017 epel.repo
-rw-r--r--. 1 root root 1050 Oct  2  2017 epel-testing.repo
```

```
[root@openshift2 yum.repos.d]$ cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repobak
[root@openshift2 yum.repos.d]$ sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
[root@openshift2 yum.repos.d]$ diff /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repobak
6c6
< enabled=0
---
> enabled=1
```

```
//docker-ce大概率是不行的，已经在不同环境试验过两次了。所以还是用下面未注释的两个语句！
//————https://docs.openshift.com/container-platform/3.11/install/host_preparation.html
//yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
//yum -y install docker-ce git NetworkManager atomic centos-release-openshift-origin311


yum -y --enablerepo=epel install ansible pyOpenSSL
yum -y install docker-1.13.1 git NetworkManager atomic centos-release-openshift-origin311
```

## 改`NetworkManager.conf`

> update /etc/NetworkManager/NetworkManager.conf, set dns=none in [main] section
```
cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.confbak

然后添加dns=none到[main]部分
```

## 启动两个服务

```
//命令的服务名后面带不带.service看来都一样。dockers也是一样的。
systemctl enable NetworkManager
systemctl start NetworkManager
systemctl enable docker
systemctl start docker


root@openshift2 ~ $ systemctl status NetworkManager
● NetworkManager.service - Network Manager
   Loaded: loaded (/usr/lib/systemd/system/NetworkManager.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-06-05 02:55:11 CDT; 59s ago
     Docs: man:NetworkManager(8)
 Main PID: 24826 (NetworkManager)
   CGroup: /system.slice/NetworkManager.service
           └─24826 /usr/sbin/NetworkManager --no-daemon

Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8592] device (eth0): state change: disconnected -...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8596] device (eth0): state change: prepare -> con...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8601] device (eth0): state change: config -> ip-c...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8603] device (eth0): state change: ip-config -> i...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8612] device (eth0): state change: ip-check -> se...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8614] device (eth0): state change: secondaries ->...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8617] manager: NetworkManager state is now CONNEC...LOCAL
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8624] device (eth0): Activation: successful, devi...ated.
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8632] manager: NetworkManager state is now CONNEC...LOBAL
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8639] manager: startup complete
Hint: Some lines were ellipsized, use -l to show in full.
root@openshift2 ~ $
root@openshift2 ~ $ systemctl status NetworkManager.service
● NetworkManager.service - Network Manager
   Loaded: loaded (/usr/lib/systemd/system/NetworkManager.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-06-05 02:55:11 CDT; 1min 4s ago
     Docs: man:NetworkManager(8)
 Main PID: 24826 (NetworkManager)
   CGroup: /system.slice/NetworkManager.service
           └─24826 /usr/sbin/NetworkManager --no-daemon

Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8592] device (eth0): state change: disconnected -...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8596] device (eth0): state change: prepare -> con...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8601] device (eth0): state change: config -> ip-c...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8603] device (eth0): state change: ip-config -> i...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8612] device (eth0): state change: ip-check -> se...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8614] device (eth0): state change: secondaries ->...nal')
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8617] manager: NetworkManager state is now CONNEC...LOCAL
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8624] device (eth0): Activation: successful, devi...ated.
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8632] manager: NetworkManager state is now CONNEC...LOBAL
Jun 05 02:55:11 openshift2 NetworkManager[24826]: <info>  [1559721311.8639] manager: startup complete
Hint: Some lines were ellipsized, use -l to show in full.
```

## 下载openshift-ansible源码仓库，编辑自己的inventory file

```
git clone https://github.com/openshift/openshift-ansible
cd opensift-ansible
git branch -r
git checkout release-3.11
cd inventory
cp hosts.localhost hosts.single-node
```

### 用到的inventory file

```
[root@myopenshift openshift-ansible]# cat inventory/hosts.single-node
#bare minimum hostfile

[OSEv3:children]
masters
nodes
etcd

[OSEv3:vars]
# if your target hosts are Fedora uncomment this
#ansible_python_interpreter=/usr/bin/python3
openshift_deployment_type=origin
openshift_portal_net=172.30.0.0/16
# localhost likely doesn't meet the minimum requirements
###openshift_disable_check=disk_availability,memory_availability
openshift_disable_check=disk_availability,memory_availability,docker_storage,docker_image_availability

openshift_node_groups=[{'name': 'node-config-all-in-one', 'labels': ['node-role.kubernetes.io/master=true', 'node-role.kubernetes.io/infra=true', 'node-role.kubernetes.io/compute=true']}]


##################################################
#// 可选，如果需要（用htpasswd）设置用户名密码就加上这里的这两段。
#// testuser的密码是1234，其后面那个串是用htpasswd命令得到的。

# This variable enables htpasswd auth
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]

# This variable Defines htpasswd users. Here, the user name is "testuser" and the password is "1234".
openshift_master_htpasswd_users={'testuser': '$apr1$rgyNGgYv$igUtUQh0.8M5tGmhAh9Xg1'}
##################################################


[masters]
###localhost ansible_connection=local
myopenshift.sl.cloud9.ibm.com openshift_ip=9.12.248.233 openshift_public_ip=9.12.248.233

[etcd]
###localhost ansible_connection=local
myopenshift.sl.cloud9.ibm.com openshift_ip=9.12.248.233 openshift_public_ip=9.12.248.233

[nodes]
# openshift_node_group_name should refer to a dictionary with matching key of name in list openshift_node_groups.
###localhost ansible_connection=local openshift_node_group_name="node-config-all-in-one"
myopenshift.sl.cloud9.ibm.com openshift_ip=9.12.248.233 openshift_public_ip=9.12.248.233 openshift_node_group_name="node-config-all-in-one"
```

## 用ansible进行预安装和安装

```
cd /root/openshift-ansible
ansible-playbook -i inventory/hosts.single-node playbooks/prerequisites.yml
ansible-playbook -i inventory/hosts.single-node playbooks/deploy_cluster.yml
```

## 安装过程中错误

> 0.额外问题，将来社区肯定会解决，参见开头部分那个issue的链接。害我换了台机器。。。还是不行。再次提醒：这个攻略里openshift2和myopenshift是等价的。
```
failed: [openshift2] (item=api) => {"attempts": 60, "changed": false, "item": "api", "msg": {"cmd": "/usr/bin/oc get pod master-api-openshift2 -o json -n kube-system", "results": [{}], "returncode": 1, "stderr": "The connection to the server druidcluster3.sl.cloud9.ibm.com:8443 was refused - did you specify the right host or port?\n", "stdout": ""}}
```

> 1.ansible有可能版本过高，还得回退。。。
```
[root@openshift2 openshift-ansible]$ ansible-playbook -i inventory/hosts.single-node playbooks/prerequisites.yml
FATAL: Current Ansible version (2.8.0) is not supported. Supported versions: 2.5.7 or newer but less than 2.8.0

yum remove -y ansible
yum list | grep ansible
yum install -y ansible-2.6.14-1.el7
```

> 2.我觉得再次证明了docker-ce是不支持的，只能支持到docker1.13。
```
TASK [container_runtime : Install Docker] *************************************************************************************
Wednesday 05 June 2019  03:44:19 -0500 (0:00:00.064)       0:00:59.213 ********
FAILED - RETRYING: Install Docker (3 retries left).
FAILED - RETRYING: Install Docker (2 retries left).
FAILED - RETRYING: Install Docker (1 retries left).
fatal: [openshift2]: FAILED! => {"attempts": 3, "changed": false, "msg": "Error: docker-ce conflicts with 2:docker-1.13.1-96.gitb2f74b2.el7.centos.x86_64\nError: docker-ce-cli conflicts with 2:docker-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n", "rc": 1, "results": ["1:atomic-1.22.1-26.gitb507039.el7.centos.x86_64 providing atomic is already installed", "1:skopeo-0.1.35-2.git404c5bd.el7.centos.x86_64 providing skopeo is already installed", "Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * centos-ansible26: ftp-srv2.kddilabs.jp\nResolving Dependencies\n--> Running transaction check\n---> Package docker.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos will be installed\n--> Processing Dependency: docker-common = 2:1.13.1-96.gitb2f74b2.el7.centos for package: 2:docker-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Processing Dependency: docker-client = 2:1.13.1-96.gitb2f74b2.el7.centos for package: 2:docker-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Processing Dependency: subscription-manager-rhsm-certificates for package: 2:docker-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Running transaction check\n---> Package docker-client.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos will be installed\n---> Package docker-common.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos will be installed\n--> Processing Dependency: oci-umount >= 2:2.3.3-3 for package: 2:docker-common-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Processing Dependency: oci-systemd-hook >= 1:0.1.4-9 for package: 2:docker-common-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Processing Dependency: oci-register-machine >= 1:0-5.13 for package: 2:docker-common-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n--> Processing Dependency: atomic-registries for package: 2:docker-common-1.13.1-96.gitb2f74b2.el7.centos.x86_64\n---> Package subscription-manager-rhsm-certificates.x86_64 0:1.21.10-3.el7.centos will be installed\n--> Running transaction check\n---> Package atomic-registries.x86_64 1:1.22.1-26.gitb507039.el7.centos will be installed\n--> Processing Dependency: python-pytoml for package: 1:atomic-registries-1.22.1-26.gitb507039.el7.centos.x86_64\n---> Package oci-register-machine.x86_64 1:0-6.git2b44233.el7 will be installed\n---> Package oci-systemd-hook.x86_64 1:0.1.18-3.git8787307.el7_6 will be installed\n--> Processing Dependency: libyajl.so.2()(64bit) for package: 1:oci-systemd-hook-0.1.18-3.git8787307.el7_6.x86_64\n---> Package oci-umount.x86_64 2:2.3.4-2.git87f9237.el7 will be installed\n--> Running transaction check\n---> Package python-pytoml.noarch 0:0.1.14-1.git7dea353.el7 will be installed\n---> Package yajl.x86_64 0:2.0.4-4.el7 will be installed\n--> Processing Conflict: 3:docker-ce-18.09.6-3.el7.x86_64 conflicts docker\n--> Processing Conflict: 3:docker-ce-18.09.6-3.el7.x86_64 conflicts docker-io\n--> Processing Conflict: 1:docker-ce-cli-18.09.6-3.el7.x86_64 conflicts docker\n--> Processing Conflict: 1:docker-ce-cli-18.09.6-3.el7.x86_64 conflicts docker-io\n--> Finished Dependency Resolution\n You could try using --skip-broken to work around the problem\n You could try running: rpm -Va --nofiles --nodigest\n"]}

PLAY RECAP ********************************************************************************************************************
localhost                  : ok=11   changed=0    unreachable=0    failed=0
openshift2                 : ok=55   changed=12   unreachable=0    failed=1
```

> 3.这是最早安装时候的一个错误（当时的主机叫openshiftsingle）：inventory file是之前在Hong Kong region的一台机器上安装时的配置，因为多了个换行，导致出错。
```
[root@openshiftsingle openshift-ansible]# ansible-playbook -i inventory/hosts.single-node playbooks/prerequisites.yml

PLAY [Fail openshift_kubelet_name_override for new hosts] *********************************************************************

TASK [Gathering Facts] ********************************************************************************************************
Monday 29 April 2019  03:19:08 -0500 (0:00:00.128)       0:00:00.128 **********
ok: [openshiftsingle.sl.cloud9.ibm.com]
fatal: [openshift_node_group_name=node-config-all-in-one]: UNREACHABLE! => {"changed": false, "msg": "SSH Error: data could not be sent to remote host \"openshift_node_group_name=node-config-all-in-one\". Make sure this host can be reached over ssh", "unreachable": true}


PLAY [Verify Requirements] ****************************************************************************************************

TASK [Run variable sanity checks] *********************************************************************************************
Monday 29 April 2019  03:19:23 -0500 (0:00:00.109)       0:00:15.801 **********
fatal: [openshiftsingle.sl.cloud9.ibm.com]: FAILED! => {"msg": "last_checked_host: openshift_node_group_name=node-config-all-in-one, last_checked_var: ansible_python;'NoneType' object has no attribute '__getitem__'"}

PLAY RECAP ********************************************************************************************************************
localhost                  : ok=11   changed=0    unreachable=0    failed=0
openshift_node_group_name=node-config-all-in-one : ok=0    changed=0    unreachable=1    failed=0
openshiftsingle.sl.cloud9.ibm.com : ok=40   changed=4    unreachable=0    failed=1

----------------------------------------------------------------------------------------------------

//事实证明引起错误的原因是为了inventory file看起来更好看点，[nodes]部分自己换了一行。实际上是不能换行的！
//修改后两个bug同时解决。

//修改前
[nodes]
# openshift_node_group_name should refer to a dictionary with matching key of name in list openshift_node_groups.
###localhost ansible_connection=local openshift_node_group_name="node-config-all-in-one"
openshiftsingle.sl.cloud9.ibm.com openshift_ip=9.186.102.139 openshift_public_ip=9.186.102.139
openshift_node_group_name="node-config-all-in-one"

//修改后
[nodes]
# openshift_node_group_name should refer to a dictionary with matching key of name in list openshift_node_groups.
###localhost ansible_connection=local openshift_node_group_name="node-config-all-in-one"
openshiftsingle.sl.cloud9.ibm.com openshift_ip=9.186.102.139 openshift_public_ip=9.186.102.139 openshift_node_group_name="node-config-all-in-one"
```

# 2. 安装完成后常用的关于卸载安装的动作

安装成功后webconsole地址为： https://myopenshift.sl.cloud9.ibm.com:8443/console

```
//单句安装
cd /root/openshift-ansible && ansible-playbook -i inventory/hosts.single-node playbooks/deploy_cluster.yml

//单句卸载
cd /root/openshift-ansible && ansible-playbook -i inventory/hosts.single-node playbooks/adhoc/uninstall.yml && rpm -e dnsmasq && \cp /etc/resolv.confbak /etc/resolv.conf

//单句重装。PS:之前不知道-b参数
//ansible-playbook -b -i ./hosts ~/src/openshift-ansible/playbooks/deploy_cluster.yml
cd /root/openshift-ansible;ansible-playbook -b -i inventory/hosts.single-node playbooks/deploy_cluster.yml
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 3. （后期补充的）安全相关问题

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 3.1 用户相关

### 3.1.1 How to add a default user to an Openshift cluster?

1. Open the corresponding Ansible inventory file of the cluster.
2. Add the following two new variables to the `[OSEv3:vars]` section of the file.
```
# This variable enables htpasswd auth
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]

# This variable Defines htpasswd users. Here, the user name is "testuser" and the password is "1234".
openshift_master_htpasswd_users={'testuser': '$apr1$rgyNGgYv$igUtUQh0.8M5tGmhAh9Xg1'}
```

### 3.1.2 How to deal with more users?

- Change the value of `openshift_master_htpasswd_users`, adding more key-value pairs and using commas to separate them. 
```
openshift_master_htpasswd_users={'jsmith': '$apr1$wIwXkFLI$bAygtKGmPOqaJftB', 'bloblaw': '7IRJ$2ODmeLoxf4I6sUEKfiA$2aDJqLJe'}
```

- User another variable which indicates a path of a file for user-password management.
```
openshift_master_htpasswd_file=<path/to/local/pre-generated/htpasswdfile>
```

### 3.1.3 How to obtain the value part of a key-value pair for username and password (hash)?

```sh
usage: htpasswd -nb ${username} ${userpassword}

[root@openshift-single-node ~]# htpasswd -nb testuser 1234
testuser:$apr1$rgyNGgYv$igUtUQh0.8M5tGmhAh9Xg1
```

### 3.1.4 Reference links

https://docs.okd.io/3.10/install/configuring_inventory_file.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 3.2 `system:admin`相关

> How to specify the password for system:admin in inventory file?

### 3.2.1 A short conclusion: 

1. There is no password for `system:admin`. 
2. When we try to login with it, we use `oc login -u system:admin -n default` instead of the non-interactive form `oc login -u $username -p $userpassword` or the interactive form like `oc login -u $username -- then input password in the prompt`. Actually, directly use `oc login -u system:admin` can work.

### 3.2.2 The whole process:

```sh
// From default login user "system:admin" to a user "testuser" who is configed in the inventory file.
// Then logout "testuser".
[root@openshiftsingle ~]# oc whoami
system:admin
[root@openshiftsingle ~]# oc login -u testuser -p 1234
Login successful.

You have one project on this server: "111"

Using project "111".
[root@openshiftsingle ~]# oc logout
Logged "testuser" out on "https://openshiftsingle.sl.cloud9.ibm.com:8443"

// Login "system:admin".
[root@openshiftsingle ~]# oc whoami
Error from server (Forbidden): users.user.openshift.io "~" is forbidden: User "system:anonymous" cannot get users.user.openshift.io at the cluster scope: no RBAC policy matched
[root@openshiftsingle ~]# oc login -u system:admin -p 1234
error: username system:admin is invalid for basic auth
[root@openshiftsingle ~]# oc login -u system:admin -n default
Logged into "https://openshiftsingle.sl.cloud9.ibm.com:8443" as "system:admin" using existing credentials.

You have access to the following projects and can switch between them with 'oc project <projectname>':

    111
  * default
    kube-public
    kube-service-catalog
    kube-system
    management-infra
    openshift
    openshift-ansible-service-broker
    openshift-console
    openshift-infra
    openshift-logging
    openshift-monitoring
    openshift-node
    openshift-sdn
    openshift-template-service-broker
    openshift-web-console

Using project "default".
[root@openshiftsingle ~]# oc whoami
system:admin
```

### 3.2.3 Reference links:

- https://github.com/minishift/minishift/issues/2601
  * > @gbraad AFAIK, system:admin is not a user but a service account, so it has no password but a token. What oc cluster do is get the token and write it in kubeconfig for so you can directly access.
What your asking is probably a better question for @liggitt.
- https://docs.openshift.com/container-platform/3.11/dev_guide/authentication.html
  * > If you have access to administrator credentials but are no longer logged in as the default system user system:admin, you can log back in as this user at any time as long as the credentials are still present in your CLI configuration file. The following command logs in and switches to the default project:
    >> `$ oc login -u system:admin -n default`
