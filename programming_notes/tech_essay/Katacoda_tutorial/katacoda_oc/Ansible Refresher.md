
# 链接

Ansible Review or Ansible Refresher https://www.katacoda.com/openshift/courses/ansibleop/ansible-refresher

# 重点过程

本部分只记录了playbook引用role的一种方式，和如何在里面使用动态参数。这个教程本身有问题（远端的ssh连接不上，所有教程里在host01做的都不成功；有些内容缺失，要自己摸索，比如playbook如何引用role），再加上整个教程感觉也就这部分还值得记下，所以没有一丝不差地记录全部内容。

```
// 初始目录情况。go那个目录至少在这个教程里没有什么操作涉及到，所以不用管。

$ pwd
/root/tutorial
$ ll
total 8
drwxr-xr-x. 5 root root 4096 May 29 00:01 go
-rw-r--r--. 1 root root  145 Jun  8 16:24 playbook.yml
```

```
// 初始化一个ansible role后目录情况。ps：时间不要在意，是运行了两次拼的，并不重要。

$ ansible-galaxy init example-role --offline
- example-role was created successfully
$ ll
total 12
drwxr-xr-x. 10 root root 4096 Jun  8 16:01 example-role
drwxr-xr-x.  5 root root 4096 May 29 00:01 go
-rw-r--r--.  1 root root   95 Jun  8 16:15 playbook.yml
```

```
// 观察一下这个example-role目录的文件结构。

$ tree example-role/
example-role/
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

8 directories, 8 files
```

```
// 编辑好相关的内容。

$ cat example-role/defaults/main.yml
---
names:
  - John Smith
  - Tom Jones
  - Lisa Kelly
$
$ cat example-role/tasks/main.yml
-
  name: Create a new file on localhost
  command: touch names
-
  name: Add names into names file
  shell: echo {{names}} > names
$
$ cat playbook.yml
-
  name: Execute a command on localhost
  hosts: localhost
  roles:
    - role: "example-role"
```

```
// 执行完成后发现创建了names文件，并且里面的内容是echo进去的default目录下names变量（这俩重名只是巧合）定义的内容。

$ ansible-playbook playbook.yml
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the
implicit localhost does not match 'all'


PLAY [Execute a command on localhost] *****************************************************

TASK [Gathering Facts] ********************************************************************
ok: [localhost]

TASK [example-role : Create a new file on localhost] **************************************
 [WARNING]: Consider using the file module with state=touch rather than running touch.  If
you need to use command because file is insufficient you can add warn=False to this
command task or set command_warnings=False in ansible.cfg to get rid of this message.

changed: [localhost]

TASK [example-role : Add names into names file] *******************************************
changed: [localhost]

PLAY RECAP ********************************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0

$
$ ll
total 16
drwxr-xr-x. 10 root root 4096 Jun  8 16:01 example-role
drwxr-xr-x.  5 root root 4096 May 29 00:01 go
-rw-r--r--.  1 root root   39 Jun  8 16:17 names
-rw-r--r--.  1 root root   95 Jun  8 16:15 playbook.yml
$ cat names
[uJohn Smith, uTom Jones, uLisa Kelly]
```
