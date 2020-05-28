
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

Merging vs. Rebasing https://www.atlassian.com/git/tutorials/merging-vs-rebasing

git rebase in depth https://git-rebase.io/

# 个人实战

**--------------------------------------------------**
`#` ***git rebase 个人实战：开始***
**--------------------------------------------------**

```sh
# git rebase 实验过程

# 1.以某个分支如basebranch为起点创建并切换两个一模一样的分支111,222:
git checkout -b 111
git checkout -b 222

# 2.在这两个分支上分别做两次不同的修改和提交(为了简单起见，这两次不会有冲突，后续无需merge):
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
> 注意看commit id，对比上一个，没有发生变化的是`111_1`的`a18e755`和`111_2`的`5783c0c`。这其实就是“rebase”的含义所在：**把当前分支（分支222）的base从原来的`fe5da30`给rebase到另一个分支（分支111）的最新的commit（`111_2`对应的`5783c0c`）后面**。就算没有冲突，`222_1`和`222_2`因为其父提交已经变了，所以肯定commit id也会变；如果有冲突，那连内容也会变。
>> 所以如果假设master分支是分支222，feature分支是分支111。本例相当于切换到master分支上去rebase feature，这个rebase操作完成后会把master的记录都改写（当然是指非fast forward的情况），这种肯定是不行的。常用的情况是：本地正在feature分支上开发，远程master分支上有别人提新的commit，把这些commit拉下来后，***在本地feature分支上去rebase master***。

**--------------------------------------------------**
`#` ***git rebase 个人实战：结束***
**--------------------------------------------------**
