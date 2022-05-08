
# git源码/原理

这才是真正的Git——Git内部原理揭秘！ - 腾讯技术工程的文章 - 知乎 https://zhuanlan.zhihu.com/p/96631135
> 感谢大家的喜欢，我是本文作者。上文提到的将Git可视化出来除了文中提到的文章外，这里补充一个工具 http://onlywei.github.io/explain-git-with-d3/#commit 了解了基础概念之后，再来看这些可视化就很容易将其内化成自己的知识。
>> notes：这个作者回复的git可视化工具不错，原地址为：
>>> Use D3 to visualize simple git branching operations. https://github.com/onlywei/explain-git-with-d3 || http://onlywei.github.io/explain-git-with-d3/

Git内部原理解析 https://mp.weixin.qq.com/s/NL2Uc0PLn3UgcCEryy5KuA

谈谈 Git 存储原理及相关实现 https://mp.weixin.qq.com/s/x5PHNn87OYCSpYE_hb8I2A

git为什么文件换名后会丢失跟踪记录？ - 知乎 https://www.zhihu.com/question/531483642
- git为什么文件换名后会丢失跟踪记录？ - Cat Chen的回答 - 知乎 https://www.zhihu.com/question/531483642/answer/2474468812
- git为什么文件换名后会丢失跟踪记录？ - 知乎 https://www.zhihu.com/question/531483642/answer/2472733253

# git online

Resources to learn Git https://try.github.io/
- Learn Git Branching https://learngitbranching.js.org/ || https://github.com/pcottle/learnGitBranching

# git新闻

Git 15 周年：当年的分道扬镳，成就了今天的开源传奇 https://www.ithome.com/0/483/805.htm || https://www.cnbeta.com/articles/tech/970135.htm
- > “ 于是他在邮件列表里发了一封邮件，说自己写了一些代码，准备作为在找到更好的版本管理系统之前的过渡系统。我觉得这似乎是件挺有意思的事情，于是就把代码下载了下来，看了一下发现只有1244行。” 这是目前 Git 的主要维护者、Google 工程师 Junio C Hamano（滨野 纯）在一次采访中的描述。
  >
  > 是的，天才 Linus 只花了 10 天的时间，用 C 语言写了 1244 行代码，这就是如今火遍全球的分布式版本控制系统 Git 的雏形。Linus 把写好的代码发到 Linux 社区的邮件列表里，并邀请社区里的开发者一起来完善它。“ 在一周时间内发生了很多事，不过归纳起来就是 Linux 的内核开发者们听说 Linus 要用个“新玩意”来管理代码，如果那个‘新玩意’太难用的话大家都痛苦，还不如一起想办法把这个东西做好用点。” Hamano 就是收到邮件并首批参与 Git 项目的开发者之一。
  >
  > 据 Hamano 回忆，当时 Linus 考察了市面上所有的版本控制系统，没有一款让他满意的原因是它们都没有代码合并（merge）功能。“ 因为 Linus 只写 C 和 Shell，而 merge 的逻辑实在太复杂，所以他多次发邮件到邮件列表，说要是有人能够用脚本语言实现一个就好了。不过谁也没有上钩。就这么过了一个星期，一直关注邮件列表的我用 Perl 把 Linus 过去多次提到的 merge 算法实现并投到了邮件列表里。这是我第一次有一定规模地向开源项目贡献代码。然而，尽管我详细地写了将近 30 个测试用例以及各种分支条件下应该怎么处理的表格，6 个小时以后 Linus 提交到 master 分支的却是个截然不同的东西。据本人说是想到了更好的办法所以就这么着了。”
- > 对于 merge 功能，BitKeeper 的做法是在 work tree 里基本上只存放自己的文件，而 merge 不发生在这里。merge 时首先会创建一个临时文件夹，在里面展开 merge 结果，发生冲突时就在里面解决，然后提交 commit 并在 work tree 里展开，这样就算 merge 完成了。这个方法很好地解决了协同开发常常遇到的代码冲突问题。类似于把发生冲突的两人关进一个小黑屋，“决出胜负”后的胜利者再进入 work tree 。
  > 
  > 而 Linus 决定取消这个临时文件夹，直接在 work tree 上 merge 。具体来说，就是每次提交 commit 之前会生成记录本次提交内容的 index，而这个 index 遵循“三步合并”原则，比如我们有一个共同的版本，你在这个版本的基础上做了一些变更，我在这个版本的基础上做了另一些变更，然后将这两个差分 merge 起来。那么把原始版本、我修改的版本、你修改的版本分别作为 stage1，stage2，stage3 依次添加到 index 里，merge 就算完成了。例如最简单的情况，我和你都没有做出变更，那么 merge 的结果就是没有变更。如果我做了变更而你没有，那么最后得到的就是我变更以后的代码，反之亦然。另外还有一种特殊的情况，就是你和我都做了“相同”的变更。  
- > 2008 年，基于 Git 实现的代码托管平台 GitHub 面世，从此 Git 更是享誉全球。有意思的是，GitHub 当初并不是由 Git 社区的人做的，而是出自 Ruby 社区的开发者之手，两个社区在最初的关系还有些不太和睦，原因是 Git 社区的人对于 GitHub 那群人拿 Git 去做商业化感觉很不爽……当然，这些都是老开发者口中的陈年往事了。毫无疑问，GitHub 对于 Git 的普及做出了巨大的贡献。Hamano 也表示：“ 有 GitHub 替我们做文档以及用户支持，何乐而不为呢。”
- > 值得一提的是，2016 年，在 Git 诞生 11 年之后，曾经与 Linux 短暂携手的 BitKeeper 宣布开源，只可惜为时已晚。
