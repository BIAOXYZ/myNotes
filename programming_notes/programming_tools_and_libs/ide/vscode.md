
# vscode官方

Visual Studio Code https://github.com/Microsoft/vscode || https://code.visualstudio.com/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode较系统攻略

中文版 Awesome VS Code https://github.com/formulahendry/awesome-vscode-cn

Collection of helpful tips and tricks for VS Code. https://github.com/Microsoft/vscode-tips-and-tricks

第一次使用VS Code时你应该知道的一切配置 https://juejin.im/post/5cb87c6e6fb9a068a03af93a --> https://juejin.cn/post/6844903826063884296
- > **四、私人订制：VS Code 的常见配置**
  * > **6、将当前行代码高亮显示（更改光标所在行的背景色）**
- > **八、三头六臂：VS Code 插件推荐**
  * > **38、Live Share：实时编码分享**

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode新闻

Visual Studio Code 1.26 发布，大量新特性来袭 - Microsoft Visual Studio - cnBeta.COM https://www.cnbeta.com/articles/soft/756969.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode快捷键/已验证技巧

## 预览markdown

VS Code 使用小技巧 - 赵吉彤的文章 - 知乎 http://zhuanlan.zhihu.com/p/22880087
```
- 预览markdown Ctrl+Shift+V  //所以Typora彻底没用了
- 自动保存：File -> AutoSave ，或者Ctrl+Shift+P，输入 auto
```

## 注释/取消注释

vs code 的常用快捷键 https://segmentfault.com/a/1190000012047237
```
1、注释：
　　a) 单行注释：[ctrl+k,ctrl+c] 或 ctrl+/
　　b) 取消单行注释：[ctrl+k,ctrl+u] (按下ctrl不放，再按k + u)
　　c) 多行注释：[alt+shift+A]
```

## 关闭已开启的文件夹（其实可以通过新开另一个文件夹来达到关闭的效果）

How to close an opened folder in Visual Studio Code https://stackoverflow.com/questions/30028469/how-to-close-an-opened-folder-in-visual-studio-code/37549173
> The command to close the currently opened folder can be found from `File` -> `Close Folder`. You can also use the shortcut: Ctrl+K F

## 自动换行

如何让 Visual Studio Code 自动换行？ - wansho的回答 - 知乎 https://www.zhihu.com/question/35042902/answer/400070742
```
English环境下
点击菜单栏 View--> Toggle Word Wrap 选项.
或者直接 快捷键 : alt + Z
```

## 向下复制一行代码

vscode 向下复制当前行（即visual studio 中的Ctrl + D）功能快捷键 https://blog.csdn.net/haihui1996/article/details/87937912
```console
打开vscode左下角键盘快捷键设置，找到copy line down，即可查看当前默认快捷键为“shift + Alt + ↓”

双击快捷键，输入自己想要的快捷组合，如Ctrl+D，然后回车即可设置自己的组合了
```

## 代码块整体左移右移

```
多行代码同时左移一个tab键（等于 shift + tab）
ctrl+[

多行代码同时右移一个tab键（等于 tab）
ctrl+]
```

## 代码格式化

VSCode 代码格式化 快捷键 https://www.cnblogs.com/ryanzheng/p/10950870.html
```console
Visual Studio Code可以通过以下快捷键 格式化代码：

On Windows 　　Shift + Alt + F
On Mac 　　    Shift + Option + F
On Ubuntu　　  Ctrl + Shift + I
```

## 同时编辑多行

vscode 同时编辑多处，多个光标 快捷键 https://blog.csdn.net/Gomeer/article/details/91417928
```
一、重命名变量

1、首先看看自己需要同时修改多处的代码是不是要重命名一个变量，如果是的话，有现成的快捷键f2。选中一个变量，按f2，
弹出一个小窗口，在里面输入内容后按回车，所有该变量都会被重命名。

二、多光标

1、按住alt，用鼠标左键点击，可以出现多个光标，输入的代码可以在光标处同时增加。
2、按住Ctrl + Alt，再按键盘上向上或者向下的键，可以使一列上出现多个光标。
3、选中一段文字，按shift+alt+i，可以在每行末尾出现光标
```

## 代码跳转后返回原位

vscode 跳转到函数之后怎么跳转回之前的位置 https://www.v2ex.com/t/385490
- > 从工具栏的转到中可以看到后退前进的快捷键
- > 默认 alt+左箭头，但是会冲突，建议自定义。

