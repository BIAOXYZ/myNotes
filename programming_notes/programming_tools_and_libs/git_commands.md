
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
```

<<如何在git中对比当前工作区和远程仓库的区别？>>
https://www.zhihu.com/question/53601264
```
git diff <local branch> <remote>/<remote branch>
```

----------------------------------------------------------------------------------------------------

### git merge

https://www.jianshu.com/p/58a166f24c81

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

----------------------------------------------------------------------------------------------------

#### 压缩多次（无意义）提交为一次

```
git merge --squash branch1
```
>（无冲突情况下）执行后branch1上所有的提交都会变成在当前分支的暂存区的内容，然后提交一次就可以。

----------------------------------------------------------------------------------------------------

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
```
git rm --cached -r dir //目录的话加-r，递归删除
```

*PS：切换分支（在未冲突的情况下），untracked文件，工作区和暂存区都会保存。也就是git的各个分支之间是共用这些区域的。*

### 撤销提交 git reset 和 git revert

```
git reset --hard versionnum
```
https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013744142037508cf42e51debf49668810645e02887691000/

https://segmentfault.com/a/1190000009658888
```
soft就是只动repo
mixed就是动repo还有staging(这个是默认参数)
hard就是动repo还有staging还有working
```

https://www.cnblogs.com/qianqiannian/p/6010238.html

https://www.cnblogs.com/kidsitcn/p/4513297.html

----------------------------------------------------------------------------------------------------

### 清理类撤销 git clean

<<git如何删除本地所有未提交的更改>>
https://www.v2ex.com/t/66718
```
git clean -df 一般用这个就可以，但是注意要选对目录:目录太低删不干净。
git clean -ndf 有-n参数就是只是显示哪些会被删，但不做删除
git clean -xdf -x参数的意义如下：

默认情况下，git clean 命令只会移除没有忽略的未跟踪文件。 任何与 .gitiignore 
或其他忽略文件中的模式匹配的文件都不会被移除。 如果你也想要移除那些文件，例如
为了做一次完全干净的构建而移除所有由构建生成的 .o 文件，可以给 clean 命令增加一个 -x 选项。
(https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%82%A8%E8%97%8F%E4%B8%8E%E6%B8%85%E7%90%86)
```

http://blog.csdn.net/leedaning/article/details/50125375

https://www.cnblogs.com/xuange306/p/6838964.html


How to remove local (untracked) files from the current Git working tree?
https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree
```
If untracked directory is a git repository of its own (e.g. submodule), you need to use -f twice:

git clean -d -f -f
```
*这个里面提供了不少达到git clean目的的技巧，但是最稳妥还是git clean -df*

----------------------------------------------------------------------------------------------------

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


# 2.Git设置类and插件类等（非原生git包含有）

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

### 配置密钥等：

<<git/github初级运用自如>>
https://www.cnblogs.com/fnng/archive/2012/01/07/2315685.html

### git彩色显示分支名

```shell
之前在华为的时候用的是这个，忘了是哪儿查到的了已经：

####################
# for automatically displaying branch information in linux shell

function parse_git_branch_and_add_brackets {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \{\1\}/'
}
PS1="\u@\h:\033[1;33m\]\W\[\033[1;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\]\> "
####################

然后自己还研究了下git自动补全，于是有：

####################
# for git auto completion

source ~/.git-completion.bash
####################
```

让 Shell 命令提示符显示 Git 分支名称 https://www.jianshu.com/p/82783f76a868
```shell
function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}
PS1="\u@\h \[\033[0;36m\]\W\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\] \$ "
```
这个帖子里讲了各种变量的含义，不过配出来的效果我还是不太满意，回头自己总结个更好的。

----------------------------------------------------------------------------------------------------

### 如何把本地已有代码上传到远端（以GitHub为例）

Git--将已有的项目添加到github https://blog.csdn.net/north1989/article/details/53471439
```
注：不复制文章内容了，总结一下过程其实就是三大步骤：
1.远端先建个空仓库(没有账号的话远端先建个账号，还有SSH key之类的不赘述了)。
2.本地已有代码目录git init一下，把它变成个本地代码库。然后把该添加的东西都添加到本地git库里。
3.把本地仓库的remote设成那个远端空仓库的地址，push。
后面的操作就跟正常的直接从远端拉的仓库一样了。
```
```
算了，还是把全过程记录一遍吧，以IBM的企业版github为例：

