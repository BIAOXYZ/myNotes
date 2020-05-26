
# 3.Git非常用命令

### git submodule

7.11 Git 工具 - 子模块 https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%AD%90%E6%A8%A1%E5%9D%97
> 感觉官方文档就已经够了，我是大概走了建主仓并在主仓里添加子模块的步骤。此外在过去的工作中用到过从远程仓库更新子模块等的步骤。所以基本就差不多了，没啥难的，顶多到时候再看一遍就知道了。
1. 先在github建了个仓库`https://github.com/BIAOXYZ/onlineCoursesAndSubmodules`。
2. 把该仓库clone到本地，并在仓库主目录建一个文件夹`notesFromOtherPlaces`。此时目录结构为：
```
drwxr-xr-x 1 LL 197121   0 Dec 16 03:34 ./
drwxr-xr-x 1 LL 197121   0 Dec 16 03:26 ../
drwxr-xr-x 1 LL 197121   0 Dec 16 15:43 .git/
drwxr-xr-x 1 LL 197121   0 Dec 16 03:26 MIT_18.06_Linear_Algebra/
drwxr-xr-x 1 LL 197121   0 Dec 16 03:33 notesFromOtherPlaces/
-rw-r--r-- 1 LL 197121  91 Dec 16 03:26 README.md
```
3. 进入到`notesFromOtherPlaces`目录，并在该文件夹下执行`git submodule add https://github.com/apachecn/math.git`。然后项目根目录会多出来一个`.gitmodules`文件；`notesFromOtherPlaces`目录会把apachecn的那个项目包括进来。
```
drwxr-xr-x 1 LL 197121   0 Dec 16 03:34 ./
drwxr-xr-x 1 LL 197121   0 Dec 16 03:26 ../
drwxr-xr-x 1 LL 197121   0 Dec 16 15:43 .git/
-rw-r--r-- 1 LL 197121 118 Dec 16 03:34 .gitmodules
drwxr-xr-x 1 LL 197121   0 Dec 16 03:26 MIT_18.06_Linear_Algebra/
drwxr-xr-x 1 LL 197121   0 Dec 16 03:33 notesFromOtherPlaces/
-rw-r--r-- 1 LL 197121  91 Dec 16 03:26 README.md
```
4. 执行下git status会发现：仓库根目录下多了`.gitmodules`文件；你自己设定好的子模块位置下多了需要添加为子模块的某个仓库（这里是apachecn里MIT线性代数笔记仓库）。
```
LL@daxian-pc MINGW64 /e/githubrep/onlineCoursesAndSubmodules/notesFromOtherPlaces (master) 
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   ../.gitmodules
        new file:   math
```
5. 再commit一次，此时远程的仓库算是好了。
6. （这步过去工作的时候用过，但和前面5个步骤不同的是，这步没在自己机器再试了(/ □ \)）别人或者自己的其他电脑从这个远程仓库clone到本地时需注意子模块的更新要单独更新。
7. 最后看一眼`.gitmodules`里的内容。
```
LL@daxian-pc MINGW64 /e/githubrep/onlineCoursesAndSubmodules (master)
$ cat .gitmodules
[submodule "notesFromOtherPlaces/math"]
        path = notesFromOtherPlaces/math
        url = https://github.com/apachecn/math.git
```

### git subtree

git subtree教程 https://segmentfault.com/a/1190000012002151

### git fsck

<<github总结(4)--关于git reset --hard这个命令的惨痛教训>>
https://www.cnblogs.com/hope-markup/p/6683522.html
```
git fsck --lost-found
```

### git blame

### git show

### git tag

易百教程 -- git tag命令 
https://www.yiibai.com/git/git_tag.html

廖雪峰git教程 -- 标签管理https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013762144381812a168659b3dd4610b4229d81de5056cc000
```
git tag   查看当前所有tag
git show tagname    查看名为tagname的tag的信息
git tag -a tagname -m "tag message" [commit id]   在commit id上增加名为tagname，信息为tag message的tag
git tag -d tagname  删除名为tagname的tag
git push origin v1.0  推送v1.0标签到origin
git push origin --tags 推送所有标签到origin
git push origin :refs/tags/v0.9 将本地的v0.9标签删除操作推送到远程
                              （之前当然要先本地执行删除tag操作: git tag -d v0.9）
```

