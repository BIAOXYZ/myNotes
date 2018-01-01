
### 综合类的

<<Linux Shell常用技巧(目录)>>
http://www.cnblogs.com/stephen-liu74/archive/2011/12/20/2285454.html

<<shell基础十二篇>>
http://www.cnblogs.com/woxing/articles/3427131.html

Linux Shell脚本攻略
http://man.linuxde.net/shell-script


### 简单型的

shell 脚本关键字&符号
http://www.cnblogs.com/xiaojiang1025/p/5863984.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 知乎shell相关

<<shell程序中 2> /dev/null 代表什么意思？>>
https://www.zhihu.com/question/53295083

- [Linux] 文件描述符 
https://www.jianshu.com/p/b1c10674a789
- 每天进步一点点——Linux中的文件描述符与打开文件之间的关系
http://blog.csdn.net/cywosp/article/details/38965239

<<学习 shell 有什么好书推荐？>>
https://www.zhihu.com/question/19745611
```
答案包括:

[Classic Shell Scripting][Shell脚本学习指南]
[Linux Shell Scripting Cookbook][Linux Shell脚本攻略]
[Linux Command Line and Shell Scripting Bible][Linux命令行与shell脚本编程大全(第一版把大全翻译成宝典)]
```

- http://www.tldp.org/LDP/abs/html/
- http://www.tldp.org/LDP/Bash-Beginners-Guide/html/
- Linux Shell脚本攻略 读书笔记
http://www.cnblogs.com/me115/p/3428147.html
- Linux Shell 脚本菜谱 | Linux Shell Scripting Cookbook
http://tangzx.qiniudn.com/post-0024-linux-shell-scripting-cookbook.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 小脚本

### Linux杀进程小脚本

<< linux使用脚本杀死指定名称的进程 [问题点数：40分，结帖人mervyn807] >>
http://bbs.csdn.net/topics/360151075

```
#!/bin/sh
ps -ef|grep -v grep|grep postgres|while read u p o
do
kill -9 $p
done 
```

**自己改进了一个**
```
#!/bin/sh

while true;
        do
                ps -ef|grep postgres|grep -v grep|awk '{print$2}' | xargs kill -9
                if [ $? -eq 0 ] 
                then
                        exit
                fi  
        done
```

### 删除除了某个特定文件外的文件

http://jingyan.baidu.com/article/e75aca851ff15c142fdac64c.html


在test文件夹下有1.tt、1.png、index.html，现在要删除除1.tt之外的所有文件，则可以编写如下脚本：

for i in `ls`;do if [ "$i" != 1.tt ];then rm -rf $i;fi;done;

或者用find命令(两个都可以，第二个好像更好点)

find . -not -name "1.tt" -exec rm -rf {} \;

find . -not -name "1.tt" | xargs rm -rf

PS: 查找多个时可以考虑-o选项或正则表达式，而且-name选项似乎也可以多次使用

http://dingding830106.blog.163.com/blog/static/35119170201482383419925/

http://blog.csdn.net/pcyph/article/details/41683383

### 删除某个目录里所有文件，但是保留目录
发现其实可以进入到需要清空内容的目录，然后执行
```
ls | xargs rm -rf
```
然后发现想在目录外执行不行，原因发现了：比如在test目录上一层执行下述命令，没有反应。应该是因为此时xargs rm -rf也默认在test的上级目录执行了，但是上级目录明显没有要删的文件。
```
ls test | xargs rm -rf
```
