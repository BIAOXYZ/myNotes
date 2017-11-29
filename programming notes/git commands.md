
### 背景

|标号|含义|英文|
|:---|---:|:---:|
|<1>|工作目录 / 工作区  | Working Directory / workspace | 
|<2>|暂存区域 / 索引    | Staging Area / index |
|<3>|git仓库 / 本地仓库 | .git Directory / local repository |
|<4>|远端(仓库)|remote(repository)|

这两种叫法的出处分别如下:

<<Pro Git 第二版 简体中文: Git 基础>>之"三种状态"部分
https://bingohuang.gitbooks.io/progit2/content/01-introduction/sections/basics.html

<<git: 提交前查看修改 git diff，HEAD^, HEAD~i>>
http://blog.csdn.net/gw569453350game/article/details/46998395


### 配置git (git config)
```
设置用户名
git config --global user.name "Scott Chacon"
设置邮箱
git config --global user.email "schacon@gmail.com"
```

```
克隆仓库 (从远程拉取)
git clone address
或初始化仓库 (把本地的用git开始追踪)
git init
```

配置密钥等：

<<git/github初级运用自如>>
https://www.cnblogs.com/fnng/archive/2012/01/07/2315685.html


### 比较版本差异 (git diff)

[<<git: 提交前查看修改 git diff，HEAD^, HEAD~i>>](http://blog.csdn.net/gw569453350game/article/details/46998395)
```
git diff //比较工作区和暂存区，也就是<1>和<2>
git diff --cached //比较暂存区和本地仓库，也就是<2>和<3>
git diff HEAD //比较工作区和本地仓库，也就是<1>和<3>

git diff HEAD^ HEAD
```

<<如何在git中对比当前工作区和远程仓库的区别？>>
https://www.zhihu.com/question/53601264
```
git diff <local branch> <remote>/<remote branch>
```

### 更改提交
```
git commit --amend
如果想更改一次提交，使用git commit --amend, git会使用与当前提交相同的父节点进行一次新提交，旧的提交会被取消。
```

<<Git 的 commit message 写错了，有办法进行修改么？>>
https://segmentfault.com/q/1010000000761908



### 撤销工作区和暂存区的修改
```
git checkout -- file //是把当前最新的编辑去掉，使file变为一个次新的版本。也就是说，当前file如果<1><2>都有，则会去除工作区的修改，变到和暂存区一样；否则（也就是只有更改但是未add）会去除工作区的修改，变到和本地仓库一样。
```
```
git reset HEAD file //去掉已经加入暂存区中的修改（这个命令的本意是“恢复版本”，所以就是恢复到本地仓库的版本，因此可以去掉暂存区的修改。）
```

https://my.oschina.net/xdev/blog/114383 （以上那俩可以参照这个页面的基本用法那里的 ）

```
git rm --cached file //去除已加入追踪的file。此外，git rm -f file是连file都直接删除了
```

*PS：切换分支（在未冲突的情况下），untracked文件，工作区和暂存区都会保存。也就是git的各个分支之间是共用这些区域的。*

```
git reset --hard versionnum
```
https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013744142037508cf42e51debf49668810645e02887691000/

```
git clean -xdf命令待完成
```
<<git如何删除本地所有未提交的更改>>
https://www.v2ex.com/t/66718

<<Git常用的撤销操作>>
http://www.netpi.me/uncategorized/gitrevoke/


### gitignore文件忽略

如果要忽略 .gitignore 文件本身。应该在repository的主目录（也就是 .git 所在的目录）下所创建的 .gitignore 文件内容里加上 .gitignore 文件本身。听起来有点绕，比如我的git仓库在用户主目录下的gitproject目录里（也就是~/gitproject），我现在如果只是忽略html文件，那么很简单，在该目录（也就是~/gitproject） 下新建个.gitignore 文件，里面内容是：
```
*.html
```
即可。但是问题来了，输入git status看一下会发现.gitignore 文件本身又变成untracked的了。所以如果连.gitignore 文件也想忽略，应该把该文件内容改成：
```
*.html
.gitignore 
```
 其实想表达的最核心点是.gitignore  所忽略的主目录就是其所在的目录。我最开始是这样写它的内容的：
 ```
*.html
./.gitignore
甚至写成
*.html
~/gitproject/.gitignore
都不行
```
所以大概可以推断其只能从自己所在的目录开始，更上层的目录根本管不着！

<<Git忽略规则.gitignore梳理>>
http://www.cnblogs.com/kevingrace/p/5690241.html

### git log

<<Git代码行统计命令集>>
https://segmentfault.com/a/1190000002434755
```
提交数统计：git log --oneline | wc -l 
```

### git rebase
<<Git Community Book 中文版 - rebase>>
http://gitbook.liuhui998.com/4_2.html

```
# git rebase 实验过程

1.以某个分支如basebranch为起点创建并切换两个一模一样的分支111,222:
git checkout -b 111
git checkout -b 222

2.在这两个分支上分别做两次不同的修改和提交(为了简单起见，这两次不会有冲突，后续无需merge):
git commit -m 111_1
git commit -m 111_2
此时111分支的路线是basebranch --> 111_1 --> 111_2

git commit -m 222_1
git commit -m 222_2
此时222分支的路线是basebranch --> 222_1 --> 222_2

3.从111创建一模一样的分支1111，从222创建一模一样的分支2222
git checkout -b 1111
git checkout -b 2222

4.在分支2222上merge分支1111，在分支222上rebase分支111，观察log图
4.1.切换到2222，执行
git merge 1111
4.2.切换到222，执行
git rebase 111

提示如下：
First, rewinding head to replay your work on top of it...
Applying: 222_1
Applying: 222_2

4.3.分别在分支2222和分支222上查看log图
git log --graph --oneline
```

*不使用rebase，直接使用merge*
```
*   bd65d00 Merge branch '1111' into 2222
|\  
| * 5783c0c 111_2
| * a18e755 111_1
* | 0281750 222_2
* | 927481e 222_1
|/  
* fe5da30 Add secrutiy feature from MPPDB S79511 - To strengthen SSL certificate
```

*使用rebase*
```
* ca04343 222_2
* c148b23 222_1
* 5783c0c 111_2
* a18e755 111_1
* fe5da30 Add secrutiy feature from MPPDB S79511 - To strengthen SSL certificate
```


----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------

<<如何高效利用GitHub>> 
http://www.yangzhiping.com/tech/github.html

<<图解Git>>
https://my.oschina.net/xdev/blog/114383

### 阮一峰git系列

<<常用 Git 命令清单>>
http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

<<Git远程操作详解>>
http://www.ruanyifeng.com/blog/2014/06/git_remote.html
