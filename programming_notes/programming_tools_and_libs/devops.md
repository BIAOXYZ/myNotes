
# others

AIOps学习资料汇总，欢迎一起补全这个仓库，欢迎star https://github.com/linjinjin123/awesome-AIOps/

Modernize your application deployment with Lift and Shift https://developers.redhat.com/blog/2018/10/18/modernize-your-application-deployment-with-lift-and-shift/

# BMC & IPMI

BMC简介 https://blog.csdn.net/jiangwei0512/article/details/76358995

baseboard management controller：底板管理控制器 https://searchnetworking.techtarget.com.cn/whatis/12-24883/

BMC是什麼? 能吃嗎? https://medium.com/@lioukiki1/bmc%E6%98%AF%E4%BB%80%E9%BA%BC-%E8%83%BD%E5%90%83%E5%97%8E-bee457ea5c37

使用 ipmitool 实现 Linux 系统下对服务器的 ipmi 管理 https://www.ibm.com/developerworks/cn/linux/l-ipmi/index.html

## BMC & IPMI wiki

Intelligent Platform Management Interface https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface 【[IPMI](https://zh.wikipedia.org/wiki/IPMI)】
- Out-of-band management https://en.wikipedia.org/wiki/Out-of-band_management 【[带外管理](https://zh.wikipedia.org/wiki/%E5%B8%A6%E5%A4%96%E7%AE%A1%E7%90%86)】

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# xCAT官网

xCAT https://en.wikipedia.org/wiki/XCAT

Welcome to xCAT. xCAT is an open-source tool for automating deployment, scaling, and management of bare metal severs and virtual machines. https://xcat.org/

# xCAT文档

Extreme Cloud Administration Toolkit https://xcat-docs.readthedocs.io/en/stable/
- xdsh https://xcat-docs.readthedocs.io/en/stable/guides/admin-guides/references/man1/xdsh.1.html
- rinstall https://xcat-docs.readthedocs.io/en/stable/guides/admin-guides/references/man8/rinstall.8.html
- rcons - Remote Console https://xcat-docs.readthedocs.io/en/stable/guides/admin-guides/manage_clusters/ppc64le/management/basic/rcons.html
- lsdef https://xcat-docs.readthedocs.io/en/stable/guides/admin-guides/references/man1/lsdef.1.html
- MTMS-based Discovery https://xcat-docs.readthedocs.io/en/stable/guides/admin-guides/manage_clusters/ppc64le/discovery/mtms/

# xCAT其他

集群管理和配置工具 xCAT https://www.oschina.net/p/xcat

7 Best Free Linux Server Provisioning Tools https://www.linuxlinks.com/serverprovisioning/

|Server Provisioning||
|--|--|
| Spacewalk |	Systems management software developed by Red Hat |
| xCAT |	Extreme Cluster Administration Toolkit |
| FAI |	High quality tool for fully automatic installation of Linux systems |
| [Cobbler](https://www.linuxlinks.com/Cobbler/) |	OS provisioning and profile management |
| m23	| Software distribution and management system |
| OpenQRM	| Systems management platform |
| Foreman	| Life cycle systems management tool |

## 

Kickstart (Linux) https://en.wikipedia.org/wiki/Kickstart_(Linux)
> Cobbler (software) https://en.wikipedia.org/wiki/Cobbler_(software)

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Ansible Tower官网

Red Hat Ansible Tower https://www.ansible.com/products/tower

# Ansible Tower文档

- Ansible Tower https://docs.ansible.com/ansible/latest/reference_appendices/tower.html
- Ansible Tower https://ansible-tran.readthedocs.io/en/latest/docs/tower.html

# Ansible Tower其他

Ansible vs Ansible Tower https://www.upguard.com/articles/ansible-vs.-ansible-tower

Getting Started With Ansible Tower https://dzone.com/articles/getting-started-with-ansible-tower-hands-on

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Ansible官网

Ansible Documentation https://docs.ansible.com/ansible/latest/index.html

# Ansible general

Ansible (software) https://en.wikipedia.org/wiki/Ansible_(software)

SaltStack 与 Ansible 选择？ - 知乎 https://www.zhihu.com/question/22707761

Ansible专题整理 http://www.cnblogs.com/aslongas/p/7306548.html 【:star:】

Ansible中文权威指南 https://ansible-tran.readthedocs.io/en/latest/index.html

# Ansible快速开始

Ansible入门 https://getansible.com/
- The ansible examples in this repo are for the book ansible入门(ansible-first-book) https://github.com/ansible-book/playbook-examples-chapter3-ansible-advanced

Learn X in Y minutes -- Where X=ansible https://learnxinyminutes.com/docs/ansible/

# Ansible命令实战

## inventory file的组名起成`[all]`的话等于没起
```
----------------------------------------------------------------------------------------------------
// 修改前的inventory file，注意第一个组名是[all]。
[root@druidcluster1 generalsoftware]# cat ansiblehost 
[all]
9.116.2.59  ansible_user=root
9.116.2.70  ansible_user=root
9.116.2.254  ansible_user=root

[local]
druidcluster1  ansible_user=root

// 试图只在[all]组执行ping命令，但是不行，系统还是把all作为所有主机的保留关键词。
[root@druidcluster1 generalsoftware]# ansible all -i ansiblehost -m ping
9.116.2.59 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
druidcluster1 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
9.116.2.70 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
9.116.2.254 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
----------------------------------------------------------------------------------------------------
// 修改后的inventory file，第一个组名改为了[full]。
[root@druidcluster1 generalsoftware]# cat ansiblehost 
[full]
9.116.2.59  ansible_user=root
9.116.2.70  ansible_user=root
9.116.2.254  ansible_user=root

[local]
druidcluster1  ansible_user=root

// 此时可以只在[full]组执行ping命令。
[root@druidcluster1 generalsoftware]# ansible full -i ansiblehost -m ping
9.116.2.59 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
9.116.2.70 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
9.116.2.254 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
----------------------------------------------------------------------------------------------------
```

# [Ansible modules] (https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)

## kubernetes related ansible modules

使用 Ansible 管理 Kubernetes 资源 http://xcodest.me/use-ansible-manage-kubernetes-resources.html

k8s_scale – Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job https://docs.ansible.com/ansible/latest/modules/k8s_scale_module.html

k8s – Manage Kubernetes (K8s) objects https://docs.ansible.com/ansible/latest/modules/k8s_module.html

helm – Manages Kubernetes packages with the Helm package manager https://docs.ansible.com/ansible/latest/modules/helm_module.html

## other modules

### authorized_key

authorized_key – Adds or removes an SSH authorized key https://docs.ansible.com/ansible/latest/modules/authorized_key_module.html

Ansible Playbook: Deploy the public key to remote hosts https://medium.com/@visualskyrim/ansible-playbook-deploy-the-public-key-to-remote-hosts-da3f3b4b5481

# Ansible Playbooks and Roles

`Roles` -- `Role Search Path` https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-search-path
```
Ansible will search for roles in the following way:

- A roles/ directory, relative to the playbook file.
- By default, in /etc/ansible/roles
```

Using Variables https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html

# Ansible Galaxy

Ansible Galaxy https://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html

# Ansible其他

Ansible 进阶技巧 https://www.ibm.com/developerworks/cn/linux/1608_lih_ansible/index.html
