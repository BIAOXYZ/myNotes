
# 官方

git-branch - List, create, or delete branches https://git-scm.com/docs/git-branch

# 参数解析

## `--set-upstream` 与 `--set-upstream-to`

`git push --set-upstream vs --set-upstream-to` https://stackoverflow.com/questions/45580960/git-push-set-upstream-vs-set-upstream-to
- https://stackoverflow.com/questions/45580960/git-push-set-upstream-vs-set-upstream-to/45582379#45582379
  * > This mixes up `git branch` and `git push`.
  * > The git branch command has both `--set-upstream` and `--set-upstream-to`, ***with the former deprecated*** in favor of the latter for the reason already given in [Nick's answer](https://stackoverflow.com/questions/45580960/git-push-set-upstream-vs-set-upstream-to/45581160#45581160).
  * > The `git push` command has only `-u` aka `--set-upstream`, ***which takes no argument***. It means that if the push succeeds, your local Git should set, as the upstream of a branch reference supplied as your source, the remote-tracking branch corresponding to the destination branch you got the other Git to set, which in many cases, your own Git has just now created in your repository because their Git has also just created their branch.
- https://stackoverflow.com/questions/45580960/git-push-set-upstream-vs-set-upstream-to/45581160#45581160

>> //notes：这个之前我也是混淆的，记得好像这个参数跟 `git branch` 和 `git push` 都有关。。。结果仔细查了下才发现了区别。参见上面stackoverflow的回答就知道了。
>>> 另外第二个回答虽然我没展开，但是里面是一个人贴了git这个软件的提交历史（跟`--set-upstream-to`参数引入相关的几个commit）。这里倒没有什么technique的部分，就是想到了套娃：用git管理git——在redhat下开发redhat；用gcc编译gcc（还有啥想想。。。）

# 其他帖子

# 个人实战