Git查看、删除、重命名远程分支和tag https://yq.aliyun.com/articles/382627
```
git push origin --delete tag v1.0  删除远程tag的另一种（更自然的）方式
git fetch origin tag v1.0  从远程获取tag

另外这个贴里面关于分支的操作也不错，补一些：
git remote show branchname (以前只是用git remote show，这样只会显示所有分支名。加了分支名称后显示信息很详细)
git remote prune origin 或 git fetch -p (删除不存在对应远程分支的本地分支————这个回来再研究下吧) 
git branch -av 比git branch -a显示信息全多了
```

.6 Git 基础 - 打标签 https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%89%93%E6%A0%87%E7%AD%BE

### git stash

https://git-scm.com/book/zh/v1/Git-%E5%B7%A5%E5%85%B7-%E5%82%A8%E8%97%8F%EF%BC%88Stashing%EF%BC%89

https://www.cnblogs.com/craftor/archive/2012/11/04/2754149.html


你可能不知道的关于 Git stash 的技巧 - KenChoi的文章 - 知乎 http://zhuanlan.zhihu.com/p/33435204

**--------------------------------------------------**
`#` ***git stash 个人实战：开始***
**--------------------------------------------------**

##### -----开始阶段

- 原始文件:
```
xxx,yyy,zzz
```

##### -----编辑内容，存储stash的阶段

- 第一次编辑后:
```
xxx,yyy,zzz
111
```

- 执行git stash存储(存储完成后工作区就干净了):
```
liuliang@SZX1000126633:script {dev}\> git stash
Saved working directory and index state WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
```

- 执行git stash list查看存储：
```
liuliang@SZX1000126633:script {dev}\> git stash list
stash@{0}: WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
(END)
```

- 第二次编辑后:
```
xxx,yyy,zzz
222
```

- 这次执行git stash save "2nd-cunchu"存储(存储完成后工作区干净，且信息是save参数后的信息)：
```
liuliang@SZX1000126633:script {dev}\> git stash save "2nd-cunchu"
Saved working directory and index state On dev: 2nd-cunchu
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
```

- 再次执行git stash list查看存储：
```
liuliang@SZX1000126633:script {dev}\> git stash list
stash@{0}: On dev: 2nd-cunchu
stash@{1}: WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
(END)
```

##### -----应用stash的阶段

- 执行git stash apply，完成后文件把第二次的存储222写上去了，并且存储栈里的内容都还在：
```
xxx,yyy,zzz
222
```

- 恢复回去(直接用git reset --hard即可)后，这次执行git stash apply stash@{1}，存储在栈里的内容也都在，但是文件是把第一次存储的111写上去了。
```
xxx,yyy,zzz
111
```

- 恢复回去(直接用git reset --hard即可)后，这次试试git stash pop。成功后文件内容是恢复栈顶的222，不同于git stash apply的是，栈里的222那次stash的内容没了。其实从字面意思也比较好区分apply和pop。
```
xxx,yyy,zzz
222
```
```
liuliang@SZX1000126633:script {dev}\> git stash list
stash@{0}: WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
(END)
```

- 再次恢复回去(这次是用git stash save "message"再存一次)，本次验证带参数的情况，git stash pop stash@{XXX}。其效果和对应的带参数的git stash apply stash@{XXX}类似，除了一点区别：pop应用完改动后会从栈里弹出(删除掉)那个存储。
```
liuliang@SZX1000126633:script {dev}\> git stash save "2nd-cunchu-2"
Saved working directory and index state On dev: 2nd-cunchu-2
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'

liuliang@SZX1000126633:script {dev}\> git stash list
stash@{0}: On dev: 2nd-cunchu-2
stash@{1}: WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
(END)
```

```
liuliang@SZX1000126633:script {dev}\> git stash pop stash@{1}
```
```
xxx,yyy,zzz
111
```
```
liuliang@SZX1000126633:script {dev}\> git stash list
stash@{0}: On dev: 2nd-cunchu-2
(END)
```

##### -----其他stash相关命令
- 还有一些如下(有了上面的例子比较直观，不在列举了。但是都本地试了)：
```
git stash clear 这条命令会删除仓库中创建的所有的 stash。有可能不能恢复。
git stash drop 这条命令会删除工作栈中最近的 stash。但是要谨慎地使用，有可能很难恢复。
git stash drop stash@{1} 可以声明stash id来删除。

你也可以存储没有追踪的文件。
git stash save -u
or
git stash save --include-untracked

PS：实际上save参数不是必须的，参见下面例子。

liuliang@SZX1000126633:script {dev}\> git stash -u
Saved working directory and index state WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'

liuliang@SZX1000126633:script {dev}\> git stash save -u
Saved working directory and index state WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'

liuliang@SZX1000126633:script {dev}\> git stash --include-untracked
Saved working directory and index state WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'

liuliang@SZX1000126633:script {dev}\> git stash save --include-untracked
Saved working directory and index state WIP on dev: 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
HEAD is now at 27e1b24 Merge MR-1590 from branch 'y00383491/GAUSS200_OLAP_TRUNK.git::master' into 'master'
```

