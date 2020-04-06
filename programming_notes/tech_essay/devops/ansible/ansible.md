
# inventory file的组名起成`[all]`的话等于没起

```sh
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
