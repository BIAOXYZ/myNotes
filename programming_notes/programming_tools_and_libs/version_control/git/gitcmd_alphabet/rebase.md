
# 官方

# 其他帖子

<<Git Community Book 中文版 - rebase>> http://gitbook.liuhui998.com/4_2.html

<<git merge, rebase和*(no branch)>> http://blog.csdn.net/xiaoputao0903/article/details/23995055

【[:star:][`*`]】 Rebase 代替合并 https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/rebase || Rebase as an Alternative to Merge https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/rebase
- > Rebase 整合
  * > 现在就让我们一步一步地了解一下 rebase 操作吧！仍然来使用前面的例子：我们想合并分支 B 到 分支 A 中，但是这次使用 rebase 操作。
    >> ![](https://www.git-tower.com/learn/media/pages/git/ebook/cn/command-line/advanced-topics/rebase/439759406-1588165681/starting-situation-rebase.gif)
  * > 使用下面这个非常的简单的命令：`$ git rebase branch-B`
  * > 首先，Git 会 “撤销” 所有在分支 A 上的那些在与分支 B 的共同提交之后发生的提交。当然，Git 不会真的放弃这些提交，其实你可以把这些撤销的提交想像成 “被暂时地存储” 到另外的一个地方去了。
    >> ![](https://www.git-tower.com/learn/media/pages/git/ebook/cn/command-line/advanced-topics/rebase/-982980492-1588165681/rebase-step-1.gif)
  * > 接下来它会整合那些在分支 B（这个我们想要整合的分支）上的还未整合的提交到分支 A 中。在这个时间点，这两个分支看起来会是一模一样的。
    >> ![](https://www.git-tower.com/learn/media/pages/git/ebook/cn/command-line/advanced-topics/rebase/-2100784476-1588165681/rebase-step-2.gif)
  * > 最后，那些在分支 A 的新的提交（也就是第一步中自动撤销掉的那些提交）会被重新应用到这个分支上，但是在不同的位置上，在那些从分支 B 被整合过来的提交之后，它们就被 re-based 了。整个项目开发轨迹看起来就像发生在一条直线上。相对于一个合并提交，rebase 包括了所有的组合变化，最原始的提交结构会被保留下来。
    >> ![](https://www.git-tower.com/learn/media/pages/git/ebook/cn/command-line/advanced-topics/rebase/-1079461100-1588165681/rebase-step-3.gif)
- > Rebase 存在的陷阱
  * > 当然，使用 rebase 操作不会是永远一帆风顺的。很有可能会搬起石头砸自己的脚，因此你不能忽视一个重要的事实：**rebase 会改写历史记录**。
  * > 你有可能已经注意到了，在被 rebase 操作之后的版本中，提交 “`C3*`” 存在一个新添加的星号。这是因为，尽管这个提交的内容和 “`C3`” 完全一样，但是它实际上是一个不同的提交。这样做的原因是，它现在有一个新的源提交 `C4`（在最初创建 `C3` 时的源提交是 `C1`）。
  * > 如果还仅仅只是操作那些尚未发布的提交，重写历史记录本身也没有什么很大的问题。但是如果你重写了已经发布到公共服务器上的提交历史，这样做就非常危险了。其他的开发人员可能这时已经在最原始的提交 `C3` 上开始工作，并使它成为了一些新提交中不可或缺的部分，而现在你却把 `C3` 的改动设置到了另一个时间点（就是那个新的 `C3*`）。除此之外，通过rebase 操作，这个原始的 `C3` 还被删除掉了，这将是非常可怕的……
  * > ***因此你应该只使用 rebase 来清理你的本地工作，千万不要尝试着对那些已经被发布的提交进行这个操作***。

git rebase https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

Merging vs. Rebasing https://www.atlassian.com/git/tutorials/merging-vs-rebasing

git rebase in depth https://git-rebase.io/

# 个人实战

## rebase实战1

**--------------------------------------------------**
`#` ***git rebase 个人实战：开始***
**--------------------------------------------------**

```sh
# git rebase 实验过程

# 1.以某个分支如basebranch为起点创建并切换两个一模一样的分支111,222:
git checkout -b 111
git checkout -b 222

# 2.在这两个分支上分别做两次不同的修改和提交(为了简单起见，这两次不会有冲突，后续无需处理冲突):
git commit -m 111_1
git commit -m 111_2
# 此时111分支的路线是：basebranch <-- 111_1 <-- 111_2

git commit -m 222_1
git commit -m 222_2
# 此时222分支的路线是：basebranch <-- 222_1 <-- 222_2

# 3.从111创建一模一样的分支1111，从222创建一模一样的分支2222
git checkout -b 1111
git checkout -b 2222

# 4.在分支2222上merge分支1111，在分支222上rebase分支111，观察log图
# 4.1.切换到2222，并执行merge
git checkout 2222
git merge 1111
# 4.2.切换到222，并执行rebase
git checkout 222
git rebase 111

提示如下：
First, rewinding head to replay your work on top of it...
Applying: 222_1
Applying: 222_2

# 4.3.分别在分支2222和分支222上查看log图
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
> 注意看commit id，对比上一个，没有发生变化的是`111_1`的`a18e755`和`111_2`的`5783c0c`。这其实就是“rebase”的含义所在：**把当前分支（分支222）的base从原来的`fe5da30`给re-base到另一个分支（分支111）的最新的commit（`111_2`对应的`5783c0c`）后面**。就算没有冲突，`222_1`和`222_2`因为其父提交已经变了，所以肯定commit id也会变；如果有冲突，那连内容也会变。
>> 所以如果假设master分支是分支222，feature分支是分支111。本例相当于切换到master分支上去rebase feature，这个rebase操作完成后会把master的记录都改写（当然是指非fast forward的情况），这种肯定是不行的。常用的情况是：本地正在feature分支上开发，远程master分支上有别人提新的commit，把这些commit拉下来后，***在本地feature分支上去rebase master***。

**--------------------------------------------------**
`#` ***git rebase 个人实战：结束***
**--------------------------------------------------**

## rebase实战2（真实开发过程，且有冲突时）

```sh
# 大前提：
# - 假定我们基于之前master的最新commit 0d48d07（也就是pull request 20对应的合入）拉出了一个分支devsubs进行开发。
# - 后来在我们的开发分支devsubs上有两个新的commit，在master上有四个新commit。


# //首先切换到master分支，在fast-forward方式下拉下最新的代码，并记录一下当前的git log情况。
[root@lolls-inf hybridapp-operator]# git checkout master
Switched to branch 'master'
[root@lolls-inf hybridapp-operator]# git pull origin master:master
remote: Enumerating objects: 49, done.
remote: Counting objects: 100% (49/49), done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 59 (delta 31), reused 38 (delta 29), pack-reused 10
Unpacking objects: 100% (59/59), done.
From github.ibm.com:IBMPrivateCloud/hybridapp-operator
   0d48d07..e7be3d1  master     -> master
 * [new tag]         unreleased-master -> unreleased-master
Warning: fetch updated the current branch head.
Warning: fast-forwarding your working tree from
Warning: commit 0d48d076d3e4fb8451029e8e5d3ebf0c4f6d4c2d.
Already up-to-date.
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# git log --oneline
e7be3d1 Bugfix-Issue8898: now when sync in Deployable resource, the prefix of… (#31)
591ae97 Update olm catalog (#29)
cdb6594 generate role/roleb for cluster (#23)
fa71c12 Delete release-version.txt (#22)
0d48d07 install crds in image (#20)
2b97d24 update build files with test and lint targets (#19)
29df110 merge release-2.0 (#18)
6ade746 Finish codes and UT test for Deployable resource. (#15)
a4da398 Rename and add ham-deploy controller into it (#12)
96f60ad Finish codes and UT test for Channel resource. (#10)
f894e45 upgrade operator sdk to 0.17 (#6)
4da5d92 Update files related to quick start scenario (#5)
73b6d94 unit testing both placementrule controllers (#4)
dbf56a8 feature ready (#3)
c2bc1ce fix typo in makefile for image (#2)
1bd0288 Init (#1)
cbea428 Initial commit
[root@lolls-inf hybridapp-operator]#


# //切换到devsubs分支，也记录下当前的提交情况。
[root@lolls-inf hybridapp-operator]# git checkout devsubs
Switched to branch 'devsubs'
[root@lolls-inf hybridapp-operator]# git log --oneline
85b99a5 Add UT test for rhsubscription; Fix potential null pointer problem in rhsusbscription controller.
94d5a80 Finish code for Subscription resource.
0d48d07 install crds in image (#20)
2b97d24 update build files with test and lint targets (#19)
29df110 merge release-2.0 (#18)
6ade746 Finish codes and UT test for Deployable resource. (#15)
a4da398 Rename and add ham-deploy controller into it (#12)
96f60ad Finish codes and UT test for Channel resource. (#10)
f894e45 upgrade operator sdk to 0.17 (#6)
4da5d92 Update files related to quick start scenario (#5)
73b6d94 unit testing both placementrule controllers (#4)
dbf56a8 feature ready (#3)
c2bc1ce fix typo in makefile for image (#2)
1bd0288 Init (#1)
cbea428 Initial commit
[root@lolls-inf hybridapp-operator]#


# //备份当前开发分支devsubs以防万一（这里傻了，直接不带-b就完了，省得后面还得切来切去）。
[root@lolls-inf hybridapp-operator]# git checkout -b devsubs-finish-rhsubs-uttest
Switched to a new branch 'devsubs-finish-rhsubs-uttest'
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# git diff devsubs-finish-rhsubs-uttest devsubs
[root@lolls-inf hybridapp-operator]#


# //切换到devsubs分支，并执行rebase master的操作。
[root@lolls-inf hybridapp-operator]# git checkout devsubs
Switched to branch 'devsubs'
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# git rebase master
First, rewinding head to replay your work on top of it...
Applying: Finish code for Subscription resource.
Using index info to reconstruct a base tree...
M       pkg/apis/addtoscheme_all.go
Falling back to patching base and 3-way merge...
Auto-merging pkg/apis/addtoscheme_all.go
CONFLICT (content): Merge conflict in pkg/apis/addtoscheme_all.go
Failed to merge in the changes.
Patch failed at 0001 Finish code for Subscription resource.
The copy of the patch that failed is found in:
   /root/cp4mcmrelated/gitrepo/hybridapp-operator/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

[root@lolls-inf hybridapp-operator]#

## //rebase提示冲突，有三种解决办法，后两种肯定不太好，还是自己处理冲突吧。
[root@lolls-inf hybridapp-operator]# git status
# HEAD detached at e7be3d1
# You are currently rebasing branch 'devsubs' on 'e7be3d1'.
#   (fix conflicts and then run "git rebase --continue")
#   (use "git rebase --skip" to skip this patch)
#   (use "git rebase --abort" to check out the original branch)
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   deploy/crds/compatibility/app.ibm.com_subscriptions_crd.yaml
#       new file:   deploy/crds/compatibility/apps.open-cluster-management.io_subscriptions_crd.yaml
#       modified:   go.mod
#       modified:   go.sum
#       new file:   pkg/apis/app/v1alpha1/subscription_types.go
#       modified:   pkg/apis/app/v1alpha1/zz_generated.deepcopy.go
#       new file:   pkg/controller/add_subscription.go
#       new file:   pkg/controller/ibmsubscription/subscription_controller.go
#       new file:   pkg/controller/rhsubscription/subscription_controller.go
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#       both modified:      pkg/apis/addtoscheme_all.go
#
[root@lolls-inf hybridapp-operator]#

## //首先先试试直接继续会怎么样，结果发现如果不处理冲突想直接continue是不行的。。。
[root@lolls-inf hybridapp-operator]# git rebase --continue
pkg/apis/addtoscheme_all.go: needs merge
You must edit all merge conflicts and then
mark them as resolved using git add
[root@lolls-inf hybridapp-operator]#

## //看一下branch，发现现在处在一个游离的分支上。
[root@lolls-inf hybridapp-operator]# git branch
* (no branch, rebasing devsubs)
  dev
  devsubs
  devsubs-finish-rhsubs-uttest
  feature-Deployable
  master
[root@lolls-inf hybridapp-operator]#

## //处理下冲突（其实我是用vscode改的，这里这个vi语句主要是为了表示冲突处理这个环节确实存在）。
[root@lolls-inf hybridapp-operator]# vi pkg/apis/addtoscheme_all.go
[root@lolls-inf hybridapp-operator]#

## //看看当前状态还是没变啊。
[root@lolls-inf hybridapp-operator]# git status
# HEAD detached at e7be3d1
# You are currently rebasing branch 'devsubs' on 'e7be3d1'.
#   (fix conflicts and then run "git rebase --continue")
#   (use "git rebase --skip" to skip this patch)
#   (use "git rebase --abort" to check out the original branch)
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   deploy/crds/compatibility/app.ibm.com_subscriptions_crd.yaml
#       new file:   deploy/crds/compatibility/apps.open-cluster-management.io_subscriptions_crd.yaml
#       modified:   go.mod
#       modified:   go.sum
#       new file:   pkg/apis/app/v1alpha1/subscription_types.go
#       modified:   pkg/apis/app/v1alpha1/zz_generated.deepcopy.go
#       new file:   pkg/controller/add_subscription.go
#       new file:   pkg/controller/ibmsubscription/subscription_controller.go
#       new file:   pkg/controller/rhsubscription/subscription_controller.go
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#       both modified:      pkg/apis/addtoscheme_all.go
#
[root@lolls-inf hybridapp-operator]#

## //原来是git add后（猜测是没有“Unmerged paths”）才算冲突处理完毕，可以conntinue了。
[root@lolls-inf hybridapp-operator]# git add pkg/apis/addtoscheme_all.go
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# git status
# HEAD detached at e7be3d1
# You are currently rebasing branch 'devsubs' on 'e7be3d1'.
#   (all conflicts fixed: run "git rebase --continue")
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   deploy/crds/compatibility/app.ibm.com_subscriptions_crd.yaml
#       new file:   deploy/crds/compatibility/apps.open-cluster-management.io_subscriptions_crd.yaml
#       modified:   go.mod
#       modified:   go.sum
#       modified:   pkg/apis/addtoscheme_all.go
#       new file:   pkg/apis/app/v1alpha1/subscription_types.go
#       modified:   pkg/apis/app/v1alpha1/zz_generated.deepcopy.go
#       new file:   pkg/controller/add_subscription.go
#       new file:   pkg/controller/ibmsubscription/subscription_controller.go
#       new file:   pkg/controller/rhsubscription/subscription_controller.go
#
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# git rebase --continue
Applying: Finish code for Subscription resource.
Applying: Add UT test for rhsubscription; Fix potential null pointer problem in rhsusbscription controller.
[root@lolls-inf hybridapp-operator]#

## //上面提示rebase已成功，然后看下状态，发现完全是clean的。
[root@lolls-inf hybridapp-operator]# git status
# On branch devsubs
nothing to commit, working directory clean
[root@lolls-inf hybridapp-operator]#

## //对比前面两个提交记录，就能看出来端倪了：
## - 从最后的公共commit 0d48d07开始，master的四个新commit原封不动的过来了（四个commit的id都没变）。
## - 但是本地开发分支devsubs上的两个commit的commit id都变了（尽管commit message没变）。
[root@lolls-inf hybridapp-operator]# git log --oneline
0f91070 Add UT test for rhsubscription; Fix potential null pointer problem in rhsusbscription controller.
09e8b12 Finish code for Subscription resource.
e7be3d1 Bugfix-Issue8898: now when sync in Deployable resource, the prefix of… (#31)
591ae97 Update olm catalog (#29)
cdb6594 generate role/roleb for cluster (#23)
fa71c12 Delete release-version.txt (#22)
0d48d07 install crds in image (#20)
2b97d24 update build files with test and lint targets (#19)
29df110 merge release-2.0 (#18)
6ade746 Finish codes and UT test for Deployable resource. (#15)
a4da398 Rename and add ham-deploy controller into it (#12)
96f60ad Finish codes and UT test for Channel resource. (#10)
f894e45 upgrade operator sdk to 0.17 (#6)
4da5d92 Update files related to quick start scenario (#5)
73b6d94 unit testing both placementrule controllers (#4)
dbf56a8 feature ready (#3)
c2bc1ce fix typo in makefile for image (#2)
1bd0288 Init (#1)
cbea428 Initial commit
[root@lolls-inf hybridapp-operator]#

## //branch当然应该从游离状态变为当前的开发分支devsubs。
[root@lolls-inf hybridapp-operator]# git branch
  dev
* devsubs
  devsubs-finish-rhsubs-uttest
  feature-Deployable
  master
[root@lolls-inf hybridapp-operator]#
[root@lolls-inf hybridapp-operator]# make test
// 成功，输出就省略了。
```

# rebase妙用：利用`rebase -i`彻底摘除某个commit

git删除中间某次提交 https://www.cnblogs.com/qiqi715/p/11540999.html

Git 删除具体某个提交commit的方法 https://www.jianshu.com/p/2fd2467c27bb

## 删除完后github还会有缓存的view，需要联系他们清除。

Please help to remove a commit from Github cached #988968 https://support.github.com/ticket/personal/0/988968

从仓库中删除敏感数据 https://docs.github.com/cn/github/authenticating-to-github/removing-sensitive-data-from-a-repository || Removing sensitive data from a repository
https://docs.github.com/en/github/authenticating-to-github/removing-sensitive-data-from-a-repository
- > You can't do anything about existing clones or forks of your repository, but you can permanently remove cached views and references to the sensitive data in pull requests on GitHub by contacting GitHub Support or GitHub Premium Support.

创建个人访问令牌 https://docs.github.com/cn/github/authenticating-to-github/creating-a-personal-access-token

### 20200706

Please help to remove a commit from Github cached #1222313 https://support.github.com/ticket/personal/0/1222313
- https://github.com/BIAOXYZ/myNotes/commit/b4d748cf901a7b236820fd970f9795ace974c079
