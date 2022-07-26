
# DevStack

DevStack https://docs.openstack.org/devstack/latest/

Install via Devstack https://docs.openstack.org/tacker/rocky/install/devstack.html

openstack的DevStack安装 https://xn--helloworld-pf2pka.top/archives/178

DevStack安装OpenStack https://changhungtao.github.io/%E6%8A%80%E6%9C%AF/2018/12/26/DevStack%E5%AE%89%E8%A3%85OpenStack.html

Devstack https://huataihuang.gitbooks.io/cloud-atlas/content/iaas/openstack/devstack/deploy_devstack.html
- > **重启**
  * > Devstack不是通过服务方式运行的，而是通过screen程序。在成功运行了stack.sh之后，如果需要重启任何openstack服务，使用screen -r来连接screen。例如，要重启nova网络，则连接screen 9来访问nova网络的screen（使用命令CTRL+A和9）。要停止nova网络，使用｀CTRL+C`然后再使用向上键再回车。
  * > 如果重启了主机，则还是需要再运行一次`stack.sh`脚本。
- > **devstack环境要求**
  * > 如果由于意外中断devstack运行（如强制关机），则需要先运行 `./unstack.sh` 清理环境，然后重启运行 `./stack.sh` 脚本重建会话。
- > **停止DevStack**
  * > `unstack.sh`将停止所有由`stack.sh`启动的进程。所有进程的停止可以通过命令行设置`UNSTACK_ALL`或在specifying `--all`
    ```sh
    ./unstack.sh --all
    ```
- > **重启devstack**
  * > 使用`rejoin-stack.sh`来重启DevStack
    ```sh
    ./rejoin-stack.sh &
    ```
>> //notes：不知道是不是我这环境的原因，反正用 unstack.sh 脚本没搞成。。。用 clean.sh 也没搞成。看提示貌似都是 openvswitch 的问题。。。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 安装遇到的问题第一批
>> //notes：猜测主要原因是因为原来的虚拟机 Ubuntu 20.04 里 Python 版本乱了。后来重装虚拟机后只有 Python 3.8，所有 Python 版本的问题都没了。剩下的两个问题很好解决。

openStack常见报错 https://blog.csdn.net/qq_40907977/article/details/103452775

How to install DevStack when firewall blocks git https://superuser.com/questions/1209894/how-to-install-devstack-when-firewall-blocks-git
- https://superuser.com/questions/1209894/how-to-install-devstack-when-firewall-blocks-git/1295587#1295587

Openstack devstack installation stalls with git call failure https://stackoverflow.com/questions/25866608/openstack-devstack-installation-stalls-with-git-call-failure

How to install python-mysqldb for Python 2.7 in Ubuntu 20.04 (Focal Fossa)? https://stackoverflow.com/questions/63457213/how-to-install-python-mysqldb-for-python-2-7-in-ubuntu-20-04-focal-fossa

ERROR /opt/stack/devstack/lib/neutron_plugins/ovn_agent:174 Socket https://stackoverflow.com/questions/68001501/error-opt-stack-devstack-lib-neutron-plugins-ovn-agent174-socket
- https://stackoverflow.com/questions/68001501/error-opt-stack-devstack-lib-neutron-plugins-ovn-agent174-socket/69010263#69010263
  >> //notes：这个回答的细节不完全适用，因为我机器上的版本没有找到第2步里的 `ovn_agent` 文件。但是在这个回答的启发下，直接把 `/var/run/` 下面的 `ovn` 子目录和 `openvswitch` 删掉，然后再 `./unstack.sh` + `./clean.sh` + 重启虚拟机后再执行 `./stack.sh`，终于可以了。。。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 个人实战

### 安装以及后续方便操作配置环境变量脚本

【[:star:][`*`]】 Ubuntu 20使用devstack快速安装openstack最新版 https://blog.csdn.net/Q0717168/article/details/114328885 || https://www.cnblogs.com/dyd168/p/14476271.html

```sh
sudo apt-get install bridge-utils git python3-pip -y

sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo su - stack

# git clone https://opendev.org/openstack/devstack
git clone https://github.com/openstack/devstack
cd devstack

cat << EOF > local.conf
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
EOF

