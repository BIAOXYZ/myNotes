

## svn log

### 查看某一时间段的svn log
```
svn log -r {2017-08-21}:{2017-08-28}
```
<<SVN Log命令常用组合 >>
http://blog.csdn.net/xuanwenchao/article/details/8875103


## svn的patch(顺便包含了git的)
### svn 及git patch文件使用

使用svn command 生成和应用patch文件

1)       生成patch文件

在当前目录下用命令生成patch文件。

svn diff . > xxxx.patch

选择文件生成patch文件

用svn status . 查看修改过的文件列表 

用svn diff file1 … fileN > xxxx.patch生成file1 … fileN的patch

 

2)       应用patch 文件 

svn patch patchfile [path]

查看说明：# svn patch –help

patch: Apply a patch to a working copy.

usage: patch PATCHFILE [WCPATH]

Apply a unidiff patch in PATCHFILE to the working copy WCPATH.

  If WCPATH is omitted, '.' is assumed.

 

3)       代码已经提交过，怎么用命令生成patch文件?

如提交的revision号为 rev1

svn log . -v -r rev1  #查看修改的文件列表 

svn log . --diff -r rev1 > xxxx.patch  #查看详细diff信息  #类似git log -p



 
使用tortoiseSVN GUI生成及应用patch文件


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



 
git patch文件使用

1)       生成patch文件

git diff > xxx.patch

git diff --cached > patch  #只生成stage的文件的patch（即git add之后的），不包括unstaged

 

2)      应用patch文件

git apply --check patch   #查看能否patch 成功，不应用

git apply patch  应用patch

 

3)    git提交后生成patch文件：

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

