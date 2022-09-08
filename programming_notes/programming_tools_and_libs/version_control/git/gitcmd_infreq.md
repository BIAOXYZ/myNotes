
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

Can git do a diff of the working copy with stash https://stackoverflow.com/questions/8058611/can-git-do-a-diff-of-the-working-copy-with-stash
- https://stackoverflow.com/questions/8058611/can-git-do-a-diff-of-the-working-copy-with-stash/8058684#8058684
  * > If it was your most recent stash, `git diff stash@{0}` will do it. If not, you can use `git stash list` to get the index of which stash you want to compare to.

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
