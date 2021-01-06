
刚从 Windows 转到 macOS，如何快速上手操作？| 新手问号 https://sspai.com/post/41371

sb：
- 为什么MAC下chrome 无法使用“继续浏览上次关闭浏览器时在看的网页”？ - 知乎 https://www.zhihu.com/question/21633080
- 在 macOS/OS X 中关闭应用窗口，为什么默认设定不是完全退出？ - 知乎 https://www.zhihu.com/question/21143701
- Mac新手求问，chrome在点击左上角的叉之后，程序退出但没有关闭，这种情况无法触发下次重新打开上次未关闭的标签页，怎么办。。。 https://www.v2ex.com/t/54150

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Mac 软件

- 如何用 MacBook 提高工作效率的【工具篇】 https://juejin.im/post/5ce9d334f265da1bbf68f956
- 如何用 MacBook 提高工作效率 【配置篇】 https://juejin.im/post/5ce9d77af265da1bb31c1517

解锁Charles的姿势 https://juejin.im/post/5a1033d2f265da431f4aa81f

## mac ssh软件

Mac OS X 平台有哪些好用的 SSH 客户端？ - 知乎 https://www.zhihu.com/question/20541129
- Mac OS X 平台有哪些好用的 SSH 客户端？ - miaowing的回答 - 知乎 https://www.zhihu.com/question/20541129/answer/416759050
  > https://www.royalapplications.com/ts/mac/features
- Mac OS X 平台有哪些好用的 SSH 客户端？ - 我不是大神的回答 - 知乎 https://www.zhihu.com/question/20541129/answer/388101176
  > http://www.hostbuf.com/t/988.html

Alternatives to Terminator for `Mac` with `any license` https://alternativeto.net/software/terminator/?platform=mac 【注意，真到实际用的时候还是要考虑开源版或免费版。】

## mac vnc

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

## homebrew

Homebrew的正确安装与使用 https://juejin.im/post/5a6d969bf265da3e2366b853
> /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Mac OS下brew的安装和使用 https://www.jianshu.com/p/ab50ea8b13d6

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Mac 操作&设置&快捷键

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 反人类的鼠标滚轮方向

苹果Mac OS X怎样设置鼠标滚轮滑动的方向/反向 https://jingyan.baidu.com/article/2c8c281dfdd6df0009252a40.html
- 1、首先打开左上角全局菜单中的“偏好设置”
- 2、然后在偏好设置中找到“鼠标”点击进去
- 3、最后在“鼠标”设置中把“滚动方向：自然”前面的勾去掉就和windows中一样了。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 音量图标需要自己调出来

调高或调低 Mac 的音量 https://support.apple.com/zh-cn/guide/mac-help/mchl1f98810b/mac
> 如果“音量”控制不在菜单栏中，请选取“苹果菜单:apple:” > “系统偏好设置”，然后点按“声音”。点按“输出”，然后选择“在菜单栏中显示音量”复选框。

MacBook中如何将声音音量显示在菜单栏中 https://jingyan.baidu.com/article/414eccf6b3ff626b431f0a8d.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 右上角显示完整日期而不是只有时间

mac，如何设置系统菜单栏，显示日期？ https://jingyan.baidu.com/article/b7001fe1faeb130e7382dd45.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 对文件的剪切`command + X`无效

为什么 Mac 没有提供剪切文件功能？ - Lily Wong的回答 - 知乎 https://www.zhihu.com/question/19579070/answer/60381049
```
1. 复制粘贴：cmd+c→cmd+v
2. 剪切粘贴：cmd+c→cmd+option+v
```
>> 又一个mac装逼的点，呵呵。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 自带shell的各种快捷键

Mac 上的“终端”键盘快捷键 https://support.apple.com/zh-cn/guide/terminal/trmlshtcts/mac
- > 使用“终端”窗口和标签页

  |操作|快捷键|
  |--|--|
  | 新建窗口 | Command-N |
  | 新建标签页 | Command-T |
  | 将窗口拆分为两个面板 | Command-D |
  | 关闭拆分面板 | Shift-Command-D |
  | 关闭标签页 | Command-W |
  | 关闭窗口 | Shift-Command-W |

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 快速回到桌面

苹果Mac如何快速显示桌面快捷键及手势 https://jingyan.baidu.com/article/6dad50750fbd22a122e36e44.html
- > 另外，除了可以用 `command+F3` 来显示桌面以外，我们还可以通过 `Fn+F11` 键来显示桌面。
- > 用五个手指在触控板上做一个张开的动作，即可显示桌面了。
- > 如果你觉得Fn+F11二个键位离得太远了，想要更改的话，请在“系统偏好设置”中打开 Mission Control 功能 <br> 在 Mission Control 界面中，点击“显示桌面”下拉列表，可以自己定义一个和 Fn 键配合来显示桌面的按键。比如 Fn+左shift键

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 普通乘号(是`×`，而不是`✖️`)的输入；特殊符号；表情符号

mac快捷键—特殊符号 https://www.jianshu.com/p/09d71ac1a8e4
> 另外乘号，输入法“乘号”可以出来粗大的✖️，标准的乘号要用 shift+option+b 来选择 ×

Mac用Option键输入特殊符号 https://www.jianshu.com/p/844ab18fd819