FORCE=yes ./stack.sh
```
```sh
#// 以下为最后成功时末尾处屏幕上的输出信息。

~/tempest ~/tempest
++lib/tempest:install_tempest_plugins:802   [[ 0 != 0 ]]
++lib/tempest:install_tempest_plugins:811   popd
~/tempest
++extras.d/80-tempest.sh:source:27          [[ stack == \u\n\s\t\a\c\k ]]
++extras.d/80-tempest.sh:source:32          [[ stack == \c\l\e\a\n ]]
+functions-common:run_phase:1889           [[ stack == \s\o\u\r\c\e ]]
+functions-common:run_phase:1892           [[ stack == \o\v\e\r\r\i\d\e\_\d\e\f\a\u\l\t\s ]]
+functions-common:run_phase:1895           run_plugins stack test-config
+functions-common:run_plugins:1854         local mode=stack
+functions-common:run_plugins:1855         local phase=test-config
+functions-common:run_plugins:1857         local plugins=
+functions-common:run_plugins:1858         local plugin
+./stack.sh:main:1485                      merge_config_group /opt/stack/devstack/local.conf test-config
+inc/meta-config:merge_config_group:171    local localfile=/opt/stack/devstack/local.conf
+inc/meta-config:merge_config_group:171    shift
+inc/meta-config:merge_config_group:172    local matchgroups=test-config
+inc/meta-config:merge_config_group:174    [[ -r /opt/stack/devstack/local.conf ]]
+inc/meta-config:merge_config_group:176    local configfile group
+inc/meta-config:merge_config_group:177    for group in $matchgroups
++inc/meta-config:merge_config_group:178    get_meta_section_files /opt/stack/devstack/local.conf test-config
++inc/meta-config:get_meta_section_files:63  local file=/opt/stack/devstack/local.conf
++inc/meta-config:get_meta_section_files:64  local matchgroup=test-config
++inc/meta-config:get_meta_section_files:66  [[ -r /opt/stack/devstack/local.conf ]]
++inc/meta-config:get_meta_section_files:68  awk -v matchgroup=test-config '
        /^\[\[.+\|.*\]\]/ {
            gsub("[][]", "", $1);
            split($1, a, "|");
            if (a[1] == matchgroup)
                print a[2]
        }
    ' /opt/stack/devstack/local.conf
+./stack.sh:main:1490                      set +o xtrace

=========================
DevStack Component Timing
 (times are in seconds)  
=========================
wait_for_service      23
pip_install          237
apt-get              1083
run_process           43
dbsync                 5
git_timed            521
apt-get-update         6
test_with_retry        6
async_wait           120
osc                  476
-------------------------
Unaccounted time      10
=========================
Total runtime        2530

=================
 Async summary
=================
 Time spent in the background minus waits: 723 sec
 Elapsed time: 2530 sec
 Time if we did everything serially: 3253 sec
 Speedup:  1.28577


Post-stack database query stats:
+------------+-----------+-------+
| db         | op        | count |
+------------+-----------+-------+
| keystone   | SELECT    | 58065 |
| keystone   | SHOW      |   106 |
| keystone   | CREATE    |    71 |
| keystone   | INSERT    |   100 |
| keystone   | ALTER     |     3 |
| keystone   | UPDATE    |    14 |
| glance     | SELECT    |  1000 |
| glance     | CREATE    |    65 |
| glance     | INSERT    |   256 |
| glance     | SHOW      |     8 |
| glance     | UPDATE    |    13 |
| glance     | ALTER     |    10 |
| glance     | DROP      |     3 |
| neutron    | SELECT    |  4349 |
| neutron    | SHOW      |    39 |
| neutron    | CREATE    |   319 |
| cinder     | SELECT    |   184 |
| cinder     | SHOW      |     1 |
| cinder     | CREATE    |    74 |
| cinder     | SET       |     1 |
| cinder     | ALTER     |    18 |
| neutron    | INSERT    |  1127 |
| neutron    | UPDATE    |   238 |
| neutron    | ALTER     |   150 |
| neutron    | DROP      |    52 |
| neutron    | DELETE    |    31 |
| nova_cell1 | SELECT    |   219 |
| nova_cell1 | SHOW      |    60 |
| nova_cell1 | CREATE    |   210 |
| nova_cell0 | SELECT    |   217 |
| nova_cell0 | SHOW      |    60 |
| nova_cell0 | CREATE    |   210 |
| nova_cell0 | ALTER     |     2 |
| nova_cell1 | ALTER     |     2 |
| placement  | SELECT    |    34 |
| placement  | INSERT    |    52 |
| placement  | SET       |     1 |
| nova_api   | SELECT    |   114 |
| nova_cell0 | INSERT    |     5 |
| nova_cell0 | UPDATE    |    33 |
| placement  | UPDATE    |     3 |
| nova_cell1 | INSERT    |     3 |
| nova_cell1 | UPDATE    |    34 |
| cinder     | INSERT    |     5 |
| cinder     | UPDATE    |    21 |
| nova_api   | INSERT    |    20 |
| nova_api   | SAVEPOINT |    10 |
| nova_api   | RELEASE   |    10 |
| cinder     | DELETE    |     1 |
| keystone   | DELETE    |    10 |
+------------+-----------+-------+



