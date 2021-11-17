
# 官方

git-pull Documentation - Git https://git-scm.com/docs/git-pull
- > SYNOPSIS
  * > `git pull [<options>] [<repository> [<refspec>…​]]`
- > Incorporates changes from a remote repository into the current branch. In its default mode, `git pull` is shorthand for `git fetch` followed by `git merge FETCH_HEAD`.
  >> //notes：有个现象是：就算pull的时候明确指定了远端的分支（比如 `git pull origin dev`）但是还是有可能两个本地分支都变了（一个分支，比如 `branch1` 会生成一个merge commit；pull语句参数里被拉的远端分支，这里当然就是`dev`了，会更新到最新——但是这个情况也不是必然发生的），这个还得再看看，貌似不同的git版本表现也不一样。
- > Default values for `<repository>` and `<branch>` are read from the "remote" and "merge" configuration for the current branch as set by [git-branch[1]]() `--track`.

# 参数解析

## `--rebase`

git pull --rebase的正确使用 https://juejin.im/post/5d3685146fb9a07ed064f11b

When should I use git pull --rebase? https://stackoverflow.com/questions/2472254/when-should-i-use-git-pull-rebase

聊下git pull --rebase https://www.cnblogs.com/wangiqngpei557/p/6056624.html

# 其他帖子

git pull https://www.atlassian.com/git/tutorials/syncing/git-pull

Git pull created merge commit that is not needed https://stackoverflow.com/questions/51447580/git-pull-created-merge-commit-that-is-not-needed

# 个人实战
