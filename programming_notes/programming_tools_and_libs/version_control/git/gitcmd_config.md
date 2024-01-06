
# git config 命令

1.6 起步 - 初次运行 Git 前的配置 https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%88%9D%E6%AC%A1%E8%BF%90%E8%A1%8C-Git-%E5%89%8D%E7%9A%84%E9%85%8D%E7%BD%AE
- > 你可以通过以下命令查看所有的配置以及它们所在的文件：
  ```sh
  $ git config --list --show-origin
  ```
- > **检查配置信息**
  * > 如果想要检查你的配置，可以使用 `git config --list` 命令来列出所有 Git 当时能找到的配置。
  * > 你可能会看到重复的变量名，因为 Git 会从不同的文件中读取同一个配置（例如：`/etc/gitconfig` 与 `~/.gitconfig`）。 这种情况下，Git 会使用它找到的每一个变量的最后一个配置。
  * > 你可以通过输入 `git config <key>` 来检查 Git 的某一项配置
    ```sh
    $ git config user.name
    John Doe
    ```
  * > Note: 由于 Git 会从多个文件中读取同一配置变量的不同值，因此你可能会在其中看到意料之外的值而不知道为什么。 此时，你可以查询 Git 中该变量的**原始**值，***它会告诉你哪一个配置文件最后设置了该值***：
    ```sh
    $ git config --show-origin rerere.autoUpdate
    file:/home/johndoe/.gitconfig	false
    ```

git config https://www.atlassian.com/zh/git/tutorials/setting-up-a-repository/git-config

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

## 自定义各种配置

~~`.1 自定义 Git - 配置 Git` https://git-scm.com/book/zh/v1/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-%E9%85%8D%E7%BD%AE-Git~~ --> `8.1 自定义 Git - 配置 Git` https://git-scm.com/book/zh/v2/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-%E9%85%8D%E7%BD%AE-Git
- > 首先，快速回忆下：Git 使用一系列配置文件来保存你自定义的行为。 它首先会查找系统级的 `/etc/gitconfig` 文件，该文件含有系统里每位用户及他们所拥有的仓库的配置值。 如果你传递 `--system` 选项给 `git config`，它就会读写该文件。
- > 接下来 Git 会查找每个用户的 `~/.gitconfig` 文件（或者 `~/.config/git/config` 文件）。 你可以传递 `--global` 选项让 Git 读写该文件。
- > 最后 Git 会查找你正在操作的仓库所对应的 Git 目录下的配置文件（`.git/config`）。 这个文件中的值只对该仓库有效，它对应于向 `git config` 传递 `--local` 选项。
- > 以上三个层次中每层的配置（系统、全局、本地）都会覆盖掉上一层次的配置，所以 `.git/config` 中的值会覆盖掉 `/etc/gitconfig` 中所对应的值。

### Windows和Linux下配置换行符`core.autocrlf`

```
core.autocrlf

假如你正在Windows上写程序，又或者你正在和其他人合作，他们在Windows上编程，而你却在其他系统上，在这些情况下，
你可能会遇到行尾结束符问题。这是因为Windows使用回车和换行两个字符来结束一行，而Mac和Linux只使用换行一个字符。
虽然这是小问题，但它会极大地扰乱跨平台协作。

Git可以在你提交时自动地把行结束符CRLF转换成LF，而在签出代码时把LF转换成CRLF。用core.autocrlf来打开此项功能，
如果是在Windows系统上，把它设置成true，这样当签出代码时，LF会被转换成CRLF：
$ git config --global core.autocrlf true

Linux或Mac系统使用LF作为行结束符，因此你不想 Git 在签出文件时进行自动的转换；当一个以CRLF为行结束符的文件不
小心被引入时你肯定想进行修正，把core.autocrlf设置成input来告诉 Git 在提交时把CRLF转换成LF，签出时不转换：
$ git config --global core.autocrlf input
这样会在Windows系统上的签出文件中保留CRLF，会在Mac和Linux系统上，包括仓库中保留LF。

如果你是Windows程序员，且正在开发仅运行在Windows上的项目，可以设置false取消此功能，把回车符记录在库中：
$ git config --global core.autocrlf false
```

