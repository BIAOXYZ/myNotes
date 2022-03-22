
.git/objects 有 800 多兆，怎么清理合适 ？ https://www.v2ex.com/t/842187
- > 清理？ https://git-scm.com/book/zh/v2/Git-%E5%86%85%E9%83%A8%E5%8E%9F%E7%90%86-Git-%E5%AF%B9%E8%B1%A1
- > git gc ？

Git 部分命令提示 memory allocation of ... bytes failed https://www.v2ex.com/t/840072

.git objects 为什么要取前两个 字母作为文件夹再添加? https://www.v2ex.com/t/799743

github actions 居然是能扩容的 https://www.v2ex.com/t/783934
- > 我不太懂，你竟然能 ssh 到 github actions 的容器里？
  >> 用那种端口映射的服务
  >>> https://github.com/marketplace/actions/debugging-with-tmate  这个 action 就可以 ssh 到 github action 中，任务最长时间 6 小时，时间到了，资源以及数据就删除了
  >>>> 老号估计只会限制你使用 actions，白号检测到 ssh 或者 tmate 这些，直接删号的……

如何查看针对一个 git 仓库的 clone 和 pull 操作历史? https://www.v2ex.com/t/719779
- > git 本身没有, git hook 可以自己记录

Git 第一版源代码 https://www.v2ex.com/t/713730
```console
https://github.com/git/git/commit/e83c5163316f89bfbde7d9ab23ca2e25604af290

猛一看有种错觉：就这？我也能写。
```
- > 一种错觉，最近好多文章都在写 git 第一版源码。第一个是看的阿里技术发的文，然后就铺天盖地的 git 第一版。
- > git 实现本来就不难，设计做的比较好。我之前就写过了： https://v2ex.com/t/674356#reply3

老弟兴奋的说：哥，我发现了 Linus Torvalds git 代码里的 bug https://www.v2ex.com/t/713479
```c
sha1_dir = getenv(DB_ENVIRONMENT);
if (sha1_dir) {
	struct stat st;
	if (!stat(sha1_dir, &st) < 0 && S_ISDIR(st.st_mode))
		return 0;
	fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
}

stat 返回 0 或 -1，非零加！结果为 0，0 加！结果为 1，这里<0 条件永远不成立？
各位老哥们，这里我没理解错吧，别误导了我弟，哈哈哈哈。
```
- > 你说的没错： https://github.com/git/git/commit/7fa6b4e7692926d2d07adee1ef8e277157929058#diff-8117edf99fe3ee201b23c8c157a64c95

git 自动提交脚本 push 后显示的是别人的帐号（确定邮箱不是那个人的） https://www.v2ex.com/t/712058

萌新请教 Git Rebase 问题 https://www.v2ex.com/t/695853

怎么处理 git 下面 lfs 文件“坏掉”的问题？现在没办法 checkout branch 了 https://www.v2ex.com/t/683636

Git 删除最早一次提交的问题 https://www.v2ex.com/t/682835

git 里怎么方便地追踪某一行的修改历史 https://www.v2ex.com/t/670941

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