如何在 Mac 上使用表情符号、重音符号和其他符号 https://support.apple.com/zh-cn/HT201586
- > 2.按下 `Control-Command-空格键`。此时会显示“字符检视器”弹出式窗口：

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 目录没有一个直观的向上一级的按钮，得通过那个访达Finder来向上一级

Mac 怎么打开根目录，怎么查看硬盘 https://jingyan.baidu.com/article/acf728fd7138b7f8e510a398.html
- > 可以利用 “前往”操作,在 “Finder”-》“前往”-》“前往文件夹 ...”,或打开 Finder,按键盘快捷键“Command+Shift+G”,  打开对话框,输入根目录的标识 “ /”,再点击“前往”按钮。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 用户“家目录”（实际上这个不是home目录了）下不是用`~/.bashrc`，而是`~/.bash_profile`。但是后者也得自己手动建。

macOS/Linux 环境变量设置 - 蒋航的文章 - 知乎 https://zhuanlan.zhihu.com/p/25976099
> macOS 默认用户环境变量配置文件为 `~/.bash_profile`，Linux 为 `~/.bashrc`。如果不存在 `~/.bash_profile`，则可以自己创建一个 `~/.bash_profile`。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 直接双击无法打开时，按住ctrl + 单击程序

打开来自身份不明开发者的 Mac 应用 https://support.apple.com/zh-cn/guide/mac-help/mh40616/mac

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 画蛇添足的`.DS_Store`

**//今天碰到研究院一个（之前没用git的）同事问我仓库里这一堆`.DS_Store`怎么删不掉。我一看，仓库70多个提交了，从第二个提交开始（第一个是README）就和各种`.DS_Store`，`.idea`还有别的中间文件ran在一起。。。于是只能是帮他们先git rm掉，再新建个.gitignore文件过滤。但是`.idea`等还很好办，这个垃圾`.DS_Store`多个目录都有！呵呵，常威，你还说你的Mac不是垃圾？**

如何删除GIT中的.DS_Store https://www.jianshu.com/p/fdaa8be7f6c3
```
----------------------------------------------------------------------------------------------------
如果你的项目中还没有自动生成的 .DS_Store 文件，那么直接将 .DS_Store 加入到 .gitignore 文件就可以了。
如果你的项目中已经存在 .DS_Store 文件，那就需要先从项目中将其删除，再将它加入到 .gitignore。如下：

删除项目中的所有.DS_Store。这会跳过不在项目中的 .DS_Store
1.find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

将 .DS_Store 加入到 .gitignore
2.echo .DS_Store >> ~/.gitignore

更新项目
3.git add --all
4.git commit -m '.DS_Store banished!'
----------------------------------------------------------------------------------------------------
如果你只需要删除磁盘上的 .DS_Store，可以使用下面的命令来删除当前目录及其子目录下的所有.DS_Store 文件:

find . -name '*.DS_Store' -type f -delete
----------------------------------------------------------------------------------------------------
禁用或启用自动生成

禁止.DS_store生成：
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

恢复.DS_store生成：恢复.DS_store生成：
defaults delete com.apple.desktopservices DSDontWriteNetworkStores
----------------------------------------------------------------------------------------------------
```

Mac中Git忽略.DS_Store文件 https://orianna-zzo.github.io/sci-tech/2018-01/mac%E4%B8%ADgit%E5%BF%BD%E7%95%A5.ds_store%E6%96%87%E4%BB%B6/

- 解决讨厌的.DS_Store文件（上） https://bingozb.github.io/9.html
- 解决讨厌的.DS_Store文件（下） https://bingozb.github.io/10.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` MacBook Pro 操作&设置&快捷键

## 自带截屏

在 Mac 上拍摄截屏 https://support.apple.com/zh-cn/HT201361
- > 要拍摄截屏，请同时按住以下三个按键：Shift、Command 和 3。
- > **如何捕捉屏幕上的某一部分**
  * > 同时按住以下三个按键：Shift、Command 和 4。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 手动锁屏

MacBook Pro 一键锁屏快捷方式 - 笔电的文章 - 知乎 https://zhuanlan.zhihu.com/p/72247613
- > 方法一：点击屏幕左上角 `苹果` 图标，点击`锁定屏幕`，或者使用快捷键 `Control+Command+Q` 进入锁屏状态

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 使用 F1 到 F12 等功能键

在配备触控栏的 MacBook Pro 上使用功能键 https://support.apple.com/zh-cn/HT207240
- > 您还可以让功能键在您使用特定 App 时自动显示：

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `#` Mac 其他

使用文件保险箱加密 Mac 上的启动磁盘 https://support.apple.com/zh-cn/HT204837

在 macOS/OS X 中关闭应用窗口，为什么默认设定不是完全退出？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21143701/answer/138259090
>> 傻逼死了，搞得Chrome和Firefox退出时候不能点❎关闭，不然不小心再点开记录就没了。装逼死了。

***呵呵，号称比windows方便快速。试试同时用Xshell和MobaXterm装两个集群，各种需要复制粘贴、改参数。然后再来说方便吧。。。**
- 在 Mac 上使用多点触控手势 https://support.apple.com/zh-cn/HT204895
- mac 触摸板常用手势与操作 https://jingyan.baidu.com/article/20b68a88847549796cec62e9.html