This is your host IP address: 172.16.175.128
This is your host IPv6 address: ::1
Horizon is now available at http://172.16.175.128/dashboard
Keystone is serving at http://172.16.175.128/identity/
The default users are: admin and demo
The password: secret

Services are running under systemd unit files.
For more information see: 
https://docs.openstack.org/devstack/latest/systemd.html

DevStack Version: zed
Change: bd6e5205b115fb0cafed7f50a676699a4b9fc0fe Increase timeout waiting for OVN startup 2022-07-03 22:30:41 +0200
OS Version: Ubuntu 20.04 focal

2022-07-22 13:29:11.851 | stack.sh completed in 2530 seconds.
stack@ubuntu:~/devstack$ 
```

```sh
cat << EOF > admin-openrc.sh
export OS_USERNAME=admin
export OS_PASSWORD=secret
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://172.16.175.128/identity
export OS_IDENTITY_API_VERSION=3
EOF

source admin-openrc.sh
```
```
stack@ubuntu:~/devstack$ nova service-list
nova CLI is deprecated and will be a removed in a future release
+--------------------------------------+----------------+--------+----------+---------+-------+----------------------------+-----------------+-------------+
| Id                                   | Binary         | Host   | Zone     | Status  | State | Updated_at                 | Disabled Reason | Forced down |
+--------------------------------------+----------------+--------+----------+---------+-------+----------------------------+-----------------+-------------+
| ee8349eb-0cb6-465e-9427-1c2e2c1ab7a2 | nova-scheduler | ubuntu | internal | enabled | up    | 2022-07-22T14:04:03.000000 | -               | False       |
| f1e4a0a2-5243-4686-b595-07031d4789a5 | nova-conductor | ubuntu | internal | enabled | up    | 2022-07-22T14:04:03.000000 | -               | False       |
| 1dc811e9-131c-4f94-be43-16095079efd6 | nova-conductor | ubuntu | internal | enabled | up    | 2022-07-22T14:04:06.000000 | -               | False       |
| dc7c381a-7e55-4a45-bef8-8d2d71d3ba75 | nova-compute   | ubuntu | nova     | enabled | up    | 2022-07-22T14:04:02.000000 | -               | False       |
+--------------------------------------+----------------+--------+----------+---------+-------+----------------------------+-----------------+-------------+
stack@ubuntu:~/devstack$ 
stack@ubuntu:~/devstack$ openstack network agent list
/usr/lib/python3/dist-packages/secretstorage/dhcrypto.py:15: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
/usr/lib/python3/dist-packages/secretstorage/util.py:19: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
+--------------------------------------+------------------------------+--------+-------------------+-------+-------+----------------------------+
| ID                                   | Agent Type                   | Host   | Availability Zone | Alive | State | Binary                     |
+--------------------------------------+------------------------------+--------+-------------------+-------+-------+----------------------------+
| e27abd4e-36da-5ae2-badf-44f70e89d7f3 | OVN Metadata agent           | ubuntu |                   | :-)   | UP    | neutron-ovn-metadata-agent |
| ba8530be-71b4-451a-9574-996da88a4e7c | OVN Controller Gateway agent | ubuntu |                   | :-)   | UP    | ovn-controller             |
+--------------------------------------+------------------------------+--------+-------------------+-------+-------+----------------------------+
stack@ubuntu:~/devstack$
```

### 创建虚拟机
>> //notes：openstack 资源需求太高了，虚拟机创建完刚把屏幕上的输出复制好，就开始卡住不动了。。。Mac Pro也开始狂响，不知道这次 VMWare虚机 + 虚机里的openstack 能撑住不。。。

【[:star:][`*`]】 OpenStack命令行操作之虚机管理实现 https://www.sdnlab.com/20489.html
>> //notes：没有走创建自定义镜像这一步，所以跟原文的步骤有一点点不一样。。。

```sh
# 创建自定义 flavor
stack@ubuntu:~/devstack$ openstack flavor create myflavor --ram 256 --disk 1 --vcpus 1 --public
/usr/lib/python3/dist-packages/secretstorage/dhcrypto.py:15: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
/usr/lib/python3/dist-packages/secretstorage/util.py:19: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
+----------------------------+--------------------------------------+
| Field                      | Value                                |
+----------------------------+--------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                |
| OS-FLV-EXT-DATA:ephemeral  | 0                                    |
| description                | None                                 |
| disk                       | 1                                    |
| id                         | 67a4cbf8-47b4-4ba6-a1c4-3c4dcfef43ac |
| name                       | myflavor                             |
| os-flavor-access:is_public | True                                 |
| properties                 |                                      |
| ram                        | 256                                  |
| rxtx_factor                | 1.0                                  |
| swap                       |                                      |
| vcpus                      | 1                                    |
+----------------------------+--------------------------------------+
stack@ubuntu:~/devstack$ 