- 首先在github企业版建了个仓库，地址为: https://github.ibm.com/liulliu/supplychainfinance 
(建仓库时README那些无所谓。不过对于将本地仓库上传到远端这种情形，个人感觉还是后面再建比较好点)
$ ssh-keygen -t rsa -b 4096 -C "liulliu@cn.ibm.com" 
(生成后添加到远端仓库不是用命令形式，所以省略了)
$ git init
$ git add .
$ git commit -m "initialization commit"
$ git remote add origin git@github.ibm.com:liulliu/supplychainfinance.git
$ git push -u origin master
$ git config --global user.name "Liang Liu"
$ git config --global user.email "liulliu@cn.ibm.com"
```

----------------------------------------------------------------------------------------------------

### git的http使用方式

https://stackoverflow.com/questions/5343068/is-there-a-way-to-skip-password-typing-when-using-https-on-github
```
总结：

1. git clone https://you:password@github.com/you/example.git
2. git push   //看到有的攻略上说要push时候也要密码，但是我这边就直接git push就推上去了。
```

----------------------------------------------------------------------------------------------------

### git一次push同步到多个仓库

- 一个项目push到多个远程Git仓库 https://segmentfault.com/a/1190000011294144
- git本地仓库关联多个remote,怎么用本地一个分支向不同remote不同分支推送代码？ - stormzhang的回答 - 知乎https://www.zhihu.com/question/46543115/answer/101761754

>> notes: 实际上这里还是没有解决我的需求————也就是在线commit后，其他网络仓库（Gitlab，Bitbucket等）和本地仓库（本地仓库不自动同步也无所谓，只要保证多个在线仓库能自动同步就行）能够自动同步。从而使得后面就算再发生此类事件，也能保证不止一处有最新的笔记。

----------------------------------------------------------------------------------------------------

#### git diff会有些^M

git diff ^M的消除
https://www.cnblogs.com/chunguang/p/5541896.html

----------------------------------------------------------------------------------------------------

### git config --list
<<.5 起步 - 初次运行 Git 前的配置>>
https://git-scm.com/book/zh/v1/%E8%B5%B7%E6%AD%A5-%E5%88%9D%E6%AC%A1%E8%BF%90%E8%A1%8C-Git-%E5%89%8D%E7%9A%84%E9%85%8D%E7%BD%AE

```
Git 提供了一个叫做 git config 的工具（译注：实际是 git-config 命令，只不过可以通过 git 加一个名字来呼叫此命令。），
专门用来配置或读取相应的工作环境变量。而正是由这些环境变量，决定了 Git 在各个环节的具体工作方式和行为。这些变量可以存放在以下三个不同的地方：

-- /etc/gitconfig 文件：系统中对所有用户都普遍适用的配置。若使用 git config 时用 --system 选项，读写的就是这个文件。
-- ~/.gitconfig 文件：用户目录下的配置文件只适用于该用户。若使用 git config 时用 --global 选项，读写的就是这个文件。
-- 当前项目的 Git 目录中的配置文件（也就是工作目录中的 .git/config 文件）：这里的配置仅仅针对当前项目有效。每一个级别的配置都会覆盖上层的
相同配置，所以 .git/config 里的配置会覆盖 /etc/gitconfig 中的同名变量。
-- 在 Windows 系统上，Git 会找寻用户主目录下的 .gitconfig 文件。主目录即 $HOME 变量指定的目录，一般都是 C:\Documents and Settings\$USER。
此外，Git 还会尝试找寻 /etc/gitconfig 文件，只不过看当初 Git 装在什么目录，就以此作为根目录来定位。
```

```
要检查已有的配置信息，可以使用 git config --list 命令
有时候会看到重复的变量名，那就说明它们来自不同的配置文件（比如 /etc/gitconfig 和 ~/.gitconfig），不过最终 Git 实际采用的是最后一个。

也可以直接查阅某个环境变量的设定，只要把特定的名字跟在后面即可，像这样：