**--------------------------------------------------**
`#` ***git stash 个人实战：结束***
**--------------------------------------------------**

### git rebase
<<Git Community Book 中文版 - rebase>>
http://gitbook.liuhui998.com/4_2.html

<<git merge, rebase和*(no branch)>>
http://blog.csdn.net/xiaoputao0903/article/details/23995055

【[:star:][`*`]】 Rebase 代替合并 https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/rebase || Rebase as an Alternative to Merge https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/rebase
- > Rebase 整合
- > Rebase 存在的陷阱
  * > 当然，使用 rebase 操作不会是永远一帆风顺的。很有可能会搬起石头砸自己的脚，因此你不能忽视一个重要的事实：**rebase 会改写历史记录**。
  * > 你有可能已经注意到了，在被 rebase 操作之后的版本中，提交 “`C3*`” 存在一个新添加的星号。这是因为，尽管这个提交的内容和 “`C3`” 完全一样，但是它实际上是一个不同的提交。这样做的原因是，它现在有一个新的源提交 `C4`（在最初创建 `C3` 时的源提交是 `C1`）。
  * > 如果还仅仅只是操作那些尚未发布的提交，重写历史记录本身也没有什么很大的问题。但是如果你重写了已经发布到公共服务器上的提交历史，这样做就非常危险了。其他的开发人员可能这时已经在最原始的提交 `C3` 上开始工作，并使它成为了一些新提交中不可或缺的部分，而现在你却把 `C3` 的改动设置到了另一个时间点（就是那个新的 `C3*`）。除此之外，通过rebase 操作，这个原始的 `C3` 还被删除掉了，这将是非常可怕的……
  * > ***因此你应该只使用 rebase 来清理你的本地工作，千万不要尝试着对那些已经被发布的提交进行这个操作***。

Merging vs. Rebasing https://www.atlassian.com/git/tutorials/merging-vs-rebasing

git rebase in depth https://git-rebase.io/

**--------------------------------------------------**
`#` ***git rebase 个人实战：开始***
**--------------------------------------------------**

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
> 注意看commit id，对比上一个，没有发生变化的是`111_1`的`a18e755`和`111_2`的`5783c0c`。这其实就是“rebase”的含义所在：**把当前分支（分支222）的base从原来的`fe5da30`给rebase到另一个分支（分支111）的最新的commit（`111_2`对应的`5783c0c`）后面**。就算没有冲突，`222_1`和`222_2`因为其父提交已经变了，所以肯定commit id也会变；如果有冲突，那连内容也会变。
>> 所以如果假设master分支是分支222，feature分支是分支111。本例相当于切换到master分支上去rebase feature，这个rebase操作完成后会把master的记录都改写（当然是指非fast forward的情况），这种肯定是不行的。常用的情况是：本地正在feature分支上开发，远程master分支上有别人提新的commit，把这些commit拉下来后，***在本地feature分支上去rebase master***。

**--------------------------------------------------**
`#` ***git rebase 个人实战：结束***
**--------------------------------------------------**

### git fetch(也包含部分git pull的内容)

*关于git pull在branch1上往branch2拉代码的问题(测试版本为git 2.1.3):*
```
当前处于master分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把master也更新到最新。

当前处于branch1分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把branch1也更新到最新。

当前处于branch2分支: 
git pull remoterepo master:branch2 -- 只会把branch2更新到最新。
```

### git mv

- git-mv - Move or rename a file, a directory, or a symlink https://git-scm.com/docs/git-mv
- git mv命令 -- 易百教程 https://www.yiibai.com/git/git_mv.html
- What's the purpose of git-mv? https://stackoverflow.com/questions/1094269/whats-the-purpose-of-git-mv

>> notes: 一个没有什么用的命令，比如你有个文件`1.md`，想把它放到另外一个目录里。我过去都是直接剪切过去，然后`git add .`，最后`git commit -m "some commit information"`。用`git mv`不过就是达到了无需`git add .`，直接commit就可以。但是最关键的`.git`目录下的空间还是膨胀了。。。所以还是得研究下git gc之类减小仓库空间的命令。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
