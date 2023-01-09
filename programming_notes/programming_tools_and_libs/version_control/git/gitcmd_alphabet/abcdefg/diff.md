
# 官方

git-diff - Show changes between commits, commit and working tree, etc https://git-scm.com/docs/git-diff

# 参数解析

## `--stat` `--name-stat`
>> 【[:star:][`*`]】 //notes：之所以想到这个参数是因为可以先用 `git diff --stat` 看看（`工作区`相比`版本库`）有哪些文件改变了；然后用 `git diff -- file` ***只看某个想看的文件的改动*** —— 否则，如果直接 `git diff` 基本都要找啊找半天。
>>> 此外，加上 `--cached` 就是对比`暂存区`和`版本库`里文件的区别，无需赘述了，命令就是：`git diff --cached --stat` 和 `git diff --cached -- file`。

Git如何获得两个版本间所有变更的文件列表 https://segmentfault.com/q/1010000000133613
- > `git diff --name-status HEAD~2 HEAD~3`
- > `git diff commit-SHA1 commit-SHA2 --stat`

Can I make 'git diff' only display the line numbers AND changed file names? https://stackoverflow.com/questions/9848347/can-i-make-git-diff-only-display-the-line-numbers-and-changed-file-names
- > `git diff --stat`
- > `git diff --name-only`

# 其他帖子

git 比较同一文件的不同的两个版本之间的差异 https://segmentfault.com/q/1010000005974787
- > `git diff commit_id1 commit_id2 -- index.html`

Git diff Command – How to Compare Changes in Your Code https://www.freecodecamp.org/news/git-diff-command/
- > **Understanding `git diff`'s Results – Line by Line**
- > **4 Diff Comparisons You Need to Know**
  * > You can run the below commands to compare the changes for specific file:
    ```console
    git diff HEAD <file_name>
    git diff <file_name>
    git diff --staged <file_name> or  git diff --cached <file_name>,
    git diff <branch_name1> <branch_name2> <file_name>
    git diff <commit_hash> <commit_hash> <file_name>
    ```

# 个人实战

## 当仓库是干净状态时，`git diff HEAD^ HEAD` = `git diff HEAD^`。

```sh
# 我们以 Openssl 最新的 commit 为例来说明（很快这个“最新”就会变了，不过不影响，因为这里主要是展示 git diff 的参数）

$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
$ 
$ git log
commit a227ff336fc934b4a52c4659ae423dfa10efd5f3 (HEAD -> master, origin/master, origin/HEAD)
Author: Matt Caswell <matt@openssl.org>
Date:   Fri May 14 15:33:40 2021 +0100
...
...
...

$
$ git diff --stat HEAD^ HEAD
 crypto/provider_child.c     | 2 +-
 include/internal/cryptlib.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
$ 
$ git diff --stat HEAD^     
 crypto/provider_child.c     | 2 +-
 include/internal/cryptlib.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
$ 
$ git diff --stat HEAD HEAD^
 crypto/provider_child.c     | 2 +-
 include/internal/cryptlib.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
$
```
