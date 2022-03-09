
# DOS

Win11 明日发布，一文带你看完 Windows 前世今生 https://www.ithome.com/0/579/032.htm
- > 而在乔布斯与比尔盖茨争执的时候，比尔盖茨就是拿着施乐怼乔布斯：“我们都有个有钱的邻居，叫施乐，我闯进他们家准备偷电视机的时候，发现你已经把它盗走了。”
- > 另外，微软为 Windows 3.2 增加了简体中文支持，使其成为第一款支持简体中文的 Windows 系统。中国第一批微软用户也是从 Windows 3.2 开始了解微软的。
- > 在 Windows 95 中，微软第一次抛弃了对 MS-DOS 的依赖，用户不必向之前那样先安装 MS-DOS 再安装 Windows 了。
- > Windows XP 的中文全称为“视窗操作系统体验版”，字母 XP 代表英文单词“体验”（experience）。
- > 从 Windows XP 开始，微软会为同一款系统准备多个版本发布，XP 就有家庭版（Home）和专业版（Professional）两个版本，后者具备更强的专业功能，例如增加了对双处理器的支持。

微软回顾 Windows 命令行演变史 力证 DOS 未过时 - Windows - cnBeta.COM https://www.cnbeta.com/articles/tech/742467.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows general

IT之家教程：一文看懂如何从Windows 7升级到Windows 10 https://www.ithome.com/0/444/795.htm
> 这里我们优先推荐使用[软媒魔方](https://mofang.ruanmei.com/)工具软媒虚拟光驱装载Windows 10系统ISO镜像或者使用微软官方升级工具[Media Creation Tool](https://www.microsoft.com/zh-cn/software-download/windows10ISO/)纯净安装。通过软媒魔方工具装载ISO镜像之后新的文件夹中双击Setup.exe执行文件，即可开启Windows 10的安装之旅。
- 软媒魔方 https://mofang.ruanmei.com/
- Media Creation Tool https://www.microsoft.com/zh-cn/software-download/windows10ISO/

Win10 开机具慢大家是如何排除的？ https://www.v2ex.com/t/654705
> 谢谢各位解答，就是 ME 的问题，BIOS 中默认就是启用 ME 的。硬件管理器中卸载 ME，然后 BIOS 里禁用 ME，彻底解决问题。顺便问一下 ME 有什么用

## 休眠

挂机下载电脑却自动休眠？一款“袖珍”的绿色工具 https://www.ithome.com/0/475/763.htm
- > Don't Sleep官网下载地址：https://www.softwareok.com/?seite=Microsoft/DontSleep/History
- > 一劳永逸解决WIN10所有睡眠问题 - 薛解中的文章 - 知乎 https://zhuanlan.zhihu.com/p/93306740

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows 8

如何解决win8系统没有声音 https://jingyan.baidu.com/article/7f766daf43739b4101e1d0fa.html
- > **查看音频服务是否启动2**
  * > `同时按住键盘“WIN+R”键盘，在左下角弹出运行命令的窗口`
  * > `输入命令“Services.msc”，点击”确定“按钮，在右侧列表中查找“Windows Audio”服务，看状态是否为正在运行状态，如果没有，那么设置为开启，并设置为自动开启，右键===》开启`
    >> //notes：我的笔记本显示的状态确实是“Running”，但是还是会突然没声音。不过restart一下该服务即可。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows 11

微软 Win11 正式版发布一周，升级需要注意的细节一览 https://www.ithome.com/0/580/950.htm

Win11 VBS 安全功能导致性能下降，教你如何检测并关闭 https://www.ithome.com/0/579/260.htm
- 回复：
  * > 关了以后，WSL开不了了，慎重慎重
  * > 全新安装 未启用 联想
  * > 我的默认就是未启用。省的关了。
  * > 这个不对吧，我是从win10升上来的，但开了wsl2，查看这里也开了，但安全中心里的内核隔离是关闭的
  * > 严格意义上来讲这个操作是不对的吧，关闭虚拟机监控只是关闭了依赖而禁用vbs，安全中心(忘了win11改了个什么名字)里可以单独关闭vbs
  * > 在设置里的安全中心里关啊，跑这里干嘛
  * > Windows安全中心-设备安全性-内核隔离，关掉就行了
  * > 虚拟机严重依赖，关了这个没法用虚拟机了吧？
    >> 不会影响，别关虚拟化就行

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows keyboard shortcuts

windows10下有哪些必须掌握的快捷键？ - 小众的回答 - 知乎 https://www.zhihu.com/question/63509083/answer/209854128

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows 自带工具（or 微软官方工具）

## Win10录屏工具

Win10自带录屏功能怎么用 https://jingyan.baidu.com/article/a3f121e4af5a6efc9152bb45.html
>> notes: `WIN + g`组合键打开录屏界面；`WIN + ALT + r`组合键开始录屏（不然还得手动点开始录，有时候可能会不方便）

【但是这个工具好像用过一次以后，每次新打开chrome就会从右侧弹出来提示，比较烦。】按下win+g打开游戏录制工具栏这个弹窗怎么关 https://zhidao.baidu.com/question/1800085965195951867.html
```
1、按下【Win+G】打开工具条；
2、在游戏录制工具条上点击【设置】按钮；
3、在弹出的设置框中将【当我开始游戏时显示提示】的勾去掉即可。
4、设置完成后在我们运行游戏的时候就不会提示：“按下win+G键开启游戏栏”。
```

## Process Explorer

啥拦截软件都挡不住，教你杜绝流氓软件弹窗 https://www.ithome.com/0/521/959.htm
- > 官方下载：https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
- > 这是一款微软自家的工具，它本身是由 Sysinternals 开发的，现在已经被微软收购。Process Explorer 本身是一个高级的任务管理器，他可以用来管理系统不同的进程，远比 Win10 自带的任务管理器更加直观。不过这里，我们着重用到它的弹窗检测功能。
- > 官网地址：https://www.revouninstaller.com/
- > 这是一个非常强力的卸载工具，它的主要功用，在于卸载电脑上某些顽固的软件。Revo Uninstaller 对付弹窗也非常有一套，它自带了一个 “猎人模式”，可以用来识别弹窗的归属，效果非常好。

## Sysinternals

怀疑 Windows 流氓软件后台偷偷读文件，教你如何实锤 https://www.ithome.com/0/590/421.htm
- > 这是一款来自微软官方的工具。进程监视器来自微软 `Sysinternals`，它是一款提供给高级 Windows 用户的工具。
  >> 进程监视器：https://docs.microsoft.com/zh-cn/sysinternals/downloads/procmon

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows settings

Win10右下角弹出通知怎么隐藏 如何关闭弹出通知 https://jingyan.baidu.com/article/6b18230997a483ba58e15981.html

一不小心就尴尬了，教你如何隐藏微软 Win11 搜索结果 https://www.ithome.com/0/606/697.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 环境变量

<<Windows下PATH等环境变量详解>>
https://www.cnblogs.com/sunada2005/articles/2725277.html

> 虽然长，不过写的很好。绝大部分知识其实都知道了，但这个帖好的地方在于讲出了通用性。Linux下的环境变量也是这么一套方法。其实主要目的是搜索Windows下两个百分号括住一个变量名（比如 %GOROOT% ）是啥意思，也得到了解答:
```
set path=%path%;D:\Java\jdk1.6.0_24\bin

     把PATH放在两个百分号之间，指把PATH原有的值取出。
```
> 也就是Windows下的%var%等于Linux下的$var呗。

~顺便记几个Linux下的环境变量相关的帖子~

- Linux环境变量详解 - CSDN博客 https://blog.csdn.net/gatieme/article/details/25975465
- 【Linux】完全解读Linux环境变量 - CSDN博客 https://blog.csdn.net/xyw591238/article/details/51770247

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 环境变量最相关命令set

Windows 如何在cmd命令行中查看、修改、删除与添加环境变量 - CSDN博客
https://blog.csdn.net/stpeace/article/details/53451744
```
1、查看当前所有可用的环境变量：输入 set 即可查看。
2、查看某个环境变量：输入 “set 变量名”即可，比如想查看path变量的值，即输入 set path
3、修改环境变量 ：输入 “set 变量名=变量内容”即可，比如将path设置为“d:\nmake.exe”，只要输入set path="d:\nmake.exe"。
注意，此修改环境变量是指用现在的内容去覆盖以前的内容，并不是追加。比如当我设置了上面的path路径之后，如果我再
重新输入set path="c"，再次查看path路径的时候，其值为“c:”，而不是“d:\nmake.exe”；“c”。
4、设置为空：如果想将某一变量设置为空，输入“set 变量名=”即可。如“set path=” 那么查看path的时候就为空。
注意，上面已经说了，只在当前命令行窗口起作用。因此查看path的时候不要去右击“我的电脑”——“属性”........
5、给变量追加内容（不同于3，那个是覆盖）：输入“set 变量名=%变量名%;变量内容”。如，为path添加一个新的路径，
输入“ set path=%path%;d:\nmake.exe”即可将d:\nmake.exe添加到path中，再次执行"set path=%path%;c:"，
那么，使用set path语句来查看的时候，将会有：d:\nmake.exe;c:，而不是像第3步中的只有c:。
```
```
~~个人补充~~：也可以用 "echo %变量名%" 的方法查看某个环境变量的值。但是注意下面情形中后两种不行。

C:\Users\l00384038>set GOROOT
GOROOT=D:\Go\

C:\Users\l00384038>echo %GOROOT%
D:\Go\

C:\Users\l00384038>set %GOROOT%
环境变量 D:\Go\ 没有定义

C:\Users\l00384038>echo GOROOT
GOROOT
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 环境变量修改后立刻生效

<<解决Windows下修改环境变量后需重启才能生效的问题>>
http://blog.sina.com.cn/s/blog_49370c500100ov36.html
```
在“我的电脑”->“属性”->“高级”->“环境变量”中增加或修改环境变量后，需重启系统才能使之生效。
有没有什么方法可让它即时生效呢？下面介绍一种方法：

以修改环境变量“PATH”为例，修改完成后，进入DOS命令提示符，输入：set PATH=C: ，关闭DOS窗口。
再次打开DOS窗口，输入：echo %PATH% ，可以发现“我的电脑”->“属性”->“高级”->“环境变量”中设置的 PATH 值已经生效。

不用担心DOS窗口中的修改会影响环境变量的值，DOS窗口中的环境变量只是Windows环境变量的一个副本而已。
但是对副本的修改却会引发Windows环境变量的刷新，这正是我们想要的！
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 环境变量立即刷新

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## windows下类似alias的doskey命令

windows系统如何给命令起别名？ - rayhy的回答 - 知乎 https://www.zhihu.com/question/51962577/answer/128317488
> 单独窗口生效：`doskey ls=dir $*` --> 但是就我来看，感觉直接`doskey ls=dir`就可以了。 
>> 还可以通过修改注册表设置成自动执行。
```
----------------------------------------------------------------------------------------------------
CMD设置别名是用doskey命令。

这个命令只对当前对话有效，如果想打开cmd就能使用的话，修改一下注册表，使得每次启动cmd都先运行一下你的脚本就行。
doskey ls=dir $* 把这个保存为env.cmd或者env.bat（自己随便命个名啦。）
然后在注册表HKEY_CURRENT_USER\Software\Microsoft\Command Processor下面加一项AutoRun，把值设为你的脚本路径。
懒得找的话，把下面AutoRun的路径改成你自己的路径，保存为.reg文件双击运行就行。

Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Command Processor]
"AutoRun"="%USERPROFILE%\\env.cmd"
----------------------------------------------------------------------------------------------------
```

### （修改注册表使windows系统别名设置能够自动执行）个人实战过程：

> 上面是原作者的过程，实际上有些细节没完全说出来，比如windows该死的单斜杠和双斜杠问题。
>> 实际上如果肯上传些图片，效果会更好也更容易叙述。我都截了注册表的图了，但是最终还是决定不使用图片！因为仓库管理，迁移等等原因吧。

整个过程涉及一个路径和两个文件：
- `C:\Users\LiangLiu\mydata`：这个是存放自动执行脚本的路径。
- `lslldir.bat`：每次开windows的命令提示符需要自动执行的脚本，里面用doskey命令设置了相关的别名。**这个文件必须处于上面的路径里**。
- `addcmd.reg`：这个文件不是必须的，完全可以手动向注册表里添加，**但是还是用自动的办法吧**，方便且不容易出错（第一次手动添加的时候，把注册表里AutoRun项的数值数据值中的单斜杠写成了双斜杠，找了半天才找到这个原因）。

1. 新建路径`C:\Users\LiangLiu\mydata`，或者用已有路径也没问题，反正用你自己的路径替换这个路径就好。
2. 在上面的路径下新建需要自动执行的别名设置脚本，就命名为`lslldir.bat`吧。所以，最终该文件的完整路径是：`C:\Users\LiangLiu\mydata\lslldir.bat`。文件内容如下（其实就是为了解决在windows的命令提示符下经常手误打ls或者ll的问题）：
```
doskey ls=dir
doskey ll=dir
```
3. 任意位置新建一个文件`addcmd.reg`：这个**往注册表里添加内容的reg文件里面的路径要用双斜杠**；但是**添加成功后注册表里显示的值是用单斜杠**。反正我也不知道为什么，也懒得深究，现象就是这样。
```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Command Processor]
"AutoRun"="%USERPROFILE%\\mydata\\lslldir.bat"
```
4. 双击`addcmd.reg`，一路确定，不出意外就是执行成功。然后到注册表相应的位置（`HKEY_CURRENT_USER\Software\Microsoft\Command Processor`）会发现多了一个AutoRun项：

| 名称 | 类型 | 数据 |
|--|--|--|
|……|……|……|
| AutoRun | REG_SZ | %USERPROFILE%\mydata\lslldir.bat | 
|……|……|……|

双击该项打开，里面的内容是：
```
数值名称(N):
AutoRun

数值数据(V):
%USERPROFILE%\mydata\lslldir.bat
```
5. 添加前后打开window原生的命令提示符时显示的内容的对比：
```
添加前：
----------------------------------------------------------------------------------------------------
Microsoft Windows [版本 10.0.17763.503]
(c) 2018 Microsoft Corporation。保留所有权利。

C:\Users\LiangLiu>
----------------------------------------------------------------------------------------------------

添加后：
----------------------------------------------------------------------------------------------------
Microsoft Windows [版本 10.0.17763.503]
(c) 2018 Microsoft Corporation。保留所有权利。

C:\Users\LiangLiu>doskey ls=dir

C:\Users\LiangLiu>doskey ll=dir

C:\Users\LiangLiu>
----------------------------------------------------------------------------------------------------
```

> `6.`：本来到到第`5.`步就结束了，但是后来发现了一个问题：如果设置了自动执行的脚本（比如上文中的`lslldir.bat`），那么vs code的连接远程服务器开发功能就用不了了，总是连接不上。回头准备去提个issue。后面的情况就参见ide的vs code部分吧。 

----------------------------------------------------------------------------------------------------

Aliases in Windows command prompt https://stackoverflow.com/questions/20530996/aliases-in-windows-command-prompt
> 这个讲了更多的方法，但是没必要细看了。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## windows下类似cat的type命令

Windows DOS内部命令详解03——path、type、copy https://www.jianshu.com/p/f62d3a73c318

TYPE (DOS command) https://en.wikipedia.org/wiki/TYPE_(DOS_command)
> In computing, type is a command in various command-line interpreters (shells) such as `COMMAND.COM`, `cmd.exe`, `4DOS/4NT` and `Windows PowerShell` used to display the contents of specified files on the computer terminal. The analogous Unix command is `cat`.

```
C:\Users\LiangLiu\mydata>type my-crontab.yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
C:\Users\LiangLiu\mydata>
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## windows下类似`whereis`的`where`命令

Windows equivalent of whereis? https://superuser.com/questions/21067/windows-equivalent-of-whereis

个人实战（***确实装了两个mingw的gcc，也都查出来了***）：
```console
Microsoft Windows [版本 10.0.19041.450]
(c) 2020 Microsoft Corporation. 保留所有权利。

C:\Users\LiangLiu>where gcc
C:\MinGW64\bin\gcc.exe
C:\mingw65\bin\gcc.exe

C:\Users\LiangLiu>
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 浏览器劫持

狗日的2345劫持，真TM服了，用了一堆知乎上的办法，下了好多软件，都不管用。最后是V2EX的办法——360杀毒的急救箱搞定的。。。

遇到最顽固的 2345 首页劫持，网上各种方法都试了
https://www.v2ex.com/t/214388

浏览器启动页被2345劫持怎么办？ - 知乎
https://www.zhihu.com/question/23157265

为什么 Chrome 浏览器的主页会被篡改为 hao123 ？遇到这种情况要如何修复？ - 知乎
https://www.zhihu.com/question/21883209

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 远程桌面控制

Comparison of remote desktop software https://en.wikipedia.org/wiki/Comparison_of_remote_desktop_software 
> teamviewer个垃圾（虽然已经比别的垃圾好很多了）动不动就提示`commercial use suspected`，就是想收钱，N多人都是这问题，所以想找个完全开源免费的了。然后这个wiki列表里一定先找最近还活跃的。。。
- TigerVNC https://tigervnc.org/ || https://github.com/TigerVNC/tigervnc --> 这个18年还有版本发布，而且有github，应该还凑合吧？

14 Free Remote Access Software Tools https://www.lifewire.com/free-remote-access-software-tools-2625161
- 02 UltraVNC

GotoHTTP https://gotohttp.com/

## 能支持手机的

AirDroid https://www.airdroid.com/
> http://web.airdroid.com/

RemoDroid https://remodroid.com/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## teamviewer
- https://login.teamviewer.com/
- https://community.teamviewer.com/t5/Knowledge-Base/All-about-passwords/ta-p/28442#toc-hId-585378451
> 用easyaccess解决电脑连接的问题。Extras --> Options --> General 里先把当前电脑assign给teamviewer账户；然后 Extras --> Options --> Security 设置启用easyaccess

办公汪必备软件及技巧：两款远程控制软件助你下班不再往单位跑 - 什么值得买的文章 - 知乎
https://zhuanlan.zhihu.com/p/33211414

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

微软全新远程桌面安卓版 10.0.6 发布 https://www.ithome.com/0/499/895.htm
- > teamviewer没得白嫖了。。。只能允许两个
- > 试试anydesk
- > 国产版 todesk 基本上一样

ToDesk - 免费流畅不限速的远程控制软件 (国内免费向日葵/TeamViewer 替代品) https://www.iplaysoft.com/todesk.html

ToDesk 个人免费极致流畅的远程协助软件 https://www.todesk.com/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 文件共享/同步

Syncthing – 数据同步利器---自己的网盘，详细安装配置指南，内网使用，发现服务器配置，更新docker https://www.cnblogs.com/jackadam/p/8568833.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 剪贴板

跨平台剪贴板同步工具盘点 - 木头分享的文章 - 知乎 https://zhuanlan.zhihu.com/p/64586053
- > 快贴
  * > 今天才用上，铁环pasteasy的工具，比较简便，注册用户可以把历史的剪贴板上面的内容存到云端，可以`shift+alt+v`（快捷键可以设置）一键打开，一键粘贴。
  * > 官网下载： https://clipber.com/

把剪贴板放上云端，在 Android 手机和电脑间即时同步：剪纸云 https://sspai.com/post/52305

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# windows tools general
 
https://www.appinn.com/windows-apps-that-amaze-us/
- qdir https://www.appinn.com/q-dir/
- everything https://www.appinn.com/everything/

Ditto https://github.com/sabrogden/ditto || https://ditto-cp.sourceforge.io/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## PDF related

PDF文档打开后的显示名与文件名不一样 https://jingyan.baidu.com/article/925f8cb8b32fe5c0dde05601.html （IEEE好多论文都这鸟样，改了PDF文件名，一打开标题没变。。。）

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# other tools

## search engine

Qwant https://www.qwant.com/

Yandex https://yandex.com/

DuckDuckGo https://duckduckgo.com/
