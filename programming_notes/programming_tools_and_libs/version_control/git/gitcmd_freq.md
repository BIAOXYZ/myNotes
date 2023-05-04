
# 0.背景

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

# 1.Git常用命令

### 比较版本差异 (git diff)

[<<git: 提交前查看修改 git diff，HEAD^, HEAD~i>>](http://blog.csdn.net/gw569453350game/article/details/46998395)
```
git diff //比较工作区和暂存区，也就是<1>和<2>
git diff --cached //比较暂存区和本地仓库，也就是<2>和<3>
git diff HEAD //比较工作区和本地仓库，也就是<1>和<3>

git diff HEAD^ HEAD
git diff <commit_id1> <commit_id2> -- <filename>
```

<<如何在git中对比当前工作区和远程仓库的区别？>> https://www.zhihu.com/question/53601264
```
git diff <local branch> <remote>/<remote branch>
```

Git diff代码比较的高级技巧 https://blog.csdn.net/offbye/article/details/6592563
```
比较不同的commit，使用以下命令就可以了 
git difftool -t meld -y  commitId1  commitId2 

//由于meld依赖python3，所以linux上我是常用这个命令：git difftool -t vimdiff -y HEAD HEAD~
//————该命令在operator-sdk生成operator和CRD的框架时候很用于，每次执行一个operator-sdk的命令就commit一次，
//————然后对比相邻两个commit就知道干了点啥，比 find ./ -mmin 1 好用多了。后者只能看出来一分钟内哪些文件变了，
//————但是看不出怎么变了。并且还有可能不准确，因为有时候变动的文件太多了，超过1分钟了。
```

----------------------------------------------------------------------------------------------------

### git merge

git-merge完全解析 https://www.jianshu.com/p/58a166f24c81

#### 压缩多次（无意义）提交为一次

```
git merge --squash branch1
```
>（无冲突情况下）执行后branch1上所有的提交都会变成在当前分支的暂存区的内容，然后提交一次就可以。

----------------------------------------------------------------------------------------------------

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

Oh Shit, Git!?! https://ohshitgit.com/zh
- > 哎呦我去，我刚提交 commit 就发现还有一个小改动需要添加！
```console
# 继续改动你的文件
git add . # 或者你可以添加指定的文件
git commit --amend --no-edit
# 你这次的改动会被添加进最近一次的 commit 中
# 警告: 千万别对公共的 commit 做这种操作
```

----------------------------------------------------------------------------------------------------

## 撤销类

<<Git常用的撤销操作>> http://www.netpi.me/uncategorized/gitrevoke/

<<如何在 Git 里撤销(几乎)任何操作>> http://blog.jobbole.com/87700/

### 撤销工作区和暂存区的修改
```
git checkout -- file //是把当前最新的编辑去掉，使file变为一个次新的版本。也就是说，当前file如果<1><2>都有，则会去除工作区的修改，变到和暂存区一样；否则（也就是只有更改但是未add）会去除工作区的修改，变到和本地仓库一样。
```
```
git reset HEAD file //去掉已经加入暂存区中的修改（这个命令的本意是“恢复版本”，所以就是恢复到本地仓库的版本，因此可以去掉暂存区的修改。）
# 也有用 git reset -- file 的
```

```
git rm --cached file //去除已加入追踪的file。此外，git rm -f file是连file都直接删除了
```
```
git rm --cached -r dir //目录的话加-r，递归删除
```

*PS：切换分支（在未冲突的情况下），untracked文件，工作区和暂存区都会保存。也就是git的各个分支之间是共用这些区域的。*

#### 多个加入暂存区的修改一次 unstage 掉

How to unstage large number of files without deleting the content https://stackoverflow.com/questions/7103631/how-to-unstage-large-number-of-files-without-deleting-the-content
- https://stackoverflow.com/questions/7103631/how-to-unstage-large-number-of-files-without-deleting-the-content/24542753#24542753
  * > If all you want is to undo an overzealous "git add" run:
    ```sh
    git reset
    ```
    > Your changes will be unstaged and ready for you to re-add as you please.
  * > DO NOT RUN `git reset --hard`. It will not only unstage your added files, but will revert any changes you made in your working directory. If you created any new files in working directory, it will not delete them though.

### 撤销提交 git reset 和 git revert

https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013744142037508cf42e51debf49668810645e02887691000/
```
git reset --hard versionnum
```

【[:star:][`*`]】 git reset详解 https://segmentfault.com/a/1190000009658888
```
soft就是只动repo
mixed就是动repo还有staging(这个是默认参数)
hard就是动repo还有staging还有working
```

git reset soft,hard,mixed之区别深解 https://www.cnblogs.com/kidsitcn/p/4513297.html

----------------------------------------------------------------------------------------------------

### 三个撤销的区别

git还原某个特定的文件到之前的版本 https://blog.csdn.net/L_yangliu/article/details/53197706
```
第一步： 在命令行中输入 git log src/main/main.c 得到该文件的commit 历史。
第二步： 复制需要回退版本的hash，在此假设我们回退到 d98a0f565804ba639ba46d6e4295d4f787ff2949 ,则复制该序列即可
第三步：checkout 对应版本。格式为 git checkout <hash> <filename>, 在此即为命令行中输入 git checkout 
d98a0f565804ba639ba46d6e4295d4f787ff2949 src/main/main.c
第四步： commit checkout下来的版本。 如： git commit -m "revert to previous version"
```

`5.2 代码回滚：Reset、Checkout、Revert 的选择` https://github.com/geeeeeeeeek/git-recipes/wiki/5.2-%E4%BB%A3%E7%A0%81%E5%9B%9E%E6%BB%9A%EF%BC%9AReset%E3%80%81Checkout%E3%80%81Revert-%E7%9A%84%E9%80%89%E6%8B%A9
> Resetting, Checking Out & Reverting https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting

----------------------------------------------------------------------------------------------------

### 清理类撤销 git clean
//已转移

----------------------------------------------------------------------------------------------------

### git log

<<Git代码行统计命令集>> https://segmentfault.com/a/1190000002434755
```
提交数统计：git log --oneline | wc -l 

//原文里这句错了，末尾的分号应为单引号。
添加或修改的代码行数： git log --stat|perl -ne 'END { print $c } $c += $1 if /(\d+) insertions/; 
```

git代码统计 https://segmentfault.com/a/1190000008542123
> 这个帖子和上面那个很相似，不同点是多了`gitstats`和`cloc`的简略用法，但是少了一个命令以及各个命令参数的解释。另外有些功能一样的命令细节稍有区别。


<<[译]git log>>
https://www.cnblogs.com/irocker/p/git-log.html
```
git log -p
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
