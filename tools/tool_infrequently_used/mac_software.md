
# Mac 软件 general

- 如何用 MacBook 提高工作效率的【工具篇】 https://juejin.im/post/5ce9d334f265da1bbf68f956
- 如何用 MacBook 提高工作效率 【配置篇】 https://juejin.im/post/5ce9d77af265da1bb31c1517

解锁Charles的姿势 https://juejin.im/post/5a1033d2f265da431f4aa81f

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mac ssh软件

Mac OS X 平台有哪些好用的 SSH 客户端？ - 知乎 https://www.zhihu.com/question/20541129
- Mac OS X 平台有哪些好用的 SSH 客户端？ - miaowing的回答 - 知乎 https://www.zhihu.com/question/20541129/answer/416759050
  > https://www.royalapplications.com/ts/mac/features
- Mac OS X 平台有哪些好用的 SSH 客户端？ - 我不是大神的回答 - 知乎 https://www.zhihu.com/question/20541129/answer/388101176
  > http://www.hostbuf.com/t/988.html

Alternatives to Terminator for `Mac` with `any license` https://alternativeto.net/software/terminator/?platform=mac 【注意，真到实际用的时候还是要考虑开源版或免费版。】

## [iTerm2](https://iterm2.com/)

iterm2有什么酷功能？ - 知乎 https://www.zhihu.com/question/27447370
- iterm2有什么酷功能？ - haidao的回答 - 知乎 https://www.zhihu.com/question/27447370/answer/58976209
  * > 我写了一篇文章，[你应该知道的 iTerm2 使用方法--MAC终端工具](http://wulfric.me/2015/08/iterm2/)。贴在下面。
    >> 你应该知道的 iTerm2 使用方法--MAC终端工具 http://wulfric.me/2015/08/iterm2/
  * > **智能选中**
    + > 在 iTerm2 中，双击选中，三击选中整行，四击智能选中（智能规则可配置），可以识别网址，引号引起的字符串，邮箱地址等。（很多时候双击的选中就已经很智能了）
    + > 在 iTerm2 中，选中即复制。即任何选中状态的字符串都被放到了系统剪切板中。
  * > **常用快捷键**
    + > 切换 tab：`⌘+←`, `⌘+→`, `⌘+{`, `⌘+}`。`⌘+数字`直接定位到该 tab；
  * > **自动完成**
    + > iTerm2 可以自动补齐命令，输入若干字符，按`⌘+;`弹出自动补齐窗口，列出曾经使用过的命令。
    + > iTerm2 也可以使用历史记录，按`⌘+Shift+h`弹出历史粘贴记录窗口，`⌘+Shift+;`弹出历史命令记录窗口。
  * > **高亮当前鼠标的位置**
    + > 一个标签页中开的窗口太多，有时候会找不到当前的鼠标，⌘+/找到它。
  * > mosh
    + > mosh 是全平台更好的 ssh 工具，更健壮，支持断续连接，支持除了 iPhone 之外的几乎任何平台。（iOS 让人爱不释手的优点，也正是它让人恨之入骨的缺点）
- iterm2有什么酷功能？ - gtzs的回答 - 知乎 https://www.zhihu.com/question/27447370/answer/104372111
  * > 最新版的3.0 有两个很酷的新功能： Shell Integration 和 Utilities Package。

Iterm2快捷键 - 東方海竹的文章 - 知乎 https://zhuanlan.zhihu.com/p/275858155

### 多个窗口同时执行命令

iTerm2多个窗口同时输入命令 https://blog.csdn.net/fangfu123/article/details/105659155
- > 使用iTerm2的时候，有时候我们会打开多个终端窗口，去执行命令。如果需要多个窗口同时执行相同的命令。那我们岂不是每个终端都要上去敲一下。其实iTerm2支持多窗口同时输入命令。
- > 打开这个功能的快捷键就是：
  * > `⌘(command) + ⇧(shift) + i`
  * > 会弹出告警信息，点OK确认。然后我们在第一个窗口中输入命令，会发现后面几个窗口都会自动同步输入命令。这个在配置调试k8s集群的时候会非常好用。
- > 关闭其实也很简单。再次输入刚刚打开的那个命令就行了。
  * > `⌘(command) + ⇧(shift) + i`

### 官方增强插件（脚本）

Shell Integration https://iterm2.com/documentation-shell-integration.html
- > The easiest way to install shell integration is to select the `iTerm2` > `Install Shell Integration` menu item. It will download and run a shell script as described below. You should do this on every host you ssh to as well as your local machine. The following shells are supported: tcsh, zsh, bash, and fish 2.3 or later.

Utilities https://iterm2.com/documentation-utilities.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mac vnc

mac 通过vnc连接centos 7 https://blog.csdn.net/devoteeA/article/details/51471981
```sh
localhost:~ $ brew install Caskroom/cask/vnc-viewer
...
...
==> Tapping caskroom/cask
Cloning into '/usr/local/Homebrew/Library/Taps/caskroom/homebrew-cask'...
remote: Enumerating objects: 3578, done.
remote: Counting objects: 100% (3578/3578), done.
remote: Compressing objects: 100% (3569/3569), done.
remote: Total 3578 (delta 25), reused 491 (delta 7), pack-reused 0
Receiving objects: 100% (3578/3578), 1.20 MiB | 633.00 KiB/s, done.
Resolving deltas: 100% (25/25), done.
Tapped 1 command and 3466 casks (3,583 files, 3.9MB).
==> brew cask install Caskroom/cask/vnc-viewer 
==> Downloading https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'vnc-viewer'.
==> Installing Cask vnc-viewer
==> Moving App 'VNC Viewer.app' to '/Applications/VNC Viewer.app'.
🍺  vnc-viewer was successfully installed!

// 安装成功后从启动台启动 vnc-viewer，输入之前在单位的win10笔记本上已经确定一定可以成功连接的地址 9.186.106.126:4，但是报如下错误：
Unable to connect to VNC Server using your chosen security setting. Either upgrade VNC Server to a more recent version from RealVNC, or select a weaker level of encryption.
// 然后按照官方的帮助页面（ https://help.realvnc.com/hc/en-us/articles/360002254738 ）里的错误提示去改参数值，几个参数值全试了，都不行。
// 最后还是在TigerVNC页面（ https://github.com/TigerVNC/tigervnc/releases ）直接下载了当前最新稳定版（1.10.0），还免安装，直接搞定。
//    https://github.com/TigerVNC/tigervnc/releases  -->  https://bintray.com/tigervnc/stable/tigervnc/1.10.0  -->  https://bintray.com/tigervnc/stable/download_file?file_path=TigerVNC-1.10.0.dmg
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# homebrew

Homebrew的正确安装与使用 https://juejin.im/post/5a6d969bf265da3e2366b853
> `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Mac OS下brew的安装和使用 https://www.jianshu.com/p/ab50ea8b13d6

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## homebrew安装的各种软件

Mac如何打开身份不明开发者的程序？ - 张珺超的回答 - 知乎 https://www.zhihu.com/question/52623818/answer/193376661
- > 其实没有那么麻烦。遇到这种情况，右键点击这个文件然后点打开，而不是双击。这样弹出的窗口就有打开按钮了～

### `meld`

```sh
% brew install --cask homebrew/cask/meld
Updating Homebrew...
==> Downloading https://github.com/yousseb/meld/releases/download/osx-19/meldmer
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws
######################################################################## 100.0%
==> Installing Cask meld
==> Moving App 'Meld.app' to '/Applications/Meld.app'.
==> Linking Binary 'meld.wrapper.sh' to '/usr/local/bin/meld'.
🍺  meld was successfully installed!
```

### `ip a`

ip command in Mac OS X terminal https://superuser.com/questions/687310/ip-command-in-mac-os-x-terminal
- > You can use `brew` to install `iproute2mac`. It's actually a Python wrapper that provides a very similar API that you'll likely find very familiar to the `ip` tool included with `iproute2` on Linux.
  ```sh
  $ brew install iproute2mac
  ==> Installing iproute2mac from brona/homebrew-iproute2mac
  ==> Downloading https://github.com/brona/iproute2mac/archive/v1.0.3.zip
  ######################################################################## 100.0%
  🍺  /usr/local/Cellar/iproute2mac/1.0.3: 4 files,  24K, built in 2 seconds
  ```

### `Graphviz`

Download https://graphviz.org/download/
```sh
$ brew install graphviz
```
>> 之所以要安装这个库是因为这个： https://github.com/Freemanzxp/GBDT_Simple_Tutorial  -->  `Python库：pandas、PIL、pydotplus， 其中pydotplus库会自动调用Graphviz，所以需要去Graphviz官网下载graphviz的-2.38.msi ，先安装，再将安装目录下的bin添加到系统环境变量，此时如果再报错可以重启计算机。详细过程不再描述，网上很多解答。`
>>> 然而 `PIL` 库只能在 Python2 里用，但是好在有人写了兼容版本的 `Pillow`，直接 `conda install pillow` 即可。（from: [使用anaconda安装python3版本的PIL](https://blog.csdn.net/Void_worker/article/details/99627783)）

### [`MacTeX`](https://tug.org/mactex/)

What are the practical differences between installing LaTeX from MacTeX or MacPorts/Homebrew? https://tex.stackexchange.com/questions/97183/what-are-the-practical-differences-between-installing-latex-from-mactex-or-macpo
- https://tex.stackexchange.com/questions/97183/what-are-the-practical-differences-between-installing-latex-from-mactex-or-macpo/155081#155081  【一个下载软件，如此频繁地变更接口。。。】
  * > **Edit 2021**
    + > brew has once again changed its syntax for this. You should now be using
      ```sh
      $ brew install --cask mactex
      ```

### ~~unrar~~ --> `unar`

MAC 命令行解压 rar 文件 https://www.jianshu.com/p/cb5baeddd338

### `docker`

https://yeasy.gitbook.io/docker_practice/install/mac
- > 使用 Homebrew 安装
  ```sh
  brew install --cask docker
  ```
- > 手动下载安装
- > 运行
  * > 从应用中找到 Docker 图标并点击运行。
  * > 之后，你可以在终端通过命令检查安装后的 Docker 版本。

macOS 下使用 Docker 搭建 ubuntu 环境 - 十里的文章 - 知乎 https://zhuanlan.zhihu.com/p/59548929

### `libtool` `automake` `git` `curl`

`brew install libtool automake git curl`

### `gdb`

除了 `brew install gdb` 安装一下，还得搞个证书，麻烦得一批，垃圾。

在Mac安装最新gdb的详细教程，含可能遇到的所有坑(网上最新教程) https://blog.csdn.net/qq_33154343/article/details/104784641
- > 出现如下如下代码： `Unable to find Mach task port for process-id 2358: (os/kern) failure (0x5). (please check gdb is codesigned - see taskgated(8))`
  >> 解决方法：使用 sudo 权限 ，运行命令 sudo gdb mainApp 调试

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mac Anaconda

Installing on macOS https://docs.anaconda.com/anaconda/install/mac-os/
- > Problems? See troubleshooting. https://docs.anaconda.com/anaconda/user-guide/troubleshooting/

macOS Anaconda 安装和卸载 https://www.jianshu.com/p/d250a4245d81

从Mac中彻底删除Anaconda https://www.jianshu.com/p/8747a347ea8b

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# mac 剪贴板增强

Mac 上哪款剪贴板增强软件最好用？ - 绚丽也尘埃的回答 - 知乎 https://www.zhihu.com/question/30372510/answer/268342922
- > 我之前一直使用ClipMenu：https://github.com/naotaka/ClipMenu/issues/21，作者是一个日本人，感觉非常好用。 但是目前这个项目貌似停止开发了，老版本也不好下载了。 貌似有另外一个日本人接手了，基于ClipMenu做了一个Clipy：https://github.com/Clipy/Clipy。 ClipMenu和Clipy都是免费的，支持文字和图片的复制，功能上已经非常强大了，大家不用花钱买别的啦。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

Fun with rpath, otool, and install_name_tool https://medium.com/@donblas/fun-with-rpath-otool-and-install-name-tool-e3e41ae86172