# 创建自定义 network
stack@ubuntu:~/devstack$ openstack network create mynetwork --external
/usr/lib/python3/dist-packages/secretstorage/dhcrypto.py:15: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
/usr/lib/python3/dist-packages/secretstorage/util.py:19: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | UP                                   |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2022-07-26T13:27:17Z                 |
| description               |                                      |
| dns_domain                | None                                 |
| id                        | ac4b2563-01ad-409f-bd1a-3864a570f0ac |
| ipv4_address_scope        | None                                 |
| ipv6_address_scope        | None                                 |
| is_default                | False                                |
| is_vlan_transparent       | None                                 |
| mtu                       | 1442                                 |
| name                      | mynetwork                            |
| port_security_enabled     | True                                 |
| project_id                | 3611624782254240af9f5fbda4139699     |
| provider:network_type     | geneve                               |
| provider:physical_network | None                                 |
| provider:segmentation_id  | 1659                                 |
| qos_policy_id             | None                                 |
| revision_number           | 1                                    |
| router:external           | External                             |
| segments                  | None                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| updated_at                | 2022-07-26T13:27:18Z                 |
+---------------------------+--------------------------------------+
stack@ubuntu:~/devstack$ 
# 创建自定义 subnet
stack@ubuntu:~/devstack$ openstack subnet create mynetwork_subnet --allocation-pool start=172.171.5.210,end=172.171.5.213 --subnet-range 172.171.5.0/20 --dns-nameserver 114.114.114.114 --gateway 172.171.0.1 --network mynetwork
/usr/lib/python3/dist-packages/secretstorage/dhcrypto.py:15: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
/usr/lib/python3/dist-packages/secretstorage/util.py:19: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
The option [tenant_id] has been deprecated. Please avoid using it.
+----------------------+--------------------------------------+
| Field                | Value                                |
+----------------------+--------------------------------------+
| allocation_pools     | 172.171.5.210-172.171.5.213          |
| cidr                 | 172.171.0.0/20                       |
| created_at           | 2022-07-26T13:34:20Z                 |
| description          |                                      |
| dns_nameservers      | 114.114.114.114                      |
| dns_publish_fixed_ip | None                                 |
| enable_dhcp          | True                                 |
| gateway_ip           | 172.171.0.1                          |
| host_routes          |                                      |
| id                   | e1286c15-c270-4c77-96fb-f5284bd8c216 |
| ip_version           | 4                                    |
| ipv6_address_mode    | None                                 |
| ipv6_ra_mode         | None                                 |
| name                 | mynetwork_subnet                     |
| network_id           | ac4b2563-01ad-409f-bd1a-3864a570f0ac |
| project_id           | 3611624782254240af9f5fbda4139699     |
| revision_number      | 0                                    |
| segment_id           | None                                 |
| service_types        |                                      |
| subnetpool_id        | None                                 |
| tags                 |                                      |
| tenant_id            | 3611624782254240af9f5fbda4139699     |
| updated_at           | 2022-07-26T13:34:20Z                 |
+----------------------+--------------------------------------+
stack@ubuntu:~/devstack$ 

