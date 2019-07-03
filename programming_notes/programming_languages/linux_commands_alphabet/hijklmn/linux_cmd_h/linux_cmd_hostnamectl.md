
#

深入理解Linux修改hostname https://www.cnblogs.com/kerrycode/p/3595724.html

hostname到底是怎么一回事 http://fungo.me/linux/what-the-hell-is-hostname.html

#

```
[root@myopenshift:~]$ hostnamectl --help
hostnamectl [OPTIONS...] COMMAND ...

Query or change system hostname.

  -h --help              Show this help
     --version           Show package version
     --no-ask-password   Do not prompt for password
  -H --host=[USER@]HOST  Operate on remote host
  -M --machine=CONTAINER Operate on local container
     --transient         Only set transient hostname
     --static            Only set static hostname
     --pretty            Only set pretty hostname

Commands:
  status                 Show current hostname settings
  set-hostname NAME      Set system hostname
  set-icon-name NAME     Set icon name for host
  set-chassis NAME       Set chassis type for host
  set-deployment NAME    Set deployment environment for host
  set-location NAME      Set location for host
```

```
[root@druidcluster3 ~]# hostnamectl status
   Static hostname: druidcluster3.sl.cloud9.ibm.com
         Icon name: computer-vm
           Chassis: vm
        Machine ID: bc35b820e75a4986af6f80e3e8cbc31b
           Boot ID: 8968c9d76d79482a90c8e4c6b5f9c4cf
    Virtualization: xen
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-957.10.1.el7.x86_64
      Architecture: x86-64
[root@druidcluster3 ~]#
[root@druidcluster3 ~]# hostnamectl set-hostname openshift2
[root@druidcluster3 ~]#
[root@druidcluster3 ~]# hostnamectl status
   Static hostname: openshift2
         Icon name: computer-vm
           Chassis: vm
        Machine ID: bc35b820e75a4986af6f80e3e8cbc31b
           Boot ID: 8968c9d76d79482a90c8e4c6b5f9c4cf
    Virtualization: xen
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-957.10.1.el7.x86_64
      Architecture: x86-64
```
