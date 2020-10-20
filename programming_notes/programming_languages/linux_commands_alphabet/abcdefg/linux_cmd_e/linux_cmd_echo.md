

- 解决shell脚本中 echo 怎么写入换行到文件 https://blog.csdn.net/dcx1205/article/details/46855235
>> 问题起因：`echo {somecontent} >> {file}`形式向file写入内容时如何写空行进去？
```
测试环境：ubuntu12.04 LTS版本

echo >> file.txt即可，



这种方法对于脚本开头是bash和sh效果都一样，

而echo -e >> file.txt这种只适合与bash

对于sh，会输入-e到文件然后再换行。



而echo -e "\n" >> file.txt对于bash会连续换2行，

对于sh，会输入-e和一个新空行到文件。
```

```shell
// 个人实战（没管sh，就测了测bash就行了）：

root@cloudsec2:~$ echo step1 >> test.log
root@cloudsec2:~$ cat test.log
step1
root@cloudsec2:~$ echo >> test.log
root@cloudsec2:~$ cat test.log
step1

root@cloudsec2:~$ echo step2 >> test.log
root@cloudsec2:~$ cat test.log
step1

step2
root@cloudsec2:~$ echo -e >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

root@cloudsec2:~$ echo step3 >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3
root@cloudsec2:~$ echo -e "\n" >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3


root@cloudsec2:~$ echo end >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3


end
```

# 相关技巧

【 from： 跳板机的工作原理和简单的跳板机实现 https://www.cnblogs.com/feng0919/p/11215884.html 】
```sh
[root@jiangfeng1 ~]# echo 123456 | passwd --stdin code1
更改用户 code1 的密码 。
passwd： 所有的身份验证令牌已经成功更新。
```
>> note：可以用上面这个echo语句，实现不用交互式地更改用户密码。
>>> note2：后来发现ubuntu下不行，因为ubuntu下的passwd命令竟然没有`--stdin`参数。。。详情参见`passwd`命令专门的笔记文件吧。

## RHACM脚本安装时需要手动输入一个snapshot

`echo "2.0.0-SNAPSHOT-2020-07-22-20-24-07\n" | ./start.sh --watch` <br> // PS: 这里`echo`也可以换成`printf`，如下所示：
```sh
{root@bandore1 deploy2.1}$ printf "2.1.0-SNAPSHOT-2020-10-10-03-29-09" | ./start.sh --watch
* Testing connection
* Using baseDomain: oprinstall.cp.fyre.ibm.com
* oc CLI Client Version: openshift-clients-4.3.0-201910250623-88-g6a937dfe
Find snapshot tags @ https://quay.io/repository/open-cluster-management/acm-custom-registry?tab=tags
Enter SNAPSHOT TAG: (Press ENTER for default: 2.1.0-SNAPSHOT-2020-10-10-03-29-09)
* Downstream:    Release Version: 2.1.0
* Composite Bundle: true   Image Registry (CUSTOM_REGISTRY_REPO): quay.io/open-cluster-management
* Using: 2.1.0-SNAPSHOT-2020-10-10-03-29-09

* Applying SNAPSHOT to multiclusterhub-operator subscription
* Applying CUSTOM_REGISTRY_REPO to multiclusterhub-operator subscription
* Applying SUBSCRIPTION_CHANNEL to multiclusterhub-operator subscription
* Applying multicluster-hub-cr values

##### Creating the open-cluster-management namespace
namespace/open-cluster-management created
...
...
...
```
