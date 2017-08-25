
### 配置git (git config)

```
设置用户名
git config --global user.name "Scott Chacon"
设置邮箱
git config --global user.email "schacon@gmail.com"
```

克隆仓库
git clone address

或初始化仓库
git init


### 比较版本差异 (git diff)

```
git diff //比较工作区和暂存区，也就是<1>和<2>

git diff --cached //比较暂存区和本地仓库，也就是<2>和<3>

git diff HEAD //比较工作区和本地仓库，也就是<1>和<3>

git diff HEAD^ HEAD
```
<<git: 提交前查看修改 git diff，HEAD^, HEAD~i>>
http://blog.csdn.net/gw569453350game/article/details/46998395


### 更改提交

git commit --amend

如果想更改一次提交，使用git commit --amend, git会使用与当前提交相同的父节点进行一次新提交，旧的提交会被取消。

<<Git 的 commit message 写错了，有办法进行修改么？>>
https://segmentfault.com/q/1010000000761908


### 撤销工作区和暂存区的修改

git checkout -- file //是把当前最新的编辑去掉，使file变为一个次新的版本。也就是说，当前file如果<1><2>都有，则会去除工作区的修改，变到和暂存区一样；否则（也就是只有更改但是未add）会去除工作区的修改，变到和本地仓库一样。

git reset HEAD file //去掉已经加入暂存区中的修改（这个命令的本意是“恢复版本”，所以就是恢复到本地仓库的版本，因此可以去掉暂存区的修改。）

https://my.oschina.net/xdev/blog/114383 （以上那俩可以参照这个页面的基本用法那里的 ）


git rm --cached file //去除已加入追踪的file。此外，git rm -f file是连file都直接删除了


PS：切换分支（在未冲突的情况下），untracked文件，工作区和暂存区都会保存。也就是git的各个分支之间是共用这些区域的。

----------------------------------------------------------------------------------------------------
# 2.other part:
----------------------------------------------------------------------------------------------------

<<如何高效利用GitHub>> 
http://www.yangzhiping.com/tech/github.html

<<图解Git>>
https://my.oschina.net/xdev/blog/114383