>> //notes：
1. 如果英文版的话是在菜单栏的 `GO` -- `Back` 看当前回退的快捷键。
2. 确实Windows下默认的是 `alt + ⬅`，但是基本都会冲突，我是自定义成了 `alt + |`，因为`=`、`_`等都被占了。。。编辑方法是：点击最左下角的齿轮 -- 选择`Keyboard Shortcuts` -- 搜索`Go Back`即可。

## vscode护眼色修改

- VSCode修改编辑器(代码窗口)背景色 https://blog.csdn.net/u013506207/article/details/80529858   【1】
  > "如果你的VSCode使用的是自带的主题，可以直接到VSCode的安装目录下找到：\resources\app\extensions这个目录，该目录下以theme-开头的文件夹表示其是主题文件夹，按照自己当前使用的主题名称去找到对应的文件夹进去修改即可，在上面给出的参考链接中已有比较详细的说明。本文主要针对在这个目录下找不到的当前所使用主题的文件夹如何修改背景色。"
  >
  > "在你的用户目录下：通常是C:\Users[你的用户名].vscode\extensions存放你从vscode的插件库中下载的第三方插件，当然，主题也会在这里啦，所以找到你这个目录下包含有你当前主题名称的文件夹就是等下要修改的主题文件夹了。"
- Visual Studio Code护眼绿豆沙主题修改 https://blog.csdn.net/Lean_on_Me/article/details/84552487   【2】
  ```
  这款主题是在亮色Atom One Light 的基础上修改的，首先下载并设置Atom One Light
  
  "workbench.colorCustomizations": {
        "[Atom One Light]": {
          "editor.background": "#C7EDCC",   
	      "sideBar.background": "#C7EDCC",
          "activityBar.background": "#C7EDCC",       
        },
    },
  ```
```
总结一下：现在vscode改个背景色比过去麻烦多了。。。

目前粗看是不能直接改vscode的背景色，只能是vscode当前在用某个主题（theme），然后改这个主题的背景色。于是【1】的主要目的
是找到对应主题的json配置文件所在的目录；【2】的主要目的是把两个需要的选项替换成相应的护眼色。

我最终的文件目录是：C:\Users\LiangLiu\.vscode\extensions\akamud.vscode-theme-onelight-2.1.0\themes\OneLight.json
然后里面其实只改了两项"editor.background"和"sideBar.background"似乎就够了。
```

## vscode连接远程服务器开发

VS Code Remote Development https://code.visualstudio.com/docs/remote/remote-overview
- Remote Development using SSH https://code.visualstudio.com/docs/remote/ssh

VSCode使用Remote插件编辑远程服务器文件 https://www.bilibili.com/video/av52490747/
```
一些个人补充：
1.已经是正式版的功能，不需要insider版本。
2.插件一装好，在vscode的最左下角（Mac上是这个位置）就有个很明显的标记去连接。
3.实际上那个记录远程主机和用户列表的config文件不是必需的，只是为了方便。我认为是没必要记，手输一下就完了。会提示：
> Select configured SSH host or enter user@host
>> 所以接着输入一下 user@host（比如我是：root@myopenshift，注意本机hosts要能识别myopenshift噢，不然就用ip）就可以了。

总结一下过程：
1.配好本地主机（window，mac之类的）和远程主机的单向互信，保证在本地主机执行：ssh user@remotehost 时没问题。
2.下载好对应的vscode插件。
3.连接。
```

9102 年的 Windows + Linux 混合开发环境方案 - 王磊的文章 - 知乎 https://zhuanlan.zhihu.com/p/68309055
> 这个里面给了一些可能的问题的解决方案，不过我目前还没有碰到。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode未验证技巧

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode debug

Debugging https://code.visualstudio.com/docs/editor/debugging

***--------------------------------------------------分割线--------------------------------------------------***

VSCode 配置文件的变量索引 - WuYuanhun的文章 - 知乎 https://zhuanlan.zhihu.com/p/44967536
- 【[:star:][`*`]】 Variables Reference https://code.visualstudio.com/docs/editor/variables-reference

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode for C/C++

Visual Studio Code 如何编写运行 C、C++ 程序？ - 知乎 https://www.zhihu.com/question/30315894

万字长文把 VSCode 打造成 C++ 开发利器 - 腾讯技术工程的文章 - 知乎 https://zhuanlan.zhihu.com/p/96819625

## vsc C++ debug

C/C++ for Visual Studio Code https://code.visualstudio.com/docs/languages/cpp
- Debug C++ in Visual Studio Code https://code.visualstudio.com/docs/cpp/cpp-debug
  * > `To learn more, see Configuring C/C++ debugging.` -- Configuring C/C++ debugging https://code.visualstudio.com/docs/cpp/launch-json-reference
  * > `If you are debugging with GDB on Windows, see Windows Debugging with MinGW64.` -- Using GCC with MinGW https://code.visualstudio.com/docs/cpp/config-mingw