$ git config user.name
Scott Chacon
```

----------------------------------------------------------------------------------------------------

<<通过SSH 密钥连接GitHub/Bitbucket>>
http://blog.csdn.net/lue2009/article/details/46551201
```
4. 分别打开 github.com和bitbucket.org 用之前注册过的账号登录。
在账号设置里有个SSH KEY 相关的，Add Key ，然后将公钥文件id_rsa.pub文件里的内容复制到各自里面。
(bigbucket.org github.com可以公用一套公钥和私钥)
```
*说是这么说，其实我发现如果用github的windows客户端，生成的公钥私钥名字叫github_rsa.pub，github_rsa。然后我贴了公钥到bitbucket发现咋都不行。后来才想到是名字不对！于是把github_rsa另存一份，重命名成id_rsa，然后就解决了。*

----------------------------------------------------------------------------------------------------

### git彩色显示

<<.1 自定义 Git - 配置 Git>>
https://git-scm.com/book/zh/v1/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-%E9%85%8D%E7%BD%AE-Git
```
git config --global color.ui true
```

----------------------------------------------------------------------------------------------------

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

----------------------------------------------------------------------------------------------------

### git自动补全和别名
*注:还是第一个链接里那种从个人bashrc来的方式比较靠谱，第三个链接里git book提到的利用/etc/bash_completion.d/的方法有些机器不行。*

<<git-自动补全>>
https://www.cnblogs.com/eddy-he/archive/2012/03/08/git_auto_comple.html

http://blog.csdn.net/kuaileboy1989/article/details/43022979

<<.7 Git 基础 - 技巧和窍门>>
https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%8A%80%E5%B7%A7%E5%92%8C%E7%AA%8D%E9%97%A8

----------------------------------------------------------------------------------------------------

### gittjk
<<gitjk：撤销刚在 Git 中的操作>>
http://hao.jobbole.com/gitjk/

### git flow
http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html

### git lfs

### gitk

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


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


----------------------------------------------------------------------------------------------------
# 4.other part:
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

### 伯乐在线git系列

http://blog.jobbole.com/75348/

<<趣文：那些会用 Git 的动物>>
http://blog.jobbole.com/20123/

### 其他高级技巧或知识

🥡 Git recipes in Chinese by Zhongyi Tong. 高质量的Git中文教程.  https://geeeeeeeeek.github.io/git-recipes/  https://github.com/geeeeeeeeek/git-recipes
- 第5篇 Git 实用贴士
  * 第3章 Git log 高级用法 https://github.com/geeeeeeeeek/git-recipes/wiki/5.3-Git-log-%E9%AB%98%E7%BA%A7%E7%94%A8%E6%B3%95
  * 第4章 Git 钩子：自定义你的工作流 https://github.com/geeeeeeeeek/git-recipes/wiki/5.4-Git-%E9%92%A9%E5%AD%90%EF%BC%9A%E8%87%AA%E5%AE%9A%E4%B9%89%E4%BD%A0%E7%9A%84%E5%B7%A5%E4%BD%9C%E6%B5%81

####  git的refs
<<Git push与pull的默认行为>>
https://segmentfault.com/a/1190000002783245

<<Git远程分支和refs文件详解>>
http://blog.csdn.net/forever_wind/article/details/37506389

<<Git HEAD detached from XXX (git HEAD 游离) 解决办法>>
http://blog.csdn.net/u011240877/article/details/76273335

#### git本地分支与远程分支关联关系查询
git 如何查看当前分支的upstream? - 知乎 https://www.zhihu.com/question/27324031
```
这个帖子，包括下面的stackoverflow里的帖子基本都没有特别好的办法，回头再研究下吧。
https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking

目前最好的办法就是上面stackoverflow帖子里的：
git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)
```

### git常用命令综合类

<<Git 常用命令速查表(图文+表格)>>
http://www.jb51.net/article/55442.htm

<<Git 常用命令整理>>
http://justcoding.iteye.com/blog/1830388

今年下半年，中日合拍的《Git游记》即将正式开机，我将...（上集） https://juejin.im/post/5c22056551882518fc5fe294 [`*`][:star:]


### git书籍和系列教程(易百教程git部分就不再重复贴了)

<Pro Git>
https://www.gitbook.com/book/bingohuang/progit2/details
>远程分支 https://bingohuang.gitbooks.io/progit2/content/03-git-branching/sections/remote-branches.html

《Git权威指南》GotGit 书稿开源
https://segmentfault.com/p/1210000008626219
>http://www.worldhello.net/gotgit/

猴子都能懂的GIT入门
https://backlog.com/git-tutorial/cn/contents/


## git push -u origin master 

```
上面命令将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push了。

