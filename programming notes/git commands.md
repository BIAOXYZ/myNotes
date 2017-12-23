
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

### git merge

https://www.jianshu.com/p/58a166f24c81

#### 更改提交信息
```
git commit --amend
```
>如果想更改一次最新的提交，使用git commit --amend。会弹出一个文本，然后修改提交信息（即修改文本内容）再提交一次。git会使用与当前提交相同的父节点进行一次新提交，旧的提交会被取消。
>如果想修改提交信息的提交不是最新一次，且需要保持历史提交记录，可以按如下思路：
```
1.先复制一个当前分支(cherry-pick时好取commit_id)
2.把要修改提交信息的分支 git reset --hard HEAD~x 到该提交为最新提交 
3.用 git commit --amend 把提交信息改了。
4.用 git cherry-pick commit_id 的办法把后续提交一个个取回来。
```
如果不需要保持历史提交记录(这个应该比较少见，不然为改个提交信息把历史都改了- -)，可以git reset --soft全部恢复到暂存区，然后一次提交。

<<Git 的 commit message 写错了，有办法进行修改么？>>
https://segmentfault.com/q/1010000000761908


#### 压缩多次（无意义）提交为一次

```
git merge --squash branch1
```
>（无冲突情况下）执行后branch1上所有的提交都会变成在当前分支的暂存区的内容，然后提交一次就可以。

## 撤销类

<<Git常用的撤销操作>>
http://www.netpi.me/uncategorized/gitrevoke/

<<如何在 Git 里撤销(几乎)任何操作>>
http://blog.jobbole.com/87700/


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

### 撤销提交 git reset 和 git revert

```
git reset --hard versionnum
```
https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013744142037508cf42e51debf49668810645e02887691000/

https://segmentfault.com/a/1190000009658888

https://www.cnblogs.com/qianqiannian/p/6010238.html

https://www.cnblogs.com/kidsitcn/p/4513297.html


### 清理类撤销 git clean

```
git clean -xdf命令待完成
```
<<git如何删除本地所有未提交的更改>>
https://www.v2ex.com/t/66718

http://blog.csdn.net/leedaning/article/details/50125375

https://www.cnblogs.com/xuange306/p/6838964.html


### git log

<<Git代码行统计命令集>>
https://segmentfault.com/a/1190000002434755
```
提交数统计：git log --oneline | wc -l 
```

<<[译]git log>>
https://www.cnblogs.com/irocker/p/git-log.html
```
git log -p
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## git设置类and插件类等（非原生git包含有）

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

git diff ^M的消除
https://www.cnblogs.com/chunguang/p/5541896.html

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

### git自动补全和别名

http://blog.csdn.net/kuaileboy1989/article/details/43022979

https://www.cnblogs.com/eddy-he/archive/2012/03/08/git_auto_comple.html

https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%8A%80%E5%B7%A7%E5%92%8C%E7%AA%8D%E9%97%A8


### gittjk
<<gitjk：撤销刚在 Git 中的操作>>
http://hao.jobbole.com/gitjk/

### git flow
http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html


### git lfs



:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



## git非常用命令

### git fsck

<<github总结(4)--关于git reset --hard这个命令的惨痛教训>>
https://www.cnblogs.com/hope-markup/p/6683522.html
```
git fsck --lost-found
```

### git blame

### git show

### git stash

https://git-scm.com/book/zh/v1/Git-%E5%B7%A5%E5%85%B7-%E5%82%A8%E8%97%8F%EF%BC%88Stashing%EF%BC%89

https://www.cnblogs.com/craftor/archive/2012/11/04/2754149.html

### git rebase
<<Git Community Book 中文版 - rebase>>
http://gitbook.liuhui998.com/4_2.html

<<git merge, rebase和*(no branch)>>
http://blog.csdn.net/xiaoputao0903/article/details/23995055

```
# git rebase 实验过程

1.以某个分支如basebranch为起点创建并切换两个一模一样的分支111,222:
git checkout -b 111
git checkout -b 222

2.在这两个分支上分别做两次不同的修改和提交(为了简单起见，这两次不会有冲突，后续无需merge):
git commit -m 111_1
git commit -m 111_2
此时111分支的路线是basebranch <-- 111_1 <-- 111_2

git commit -m 222_1
git commit -m 222_2
此时222分支的路线是basebranch <-- 222_1 <-- 222_2

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


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------

<<如何高效利用GitHub>> 
http://www.yangzhiping.com/tech/github.html

<<图解Git>>
https://my.oschina.net/xdev/blog/114383

### 阮一峰git系列

- <<常用 Git 命令清单>>
http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

- <<Git远程操作详解>>
http://www.ruanyifeng.com/blog/2014/06/git_remote.html
```
git branch --set-upstream master origin/next

上面命令指定master分支追踪origin/next分支。
```
```
git push --all origin
git push --force origin  //感觉这个比较实用，看描述能删远程仓库的commit
git push origin --tags
```
- <<Git 使用规范流程>>
http://www.ruanyifeng.com/blog/2015/08/git-use-process.html

### 
<<Git push与pull的默认行为>>
https://segmentfault.com/a/1190000002783245

<<Git远程分支和refs文件详解>>
http://blog.csdn.net/forever_wind/article/details/37506389

### 其他高级技巧或知识
http://blog.jobbole.com/75348/

<<趣文：那些会用 Git 的动物>>
http://blog.jobbole.com/20123/

<<Git 常用命令速查表(图文+表格)>>
http://www.jb51.net/article/55442.htm

<<Git HEAD detached from XXX (git HEAD 游离) 解决办法>>
http://blog.csdn.net/u011240877/article/details/76273335


## git push -u origin master 

```
上面命令将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push了。

不带任何参数的git push，默认只推送当前分支，这叫做simple方式。此外，还有一种matching方式，会推送所有有对应的远程分支的本地分支。Git 2.0版本之前，默认采用matching方法，现在改为默认采用simple方式。如果要修改这个设置，可以采用git config命令。
```
http://www.yiibai.com/git/git_push.html


**Command line instructions**
- Git global setup
```
git config --global user.name "liuliang 00384038"
git config --global user.email "liuliang21@huawei.com"
```
- Create a new repository
```
git clone http://code.huawei.com/l00384038/DBATG_Work_Progress.git
cd DBATG_Work_Progress
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```
- Existing folder
```
cd existing_folder
git init
git remote add origin http://code.huawei.com/l00384038/DBATG_Work_Progress.git
git add .
git commit
git push -u origin master
```
- Existing Git repository
```
cd existing_repo
git remote add origin http://code.huawei.com/l00384038/DBATG_Work_Progress.git
git push -u origin --all
git push -u origin --tags
```

## Github相关

<<为什么我pull request后全部放在一个未关闭的pull request里面了>>
https://segmentfault.com/q/1010000005178786
