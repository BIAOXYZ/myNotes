

## svn 一般使用

<<linux svn 使用>>
http://www.cnblogs.com/wanqieddy/archive/2011/06/09/2076783.html

<<随笔分类 - SVN与TortoiseSVN实战>>
http://www.cnblogs.com/ym123/category/636508.html

<<SVN怎样对比历史版本？>>
https://zhidao.baidu.com/question/265427496.html
>选择右键菜单中的 Show log，出现对话框，选择你想要的特定版本，然后右键-> Compare with working copy搜索
working copy就是你本地的当前版本。


## svn log

### 查看某一时间段的svn log
```
svn log -r {2017-08-21}:{2017-08-28}
```
<<SVN Log命令常用组合 >>
http://blog.csdn.net/xuanwenchao/article/details/8875103


## svn patch

### svn 及git patch文件使用

#### 使用svn command 生成和应用patch文件

1)生成patch文件

在当前目录下用命令生成patch文件。

svn diff . > xxxx.patch

选择文件生成patch文件

用svn status . 查看修改过的文件列表 

用svn diff file1 … fileN > xxxx.patch生成file1 … fileN的patch

 
2)应用patch 文件 

svn patch patchfile [path]   {补：旧版svn应用patch的命令：patch -p0 < aaa.patch}

查看说明：# svn patch –help

patch: Apply a patch to a working copy.

usage: patch PATCHFILE [WCPATH]

Apply a unidiff patch in PATCHFILE to the working copy WCPATH.

  If WCPATH is omitted, '.' is assumed.

 
3)代码已经提交过，怎么用命令生成patch文件?

如提交的revision号为 rev1

svn log . -v -r rev1  #查看修改的文件列表 

svn log . --diff -r rev1 > xxxx.patch  #查看详细diff信息  #类似git log -p



 
#### 使用tortoiseSVN GUI生成及应用patch文件


1) 创建patch方法——

一、在要同步的源工程里面 SVN——>check modifications——>找到你需要同步的文件

二、选中你要同步的文件，可同时选中多个

三、鼠标右键——>create patch

四、起一个名字，选择一个路径保存下来。


2) 应用patch方法——

一、在要同步的目的工程里面右键，apply patch

二、选中你要apply的patch文件

三、确定即可，然后你的修改就全部被同步到了目的工程里面来了。

 
PS:生成patch的文件路径和apply patch的patch文件路径应该在同一级目录，否则会出错。


#### git patch文件使用

1)生成patch文件

git diff > xxx.patch

git diff --cached > patch  #只生成stage的文件的patch（即git add之后的），不包括unstaged

 

2)应用patch文件

git apply --check patch   #查看能否patch 成功，不应用

git apply patch  应用patch

 

3)git提交后生成patch文件：

git format-patch -n  节点N  [-M branch]  #-n  表示生成提交节点最近n次提交，一般选取n=1，可生成当前提交节点的patch文件， [-M branch 表示与哪个分支比对]

git am xxx.patch  #合入patch并执行git commit


取消补丁

svn revert . –depth infinity

git reset –hard origin/master

 
 
git分支切换时先用git stash将修改入栈，之后切换回来再用git stash pop 或git stash apply 将修改恢复。

git stash先存储当前的工作改动，把本地环境恢复成未修改状态。使用git pull 更新后在使用git stash pop恢复修改。



git show [option] commit_id

常用—status(列出修改文件，不显示详细修改内容)  –online

查看某次提交的改动

 

git log [option] commit_id

查看自某次提交及其以前的log

 

git diff comit_id_start commit_id_end

查看某个区间的提交diff 


## svn 统计代码行数
### windows下

使用方法：

1. 正常 checkout 需要统计的svn的代码，此路径为记作：svn_code_local_path

2. 解压缩附件的 statsvn-0.7.0.zip 得到statsvn.jar

3. 收集提交记录

 svn log -r {2014-9-15}:{2014-10-8} --xml -v svn_code_local_path > svn.log

4. 统计代码修改量：

java -jar statsvn.jar svn.log svn_code_local_path

5. 当前目录下产生一堆文件，直接打开index.html 即可查看。

打开developers.html 可以查看按提交作者统计。或者index.html查看综合统计结果。
```
注意：所谓的"当前目录"是指在dos命令行里执行命令的目录。需要安装 svn.exe 且其路径要在PATH环境变量中配置。
优点：
StatSVN会把当前SVN库的状态用图片和图表的方式展现出来，可以按不同分类分别展开，功能强大。
缺点：
StatSVN统计的是所有代码行，包括注释和空行，但一般度量要求是有效代码行，在分析时需要注意这一点。
StatSVN不考虑修改的代码行数，只考虑与上一版本相比新增(+)与删除(-)的代码行数。
```
```
svn log -r {2017-7-15}:{2017-10-26} --xml -v D:\mySyncFiles\20170831_ap_onlineexpansion > D:\LLchromedownload\statsvnlogs\20171026\svn.log

java -jar D:\LLchromedownload\statsvn-0.7.0\statsvn.jar D:\LLchromedownload\statsvnlogs\20171026\svn.log D:\mySyncFiles\20170831_ap_onlineexpansion
```