不带任何参数的git push，默认只推送当前分支，这叫做simple方式。此外，还有一种matching方式，会推送所有有对应的远程分支的本地分支。Git 2.0版本之前，默认采用matching方法，现在改为默认采用simple方式。如果要修改这个设置，可以采用git config命令。
```
http://www.yiibai.com/git/git_push.html


**Command line instructions** (https://gitlab.com/BIAOXYZ/testproject)
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

### Github Gist

如何看待 Github Gist 这个服务，怎样更好的利用？ - 知乎用户的回答 - 知乎
https://www.zhihu.com/question/21343711/answer/32023379
>GistBox http://www.gistboxapp.com/ (后改名cacher https://www.cacher.io/)

学习编程用什么做笔记比较好？ - pezy的回答 - 知乎
https://www.zhihu.com/question/21438053/answer/18790164

### https://raw.githubusercontent.com

What do raw.githubusercontent.com URLs represent? https://stackoverflow.com/questions/39065921/what-do-raw-githubusercontent-com-urls-represent
> The `raw.githubusercontent.com` domain is used to serve unprocessed versions of files stored in GitHub repositories. If you browse to a file on GitHub and then click the Raw link, that's where you'll go.

### Github相关第三方工具

#### gitbook

>http://blog.csdn.net/hk2291976/article/details/51173850
>https://www.jianshu.com/p/5d0b25cd9495

#### Travis CI

https://travis-ci.org/getting_started
>https://docs.travis-ci.com/user/language-specific/
>>https://docs.travis-ci.com/user/getting-started/
>>>https://docs.travis-ci.com/user/deployment/heroku/
>>>>https://www.heroku.com/

<持续集成服务 Travis CI 教程>
http://www.ruanyifeng.com/blog/2017/12/travis_ci_tutorial.html
>YAML 语言教程 http://www.ruanyifeng.com/blog/2016/07/yaml.html

使用Travis进行持续集成 https://www.liaoxuefeng.com/article/1083103562955136  -->  廖雪峰这个Travis教程跟阮一峰那个还是没法比，比较基本。

如何简单入门持续集成( Travis-CI ) https://github.com/nukc/how-to-use-travis-ci

<类似Travis CI 这种持续集成「自动编译测试」的网站有哪些？>
https://www.zhihu.com/question/42991087
https://github.com/blog/2463-github-welcomes-all-ci-tools

#### Codecov

Github装逼指南——Travis CI 和 Codecov
https://segmentfault.com/a/1190000004415437

#### Heroku

<<国内有没有类似heroku的云服务平台？>>
https://www.zhihu.com/question/19902966

#### 

https://david-dm.org/

#### gitter (https://gitter.im/)

<GitLab收购公共聊天软件Gitter>
http://www.infoq.com/cn/news/2017/03/gitlab-gitter-acquisition

#### Gerrit

易百教程 -- Gerrit概述
https://www.yiibai.com/gerrit/gerrit_overview.html

[原创]CI持续集成系统环境---部署gerrit环境完整记录
https://www.cnblogs.com/kevingrace/p/5624122.html

Gerrit代码Review入门实战
http://geek.csdn.net/news/detail/85681

#### [GitHub开发者](https://githuber.cn/)

- https://githuber.cn/stat
- https://githuber.cn/rank
- https://githuber.cn/search
- http://blog.githuber.cn/

### GitLab相关

GitLab安装、使用教程（Docker版） - 慕课网的文章 - 知乎
https://zhuanlan.zhihu.com/p/33592623

Git使用教程,最详细，最傻瓜，最浅显，真正手把手教 - 慕课网的文章 - 知乎
https://zhuanlan.zhihu.com/p/30044692

GitLab发布Web IDE 在Web端为你提供集成开发体验 - Open Source 开源 - cnBeta.COM https://www.cnbeta.com/articles/soft/737313.htm
- https://about.gitlab.com/2018/06/15/introducing-gitlab-s-integrated-development-environment/
- https://docs.gitlab.com/ee/user/project/web_ide/
```
试了一下，可以在线同时commit多个change，并且可以先stage然后选择性commit部分change。无敌，就是这么寂寞！
这么一比的话，Github你的心不会痛嘛？！
```

https://gitlab.com/help/ci/quick_start/README

### 自建git服务相关

#### gitea

 Git with a cup of tea, painless self-hosted git service https://github.com/go-gitea/gitea
 > Gitea - Git with a cup of tea -- A painless self-hosted Git service. https://gitea.io