# 创建虚拟机（这一步直接用了安装好后本来就有的一个镜像，没有自己再创建了）
stack@ubuntu:~/devstack$ openstack server create myinstance --image cirros-0.5.2-x86_64-disk --flavor myflavor --nic net-id=mynetwork
/usr/lib/python3/dist-packages/secretstorage/dhcrypto.py:15: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
/usr/lib/python3/dist-packages/secretstorage/util.py:19: CryptographyDeprecationWarning: int_from_bytes is deprecated, use int.from_bytes instead
  from cryptography.utils import int_from_bytes
+-------------------------------------+-----------------------------------------------------------------+
| Field                               | Value                                                           |
+-------------------------------------+-----------------------------------------------------------------+
| OS-DCF:diskConfig                   | MANUAL                                                          |
| OS-EXT-AZ:availability_zone         |                                                                 |
| OS-EXT-SRV-ATTR:host                | None                                                            |
| OS-EXT-SRV-ATTR:hypervisor_hostname | None                                                            |
| OS-EXT-SRV-ATTR:instance_name       |                                                                 |
| OS-EXT-STS:power_state              | NOSTATE                                                         |
| OS-EXT-STS:task_state               | scheduling                                                      |
| OS-EXT-STS:vm_state                 | building                                                        |
| OS-SRV-USG:launched_at              | None                                                            |
| OS-SRV-USG:terminated_at            | None                                                            |
| accessIPv4                          |                                                                 |
| accessIPv6                          |                                                                 |
| addresses                           |                                                                 |
| adminPass                           | 3prqS9y6Dkpj                                                    |
| config_drive                        |                                                                 |
| created                             | 2022-07-26T13:38:27Z                                            |
| flavor                              | myflavor (67a4cbf8-47b4-4ba6-a1c4-3c4dcfef43ac)                 |
| hostId                              |                                                                 |
| id                                  | 48620579-0e43-40c3-b0bf-46cb10460597                            |
| image                               | cirros-0.5.2-x86_64-disk (00d25381-1e62-418e-87bf-9bfe3e582a89) |
| key_name                            | None                                                            |
| name                                | myinstance                                                      |
| progress                            | 0                                                               |
| project_id                          | 3611624782254240af9f5fbda4139699                                |
| properties                          |                                                                 |
| security_groups                     | name='default'                                                  |
| status                              | BUILD                                                           |
| updated                             | 2022-07-26T13:38:26Z                                            |
| user_id                             | b8e74e7cadec4ce8b579b742ad5d5b3e                                |
| volumes_attached                    |                                                                 |
+-------------------------------------+-----------------------------------------------------------------+
stack@ubuntu:~/devstack$ 
```

其他参考链接：
- 374.【openstack】命令行模式创建虚拟机 https://www.jianshu.com/p/2629b49cf0cb

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Kolla

使用Kolla部署OpenStack Stein版本 https://sunqi.site/2020/10/30/%E4%BD%BF%E7%94%A8Kolla%E9%83%A8%E7%BD%B2OpenStack-Stein%E7%89%88%E6%9C%AC/

OpenStack（二）——使用Kolla部署OpenStack-allinone云平台 https://www.cnblogs.com/diantong/p/11911503.html

Kolla-Ansible 多机部署 V 版 OpenStack https://jckling.github.io/2021/08/31/OpenStack/Kolla-Ansible%20%E5%A4%9A%E6%9C%BA%E9%83%A8%E7%BD%B2/
