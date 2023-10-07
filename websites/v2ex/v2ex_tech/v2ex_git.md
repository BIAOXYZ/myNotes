
【[:star:][`*`]】 Github 强制开启两步验证了，请问大家用的什么验证器？ https://www.v2ex.com/t/969213
>> //notes：SB Github，祝早日完蛋！
- > 我是不想下载个 app ，就用的谷歌浏览器插件 https://chrome.google.com/webstore/detail/authenticator/bhghoamapcdpbohphigoooaddinpkbai

有多少人完全使用命令行管理 git 得 https://www.v2ex.com/t/972261
- > 开发用 (Neo)Vim ，但敲 Git 命令感觉很麻烦，也不直观。所以一直用的 `lazygit` 这种 terminal UI ，既能保证无缝的纯键盘操作体验，又有直观的 UI 显示各种 branch 和 commit 信息，一些要 rebase -i 的常用操作也都直接集成了快捷键一键完成
- > `lazygit` 比敲命令舒服
- > 命令行 + https://git-fork.com/ <br> 命令行用于提交和拉取代码，fork 用于查看记录、对比
- > 我用的 `gitui`, TUI 类型的，怎么着也比纯命令行强吧。
- > 玩意不是哪个方便，哪个清楚用哪个？
  ```sh
  git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
  ```
- > 
  ```sh
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset %C(yellow)[%ae]%Creset' --abbrev-commit --date=iso
  ```
  * > 可以建一个 `git alias`:
    ```sh
    git config --global alias.clog "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset %C(yellow)[%ae]%Creset' --abbrev-commit --date=iso"
    ```
  	> 以后就可以直接 `git clog`


国内怎么配置代理下载 git 项目？ https://www.v2ex.com/t/904559
- > https://ghproxy.com

请问 Github 如何设置单独只能访问一个库的秘钥？ https://www.v2ex.com/t/900872
- > 现在正在 beta 的 api 密钥可以设置指定仓库的 <br> `Settings->Developer settings->Personal access tokens->Fine-grained tokens`
- > 如果希望以 api 方式来提交，那就如 #2 ；如果希望以 git 方式提交，那就 deploy key: https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys

公司准备在某些区域禁止互联网 https://www.v2ex.com/t/867330
- > GitClone https://gitclone.com/

在使用 git 时的一些尴尬场景里的修复方案 https://www.v2ex.com/t/862191
```console
https://ohshitgit.com
还有一个简体中文的翻译版本： https://ohshitgit.com/zh
```

github 个人主页的这个 team 怎么去掉? https://www.v2ex.com/t/848327
- > 点这个区域右上角的 Contribution settings ，去掉 Activity overview 的勾选即可。
- > 感谢楼主带领大家发现新大陆

[2022-03] GitHub 加速终极教程 https://www.v2ex.com/t/843383

Git clone 国内下载慢问题，大家是如何解决的 2022-03-28 https://www.v2ex.com/t/843313
- > `git config --global http.proxy`
- > https://greasyfork.org/zh-CN/scripts/412245-github-%E5%A2%9E%E5%BC%BA-%E9%AB%98%E9%80%9F%E4%B8%8B%E8%BD%BD
- > https://gist.github.com/evantoli/f8c23a37eb3558ab8765
- > FastGithub ，挺方便。直接下载安装包，git push/clone 都能得到很好的解决。 https://github.com/dotnetcore/FastGithub
- > https://github.com/ineo6/hosts 试一试这个
- > https://www.github.do/

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
