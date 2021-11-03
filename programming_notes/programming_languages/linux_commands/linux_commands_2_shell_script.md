
# 综合类的

From finding text to search and replace, from sorting to beautifying text and more https://github.com/learnbyexample/Command-line-text-processing

BashGuide http://mywiki.wooledge.org/BashGuide
- > The bash academy website https://github.com/lhunath/bash.academy
  * The Bash Academy https://www.bash.academy/
- > The guide is also available in [PDF format](http://folk.ntnu.no/geirha/bashguide.pdf). Alternatively, you can just hit print after going to [FullBashGuide](http://mywiki.wooledge.org/FullBashGuide). That guarantees you'll be printing the latest version of this document.
  * PDF format http://folk.ntnu.no/geirha/bashguide.pdf
  * FullBashGuide http://mywiki.wooledge.org/FullBashGuide

Shell 教程 https://www.runoob.com/linux/linux-shell.html
- Shell 变量 https://www.runoob.com/linux/linux-shell-variable.html
```
----------------------------------------------------------------------------------------------------
注意，变量名和等号之间不能有空格
----------------------------------------------------------------------------------------------------
使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。
----------------------------------------------------------------------------------------------------
使用 unset 命令可以删除变量。语法：
  unset variable_name
变量被删除后不能再次使用。unset 命令不能删除只读变量。
----------------------------------------------------------------------------------------------------
单引号字符串的限制：
  单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
  单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

双引号的优点：
  双引号里可以有变量
  双引号里可以出现转义字符
----------------------------------------------------------------------------------------------------
获取字符串长度
  string="abcd"
  echo ${#string} #输出 4
----------------------------------------------------------------------------------------------------
提取子字符串
以下实例从字符串第 2 个字符开始截取 4 个字符：
  string="runoob is a great site"
  echo ${string:1:4} # 输出 unoo
----------------------------------------------------------------------------------------------------
定义数组
在 Shell 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：
  数组名=(值1 值2 ... 值n)
----------------------------------------------------------------------------------------------------
读取数组
读取数组元素值的一般格式是：
  ${数组名[下标]}
例如：
  valuen=${array_name[n]}
----------------------------------------------------------------------------------------------------
获取数组的长度
获取数组长度的方法与获取字符串长度的方法相同，例如：
  # 取得数组元素的个数
  length=${#array_name[@]}
  # 或者
  length=${#array_name[*]}
  # 取得数组单个元素的长度
  lengthn=${#array_name[n]}
----------------------------------------------------------------------------------------------------
```
- Shell 基本运算符 https://www.runoob.com/linux/linux-shell-basic-operators.html

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

The Linux Command Line http://linuxcommand.org/
- The Linux Command Line 中文版 https://www.kancloud.cn/thinkphp/linux-command-line/39431
- 快乐的 Linux 命令行 http://billie66.github.io/TLCL/index.html
  * > 本书是 The Linux Command Line 的中文版

Bash 教程 https://wangdoc.com/bash/ || https://github.com/wangdoc/bash-tutorial

https://segmentfault.com/u/vvpale/articles
- SHELL(bash)脚本编程一：变量 https://segmentfault.com/a/1190000008053195
- SHELL(bash)脚本编程八：技巧 https://segmentfault.com/a/1190000008507953

一篇文章Shell脚本快速入门 https://www.cnblogs.com/f-ck-need-u/p/12275851.html 【by 骏马金龙】

# shell脚本调试

Shell脚本调试技术 https://www.ibm.com/developerworks/cn/linux/l-cn-shell-debug/index.html
- > 利用$PS4这一特性，通过使用一些内置变量来重定义$PS4的值，我们就可以增强"-x"选项的输出信息。例如先执行```export PS4='+{$LINENO:${FUNCNAME[0]}} '```, 然后再使用“-x”选项来执行脚本，就能在每一条实际执行的命令前面显示其行号以及所属的函数名。

Bash shell脚本打印出正在执行的命令 https://blog.csdn.net/CaspianSea/article/details/45767453

# 简单型的

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

linux shell 逻辑运算符、逻辑表达式详解 https://www.cnblogs.com/chengmo/archive/2010/10/01/1839942.html
```
----------------------------------------------------------------------------------------------------
-f	常用侦测『档案』是否存在 eg: if [ -f filename ]
-d	常用侦测『目录』是否存在
-e	侦测『某个东西』是否存在！
----------------------------------------------------------------------------------------------------
-eq	等于 应用于：整型比较
-ne	不等于 应用于：整型比较
-lt	小于 应用于：整型比较
-gt	大于 应用于：整型比较
-le	小于或等于 应用于：整型比较
-ge	大于或等于 应用于：整型比较
-a	双方都成立（and） 逻辑表达式 –a 逻辑表达式
-o	单方成立（or） 逻辑表达式 –o 逻辑表达式
-z	空字符串
-n	非空字符串
----------------------------------------------------------------------------------------------------
```

linux shell 字符串操作（长度，查找，替换）详解 https://www.cnblogs.com/chengmo/archive/2010/10/02/1841355.html
```shell
${string/substring/replacement}	使用$replacement, 来代替第一个匹配的$substring

例子：
localhost:myNotes liangliu$ REPO=`git config remote.origin.url`
localhost:myNotes liangliu$ SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
localhost:myNotes liangliu$ echo $REPO
https://github.com/BIAOXYZ/myNotes.git
localhost:myNotes liangliu$ echo $SSH_REPO
git@github.com:BIAOXYZ/myNotes.git
```



### Linux符号``的使用
Linux—shell中$(( ))、$( )、``与${ }的区别
https://blog.csdn.net/number_0_0/article/details/73291182

linux shell中'',""和``的区别
https://www.cnblogs.com/Skyar/p/5914942.html

### Shell脚本中的中括号

What is the difference between double and single square brackets in bash? https://serverfault.com/questions/52034/what-is-the-difference-between-double-and-single-square-brackets-in-bash
- Greg's Wiki http://mywiki.wooledge.org/
  * BashGuide http://mywiki.wooledge.org/BashGuide
  * The Bash Guide https://guide.bash.academy/
  
### linux命令之间的`&&`和`||`以及分号

**//首先要说明一点，这里的`&&`和`||`不是指shell脚本中if条件语句里的`&&`和`||`。尽管他们很像，但是前者主要是决定了linux命令执行的效果（shell脚本的基本构成单元就是linux命令，所以他们当然也属于是shell脚本的内容），除了它俩还有一个是`分号`，以及稍有点关系的`&`（表示放到后台执行）；后者那两个就是在shell的if条件里做逻辑连接的，比如`if [[ $a -lt 100 && $b -gt 100 ]]`**。

linux命令之间的`分号，&&，||` https://blog.csdn.net/stpeace/article/details/51870812 【by stpeace】
```console
在用linux命令时候， 我们经常需要同时执行多条命令， 那么命令之间该如何分割呢？
   分号： 顺序地独立执行各条命令，彼此之间不关心是否失败，所有命令都会执行。
   && ： 顺序执行各条命令，只有当前一个执行成功时候，才执行后面的。
   || ： 顺序执行各条命令，只有当前面一个执行失败的时候，才执行后面的。
```
> 意思我都懂，就是偶然发现了这哥们的博客是CSDN排行第一，所以记一下。。。

Confusing use of && and || operators https://unix.stackexchange.com/questions/24684/confusing-use-of-and-operators
- https://unix.stackexchange.com/questions/24684/confusing-use-of-and-operators/24685#24685
  * > The right side of `&&` will only be evaluated if the exit status of the left side is zero (i.e. true). `||` is the opposite: it will evaluate the right side only if the left side exit status is non-zero (i.e. false).
  * > You can consider `[ ... ]` to be a program with a return value. If the test inside evaluates to true, it returns zero; it returns nonzero otherwise.
    ```sh
    $ false && echo howdy!

    $ true && echo howdy!
    howdy!
    $ true || echo howdy!

    $ false || echo howdy!
    howdy!
    ```
  * > If you do `which [`, you might see that `[` actually does point to a program! It's usually not actually the one that runs in scripts, though; run `type [` to see what actually gets run. If you wan to try using the program, just give the full path like so: `/bin/[ 1 = 1`.

Difference between executing multiple commands with && and ; [duplicate] https://unix.stackexchange.com/questions/100704/difference-between-executing-multiple-commands-with-and
- https://unix.stackexchange.com/questions/100704/difference-between-executing-multiple-commands-with-and/100705#100705
  * > In the shell, `&&` and `;` are similar in that they both can be used to terminate commands. The difference is `&&` is also a conditional operator. ***With `;` the following command is always executed, but with `&&` the later command is only executed if the first succeeds***.
    ```sh
    false; echo "yes"   # prints "yes"
    true; echo "yes"    # prints "yes"
    false && echo "yes" # does not echo
    true && echo "yes"  # prints "yes"
    ```

Is there a difference between the '&&' and ';' symbols in a standard BASH terminal? https://askubuntu.com/questions/23549/is-there-a-difference-between-the-and-symbols-in-a-standard-bash-termin
- https://askubuntu.com/questions/23549/is-there-a-difference-between-the-and-symbols-in-a-standard-bash-termin/23551#23551
  * > With this line:
    ```sh
    command1 && command2
    ```
    > command2 will be executed if (and only if) command1 returns exit status zero, whereas in this line:
    ```sh
    command1 ; command2
    ```
    > both command1 and command2 will be executed regardless. The semicolon allows you to type many commands on one line.

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# shell经典用法

## /dev/null 2>&1

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

## Here Documents

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


# 小脚本

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
