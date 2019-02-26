
### 综合类的

From finding text to search and replace, from sorting to beautifying text and more https://github.com/learnbyexample/Command-line-text-processing

<<Linux Shell常用技巧(目录)>>
http://www.cnblogs.com/stephen-liu74/archive/2011/12/20/2285454.html

<<shell基础十二篇>> -- 其实是20篇
http://www.cnblogs.com/woxing/articles/3427131.html

Linux Shell脚本攻略
http://man.linuxde.net/shell-script

Shell编程基础
https://wiki.ubuntu.com.cn/Shell%E7%BC%96%E7%A8%8B%E5%9F%BA%E7%A1%80

Shell脚本调试技术
https://www.ibm.com/developerworks/cn/linux/l-cn-shell-debug/index.html

《Linux命令行与shell脚本编程大全案例》 https://github.com/fengyuhetao/shell


### 简单型的

shell 脚本关键字&符号
http://www.cnblogs.com/xiaojiang1025/p/5863984.html

<<shell中$(( ))与$( )还有${ }的区别>>
http://blog.csdn.net/tg5156/article/details/19406275
```
$( )与` `(反引号)
在bash shell中，$( )与` `(反引号)都是用来做命令替换(command substitution)用的。

${ }用来作变量替换

${file:+my.file.txt} 若 $file 为非空值，则使用 my.file.txt 作传回值。(未设定及空值时不作处理)

${#var} 可计算出变量值的长度
```

Shell中#*/和%/*是什么意思？
http://blog.csdn.net/hongchangfirst/article/details/28436947

linux bash shell之变量替换：:=句法、=句法、:-句法、-句法、=?句法、?句法、:+句法、+句法
https://www.cnblogs.com/fhefh/archive/2011/04/22/2024750.html

#### Linux符号``的使用
Linux—shell中$(( ))、$( )、``与${ }的区别
https://blog.csdn.net/number_0_0/article/details/73291182

linux shell中'',""和``的区别
https://www.cnblogs.com/Skyar/p/5914942.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## shell经典用法

<<shell程序中 2> /dev/null 代表什么意思？>> https://www.zhihu.com/question/53295083
- /dev/null 2>&1 解释 http://blog.163.com/liang8421@126/blog/static/89481957200926105219622/
- [Linux] 文件描述符 https://www.jianshu.com/p/b1c10674a789
- 每天进步一点点——Linux中的文件描述符与打开文件之间的关系 http://blog.csdn.net/cywosp/article/details/38965239

--------------------------------------------------

<<shell中2>&1之类的命令中'&'是什么意思?>> https://segmentfault.com/q/1010000002454596
```
放在>后面的&，表示重定向的目标不是一个文件，而是一个文件描述符，内置的文件描述符如下

1 => stdout
2 => stderr
0 => stdin

换言之 2>1 代表将stderr重定向到当前路径下文件名为1的regular file中，
而2>&1代表将stderr重定向到文件描述符为1的文件(即/dev/stdout)中，这个文件就是stdout在file system中的映射
而&>file是一种特殊的用法，也可以写成>&file，二者的意思完全相同，都等价于

>file 2>&1

此处&>或者>&视作整体，分开没有单独的含义
```
https://www.gnu.org/software/bash/manual/

--------------------------------------------------

### Here Documents

How does “cat << EOF” work in bash? https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash
```
1. Assign multi-line string to a shell variable

[root@cloudsec2 ~]# sql=$(cat <<EOF
> SELECT foo, bar FROM db
> WHERE foo='baz'
> EOF
> )
[root@cloudsec2 ~]# echo $sql
SELECT foo, bar FROM db WHERE foo='baz'


2. Pass multi-line string to a file in Bash

[root@cloudsec2 ~]# cat <<EOF > print.sh
> #!/bin/bash
> echo \$PWD
> echo $PWD
> EOF
[root@cloudsec2 ~]# cat print.sh
#!/bin/bash
echo $PWD
echo /root


3. Pass multi-line string to a pipe in Bash

[root@cloudsec2 ~]# cat <<EOF | grep 'b' | tee b.txt
> foo
> bar
> baz
> EOF
bar
baz
[root@cloudsec2 ~]# cat b.txt
bar
baz

The b.txt file contains bar and baz lines. The same output is printed to stdout.
```

linux shell脚本EOF妙用 https://blog.csdn.net/zongshi1992/article/details/71693045

--------------------------------------------------

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
发现了一个很傻逼的事情，根本不像我想的那样，有无比方便且简单的方法：要清空的目录再加个斜杠和星号（星号代表所有内容）就OK。并且不受必须在当前目录的限制。
```
rm -rf xxx/yyy/test/*
```