>> //notes：其实主要是MinGW没那么好下，即使是在官方主页上（不注意会下那个默认版本，解压后里面没有`bin`目录，不能用！）也容易下错。下面这俩至少都试过了可以用。

Run, Debug & get IntelliSense for C C++ in VSCode https://dev.to/jerrygoyal/run-debug-get-intellisense-for-c-c-in-vscode-4e0o  【2】
- > Windows: Download [MinGW64.zip](https://github.com/GorvGoyl/MinGW64/releases) (latest release) and extract it to the C Drive.
- > VSCode can create and auto-configure these files if we try to debug for the first time. To do that, open C++ file in VSCode and either hit F5 or go to Debug -> Start Debugging and select ***`C++ (GDB/LLDB)`*** then select g++.exe build and debug active file.

Visual Studio Code 如何编写运行 C、C++ 程序？ - 知乎 https://www.zhihu.com/question/30315894
- Visual Studio Code 如何编写运行 C、C++ 程序？ - 谭九鼎的回答 - 知乎 https://www.zhihu.com/question/30315894/answer/154979413  【1】
  * > 下载编译器：[MinGW-w64 - for 32 and 64 bit Windows](https://sourceforge.net/projects/mingw-w64/files/) 往下稍微翻一下，选最新版本中的***`x86_64-posix-seh`***。最好不要用 Download Latest Version，这个是在线安装包，可能因为国内的“网络环境”下载失败。

>> //notes：主要参考【1】，其次参考【2】，总结出了一个至少可以成功单步调试的配置：
- 新建一个文件夹，里面随便放个c++文件，比如：`test-infolder.cpp`。
```cpp
// main.cpp
#include <iostream>
using namespace std;

int main()
{
    int result;
    int a = 2;
    int b = 3;
    result = a + b;
    cout << result << endl;
    return 0;
}
```
- 安装`官方C/C++`插件，`Code Runner`插件我也装了（但是我试了下，disable掉这个插件也可以单步。所以应该是不装这个也可以）。
- 安装MinGW。我是安到了`C:\MinGW64`下，也就是说`gdb.exe`的完整路径是：`C:\MinGW64\bin\gdb.exe`。
- 最关键的`launch.json`和`tasks.json`分别如下：

`launch.json`
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "test win debug",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "C:\\MinGW64\\bin\\gdb.exe",
            "setupCommands": [
                {
                    "description": "为 gdb 启用整齐打印",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "Compile"
        }    
    ]
}
```
`tasks.json`
```json
{
    "tasks": [
        {
            "type": "process",
            "label": "Compile",
            "command": "C:\\MinGW64\\bin\\g++.exe",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ],
    "version": "2.0.0"
}
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode for go

vscode golang配置说明 https://www.cnblogs.com/nickchou/p/9038114.html
```
vscode也可以通过ctrl+shift+p运行命令一次性安装所有这些工具
Go: Install/Update Tools
```

VS code golang 开发环境搭建 - CSDN博客 https://blog.csdn.net/hil2000/article/details/51714607
> https://github.com/golang/tools

在Visual Studio Code配置GoLang开发环境 - CSDN博客 https://blog.csdn.net/chszs/article/details/50076641
> "要注意，GoLang的安装要确保两个环境变量，一个是GOROOT环境变量；二是PATH环境变量要包含$GOROOT\bin值。"

## vsc Go debug

使用Visual Studio Code调试Golang工程 - 徐波的文章 - 知乎 https://zhuanlan.zhihu.com/p/26473355
>> notes：感觉主要就是调试配置那里模式改成————`"mode": "debug"`（有的时候值是`"auto"`）就差不多了。不过我是因为机器之前已经下过delve了。

vscode 的 go 插件怎么正确安装？ https://www.v2ex.com/t/615962
- > export GOPROXY=https://goproxy.cn
- > idea 社区版 可以装 go 的插件，使用体验和 goland 是一样的

解决vs code 调试golang时字符串显示不全的问题。 https://blog.csdn.net/bilinxing_/article/details/90737819
```console
在configurations中增加如下配置，修改"maxStringLen"字段值为自己想要的长度，默认64，这里修改为521。
注意其他默认字段不能省略，使用默认值即可：

"dlvLoadConfig": {
                "followPointers": true,
                "maxVariableRecurse": 1,
                "maxStringLen": 512, //字符串最大长度
                "maxArrayValues": 64,
                "maxStructFields": -1
		}
```

Go in Visual Studio Code https://code.visualstudio.com/docs/languages/go
- > The Go extension lets you debug Go code as well. You will need to install the Delve debugger manually as a prerequisite. Read [Debug Go programs in VS Code](https://github.com/golang/vscode-go/blob/master/docs/debugging.md) for setup steps, information on remote debugging and a troubleshooting guide.
  >> Debugging https://github.com/golang/vscode-go/blob/master/docs/debugging.md

***--------------------------------------------------分割线--------------------------------------------------***

# vscode for python

VSCode基础使用+VSCode调试python程序入门 https://blog.csdn.net/u013600225/article/details/52971528

## 自动打开的一个python提示（当你有`.py`文件在vscode里时，偶尔会弹出）

- 文件名字：《`Python - Get Started`》
- 文件内容：
```console
Python Extension

Create a Jupyter Notebook
- Run "Create New Blank Jupyter Notebook" in the Command Palette (Shift + Command + P)
- Explore our sample notebook to learn about notebook features
Create a Python File
- Create a new file with a .py extension
Open a Folder or Workspace
- Open a Folder
- Open a Workspace
Use the Interactive Window to develop Python Scripts
- You can create cells on a Python file by typing "#%%" 
- Use "Shift + Enter " to run a cell, the output will be shown in the interactive window

Take a look at our Release Notes to learn more about the latest features
- Added a start page for the extension. Launched in experimental mode such that it opens to new users or when there is a new release. It can be disabled with the setting 'Python: Show Start Page' and it can be opened at any time with the command 'Python: Open Start Page'.
- Removed `python.jediEnabled` setting in favor of `python.languageServer`. Instead of `"python.jediEnabled": true` please use `"python.languageServer": "Jedi"`.
- Made the variable explorer in the Notebook editor resizable.
Explore more features in our Tutorials or check Documentation for tips and troubleshooting.

Don't show this page again
```
- 打开方式：正如上面文件内容里所说的，（首先打开`Command Palette`，可以按`F1`，或者按`Ctrl + Shift + P`，或者点击左下角齿轮，弹出菜单第一个），然后输入`Python: Open Start Page`，最后回车即可。

## vsc Python debug

Using Python environments in VS Code https://code.visualstudio.com/docs/python/environments
- > `For more details on debug configuration, see Debugging configurations.` -- Python debug configurations in Visual Studio Code https://code.visualstudio.com/docs/python/debugging
  * https://code.visualstudio.com/docs/python/python-tutorial#_configure-and-run-the-debugger

VSCode debugger conditional breakpoints https://stackoverflow.com/questions/43311058/vscode-debugger-conditional-breakpoints || VSCode调试器条件断点 https://www.thinbug.com/q/43311058
- > https://code.visualstudio.com/docs/editor/debugging#_conditional-breakpoints

VSCODE设置命令行参数，带参数调试程序（python的argv） https://blog.csdn.net/Wuli_jiejie/article/details/98342731

***--------------------------------------------------分割线--------------------------------------------------***

# vscode for latex

VS Code 与 LaTeX 真乃天作之合 https://www.jianshu.com/p/57f8d1e026f5

# vscode others

code-server -- VS Code in the browser https://github.com/cdr/code-server/
- Install https://github.com/cdr/code-server/blob/main/docs/install.md 【`-->` 没有用仓库首页 README.md 里的一句脚本的安装方式，而是用了这个页面的安装方式。】
- issues：
  * How to exit from code-server #1257 https://github.com/cdr/code-server/issues/1257

在 Kubernetes 集群上部署 VSCode https://www.qikqiak.com/post/deploy-vscode-on-k8s/

# vscode issues

## 当仓库里文件数量过多时，修改代码时无法被vscode “watch”和显示出来

"Visual Studio Code is unable to watch for file changes in this large workspace" (error ENOSPC) https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
- > The limit can be increased to its maximum by editing `/etc/sysctl.conf` (except on Arch Linux, read below) and adding this line to the end of the file:
  ```console
  fs.inotify.max_user_watches=524288
  ```
- > Another option is to exclude specific workspace directories from the VS Code file watcher with the `files.watcherExclude` [setting](https://code.visualstudio.com/docs/getstarted/settings).

# vscode插件

## 插件官方市场

### 官方出品
- Remote - SSH https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh
- Live Share https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare

### 个人
- Markdown All in One https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one
- Bracket Pair Colorizer 2 https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2

## 插件相关攻略

VS Code 变身小霸王游戏机！ - 韩骏的文章 - 知乎 https://zhuanlan.zhihu.com/p/266374993

完美解决 vscode gitlens 左侧导航图标不显示 https://blog.csdn.net/wangqiaojie/article/details/112509214
