

# [第1章 部署虚拟环境安装linux系统。](https://www.linuxprobe.com/chapter-01.html)

- 1.4 重置root用户密码
- 1.5 RPM红帽软件包
```
表1-1 常用的RPM软件包命令

安装软件的命令格式 	        rpm -ivh filename.rpm
升级软件的命令格式 	        rpm -Uvh filename.rpm
卸载软件的命令格式 	        rpm -e filename.rpm
查询软件描述信息的命令格式 	rpm -qpi filename.rpm
列出软件文件信息的命令格式 	rpm -qpl filename.rpm
查询文件属于哪个RPM的命令格式 	rpm -qf filename
```
- 1.6 Yum软件仓库
```
表1-2  常见的Yum命令
命令 	                      作用
yum repolist all 	          列出所有仓库
yum list all 	              列出仓库中所有软件包
yum info 软件包名称 	        查看软件包信息
yum install 软件包名称 	    安装软件包
yum reinstall 软件包名称     重新安装软件包
yum update 软件包名称 	      升级软件包
yum remove 软件包名称 	      移除软件包
yum clean all 	            清除所有仓库缓存
yum check-update 	          检查可更新的软件包
yum grouplist 	            查看系统中已经安装的软件包组
yum groupinstall 软件包组    安装指定的软件包组
yum groupremove 软件包组 	   移除指定的软件包组
yum groupinfo 软件包组 	     查询指定的软件包组信息
```
- 1.7 Systemd初始化进程
  - > 无论怎样，RHEL 7系统选择systemd初始化进程服务已经是一个既定事实，因此也没有了“运行级别”这个概念，Linux系统在启动时要进行大量的初始化工作，比如挂载文件系统和交换分区、启动各类进程服务等，这些都可以看作是一个一个的单元（Unit），systemd用目标（target）代替了System V init中运行级别的概念，这两者的区别如表1-3所示。
  - > 如果有读者之前学习过RHEL 6系统，或者已经习惯使用service、chkconfig等命令来管理系统服务，那么现在就比较郁闷了，因为在RHEL 7系统中是使用systemctl命令来管理服务的。表1-4和表1-5所示RHEL 6系统中System V init命令与RHEL 7系统中systemctl命令的对比，您可以先大致了解一下，后续章节中会经常用到它们。

# [第12章 使用Samba或NFS实现文件共享。](https://www.linuxprobe.com/chapter-12.html) 