### git彩色显示分支名和命令自动补全

```shell
之前在华为的时候用的是这个，忘了是哪儿查到的了已经（注意，这个应该放在`/etc/profile`里，放`~/.bashrc`有时候会不生效）：

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

.7 Git 基础 - 技巧和窍门 https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%8A%80%E5%B7%A7%E5%92%8C%E7%AA%8D%E9%97%A8
1. > 如果你用的是 Bash shell，可以试试看 Git 提供的自动补全脚本。下载 Git 的源代码，进入 `contrib/completion` 目录，会看到一个 `git-completion.bash` 文件。将此文件复制到你自己的用户主目录中（译注：按照下面的示例，还应改名加上点：`cp git-completion.bash ~/.git-completion.bash`），并把下面一行内容添加到你的 `.bashrc` 文件中：
   >> `source ~/.git-completion.bash`
2. > 也可以为系统上所有用户都设置默认使用此脚本。Mac 上将此脚本复制到 `/opt/local/etc/bash_completion.d` 目录中，Linux 上则复制到 `/etc/bash_completion.d/` 目录中。这两处目录中的脚本，都会在 Bash 启动时自动加载。

>>> 注：实际上第二点不太准确：一、根据不同的linux发行版，`bash-completion`自动完成功能的目录可能不同，所以需要视情况而定。二、git对应的自动补全命令脚本/文件的名字也可能不同，有的叫`git-completion.bash`，有的就叫`git`。三、即使正确的自动补全脚本/文件放在正确的`bash-completion`自动完成目录里了，也不一定会自动执行啊，所以最好在自己的`.bashrc`文件里加上下面[这段代码](https://stackoverflow.com/questions/11173447/how-can-i-set-up-autocompletion-for-git-commands)：
```
for file in /etc/bash_completion.d/* ; do
    source "$file"
done
```

### git彩色显示分支名2

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
```sh
# 来了，主要改动其实就是缩了一个空格，然后用大括号包了一层。。。
PS1="{\u@\h \[\033[0;36m\]\W\[\033[0m\]\[\033[0;32m\]$(git-branch-prompt)\[\033[0m\]}\$ "

# 另外一般CentOS 7原版的PS1是这样的：
[root@lolls-inf ~]# echo $PS1
[\u@\h \W]\$
```

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


> 实战过程。注意：1.必须先建立一个新的remote repo，叫all或者both或者随便的名字都行，才能使用`git remote set-url --add <仓库名> <新的push仓库的地址>`来添加新的只上传的仓库。2.如果不带`--add`参数则是修改原来仓库的地址，也就是从仓库1改到仓库2。
```sh
LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote -v
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (fetch)
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (push)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (fetch)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (push)
origin  git@github.com:BIAOXYZ/myNotes.git (fetch)
origin  git@github.com:BIAOXYZ/myNotes.git (push)

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote set-url --add all git@github.com:BIAOXYZ/myNotes.git
fatal: No such remote 'all'

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote add all git@github.com:BIAOXYZ/myNotes.git

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote -v
all     git@github.com:BIAOXYZ/myNotes.git (fetch)
all     git@github.com:BIAOXYZ/myNotes.git (push)
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (fetch)
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (push)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (fetch)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (push)
origin  git@github.com:BIAOXYZ/myNotes.git (fetch)
origin  git@github.com:BIAOXYZ/myNotes.git (push)

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote set-url --add all git@gitlab.com:BIAOXYZ/myNotes.git

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote set-url --add all git@bitbucket.org:BIAOXYZ/mynotes.git

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git remote -v
all     git@github.com:BIAOXYZ/myNotes.git (fetch)
all     git@github.com:BIAOXYZ/myNotes.git (push)
all     git@gitlab.com:BIAOXYZ/myNotes.git (push)
all     git@bitbucket.org:BIAOXYZ/mynotes.git (push)
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (fetch)
bit     git@bitbucket.org:BIAOXYZ/mynotes.git (push)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (fetch)
lab     git@gitlab.com:BIAOXYZ/myNotes.git (push)
origin  git@github.com:BIAOXYZ/myNotes.git (fetch)
origin  git@github.com:BIAOXYZ/myNotes.git (push)

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$ git push all master
Everything up-to-date
Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 4 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (10/10), 1.76 KiB | 900.00 KiB/s, done.
Total 10 (delta 8), reused 0 (delta 0)
To gitlab.com:BIAOXYZ/myNotes.git
   228b35d..ccbfd63  master -> master
Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 4 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (10/10), 1.76 KiB | 900.00 KiB/s, done.
Total 10 (delta 8), reused 0 (delta 0)
To bitbucket.org:BIAOXYZ/mynotes.git
   228b35d..ccbfd63  master -> master

LL@daxian-pc MINGW64 /e/githubrep/myNotes (master)
$
```

```
# 添加的远端也可以是带账号密码的url的形式，过程如下（过程中密码都用{MYPASSWORD}代替了，实际中密码不用大括号包住）：

// 查看一下当前的远端仓库信息，同时方便复制粘贴远端仓库地址。
AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote -v
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (fetch)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (fetch)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (push)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)

// 添加一个新的远端仓库，取名为all（别的名字当然也可以）。最好用当前默认的push远端，一般都是origin。
AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote add all https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git

AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote -v
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (fetch)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (fetch)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (push)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)

// 后面就不再重复了，总之就是不断地用git remote set-url --add往新的远端仓库all里添加已有远端仓库的地址。
AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote set-url --add all https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git

AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote -v
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)
all     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (fetch)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (fetch)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (push)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)

AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote set-url --add all https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git

AzureAD+LiangLiu@DESKTOP-5LVLGG9 MINGW64 /e/githubrepo/paperRelatedRepository (master)
$ git remote -v
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
all     https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)
all     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
all     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (push)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (fetch)
bit     https://BIAOXYZ:{MYPASSWORD}@bitbucket.org/BIAOXYZ/paperrelatedrepository.git (push)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (fetch)
lab     https://biaoxyz:{MYPASSWORD}@gitlab.com/BIAOXYZ/paperRelatedRepository.git (push)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (fetch)
origin  https://biaoxyz:{MYPASSWORD}@github.com/BIAOXYZ/paperRelatedRepository.git (push)

```

***后来补充***：Github将会自`2021年8月31日`起停止支持`account/passwords`方式的访问，坑货。。。但是我理解应该还可以用`账户名 + access token`的方式，所以后面会补充一个。
- Token authentication requirements for Git operations https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/

```sh
# 参考链接：
# https://stackoverflow.com/questions/68193573/git-push-returns-missing-or-invalid-credentials-code-econnrefused-remote-r/68195586#68195586

# 1. 首先新建一个源 all，并且设置为 github 对应的仓库。
$ git remote add all https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git
$ git remote -v
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)

# 2. 给源 all 添加 gitlab 对应的仓库。
$ export MYPASSWORD=<这里填上你的密码>
$ echo $MYPASSWORD
$ git remote set-url --add all https://biaoxyz:${MYPASSWORD}@gitlab.com/BIAOXYZ/variousCodes.git
$ git remote -v                                                                                 
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)
all     https://biaoxyz:<MYPASSWORD>@gitlab.com/BIAOXYZ/variousCodes.git (push)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)
$ git push all
...
...

# 3. 给源 all 添加 bitbucket 对应的仓库
# （bitbucket不能用登陆密码了，于是去生成了一个token，但是还是有问题，最终还是回到最原始的 ssh key 的形式了）。
$ git remote set-url --add all git@bitbucket.org:biaoxyz/variousCodes.git
$ git remote -v                                                          
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
all     https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)
all     https://biaoxyz:<MYPASSWORD>@gitlab.com/BIAOXYZ/variousCodes.git (push)
all     git@bitbucket.org:biaoxyz/variousCodes.git (push)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (fetch)
origin  https://<YOUR_GITHUB_ACCESS_TOKEN>@github.com/BIAOXYZ/variousCodes.git (push)
$ git push all
...
...
```

----------------------------------------------------------------------------------------------------

### git拉取远程分支

git 拉取远程指定分支 pull本地不存在的分支 https://www.cnblogs.com/hamsterPP/p/6810831.html
```console
当我想从远程仓库里拉取一条本地不存在的分支时：
    git checkout -b 本地分支名 origin/远程分支名
这个将会自动创建一个新的本地分支，并与指定的远程分支关联起来。

如果出现提示：
fatal: Cannot update paths and switch to branch 'dev2' at the same time.
Did you intend to checkout 'origin/dev2' which can not be resolved as commit?

表示拉取不成功。我们需要先执行
git fetch

然后再执行
    git checkout -b 本地分支名 origin/远程分支名
即可
```

Git如何拉取指定远程分支 https://www.jianshu.com/p/856ce249ed78
- > **方法一：直接获取**
  * > 在Git Bash中直接输入指令：`git clone -b dev 代码仓库地址` （dev是分支名称）
- > **方法二**
  * > 将远程分支拉到本地：`git fetch origin dev`（dev即分支名）
  * > 创建本地分支：`git checkout -b LocalDev origin/dev` (LocalDev 为本地分支名，dev为远程分支名)

git 拉取远程分支到本地 https://blog.csdn.net/carfge/article/details/79691360
```
4、把远程分支拉到本地
git fetch origin dev（dev为远程仓库的分支名）

5、在本地创建分支dev并切换到该分支
git checkout -b dev(本地分支名称) origin/dev(远程分支名称)
```

怎么用git clone 远程的所有分支 https://www.jianshu.com/p/0fe715a7fbb3
```git
或者使用-t参数，它默认会在本地建立一个和远程分支名字一样的分支
$ git checkout -t origin/feature
```
>> TODO：这个帖子里给了一个StackOverflow的链接，里面有命令，但是没试过。回来试吧。
>>> git 从远程仓库获取所有分支 https://blog.csdn.net/wu1169668869/article/details/83345633

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

Gitflow workflow https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow

### gitk

### git hooks

`8.3 自定义 Git - Git 钩子` https://git-scm.com/book/zh/v2/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-Git-%E9%92%A9%E5%AD%90 || `8.3 Customizing Git - Git Hooks` https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks

Git Hooks https://www.atlassian.com/git/tutorials/git-hooks

How To Use Git Hooks To Automate Development and Deployment Tasks https://www.digitalocean.com/community/tutorials/how-to-use-git-hooks-to-automate-development-and-deployment-tasks

用 Git 钩子进行简单自动部署 https://aotu.io/notes/2017/04/10/githooks/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# 待分类git配置

## url insteadOf

Go填坑之将Private仓库用作module依赖 https://segmentfault.com/a/1190000021127791
```console
可以通过命令git config ...的方式来配置。也可以像我这样，直接修改~/.gitconfig添加如下配置：

[url "git@github.com:"]
    insteadOf = https://github.com/
[url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/
```

go get results in 'terminal prompts disabled' error for github private repo https://stackoverflow.com/questions/32232655/go-get-results-in-terminal-prompts-disabled-error-for-github-private-repo

一招 git clone 加速 https://juejin.im/post/5cfe66406fb9a07edb393c56

## `git config pull.ff only`

How to deal with this git warning? “Pulling without specifying how to reconcile divergent branches is discouraged” https://stackoverflow.com/questions/62653114/how-to-deal-with-this-git-warning-pulling-without-specifying-how-to-reconcile
>> notes：应该是因为我是https方式clone了仓库，然后push的时候用了 `用户名+token` 的方式。导致pull代码的时候每次都提示。其实不改估计也没啥，但是还是改一下吧。
