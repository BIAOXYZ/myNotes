
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

mac下vscode快捷键 https://www.jianshu.com/p/5c71b9fd7485
- > **通用快捷键**
  ```console
  ⇧⌘P, F1 显示控制台
  ⌘P 快速打开，快速查找并进入文件
  ⇧⌘N 新建窗口(不是文件)
  ⌘W 关闭窗口
  ```
  >> 【[:star:][`*`]】 //notes：尤其是 `⌘ + P` 快速查找文件好用。

【[:star:][`*`]】 VS Code 高级使用技巧整理 https://medium.com/@idtimw/vs-code-%E9%AB%98%E7%BA%A7%E4%BD%BF%E7%94%A8%E6%8A%80%E5%B7%A7%E6%95%B4%E7%90%86-c34509846502 || https://idtimw.com/vs-code-gao-ji-shi-yong-ji-qiao-zheng-li/
- > **多光标选择**
  ```console
  Mac: opt+cmd+up or opt+cmd+down
  Windows: ctrl+alt+up or ctrl+alt+down
  Linux: alt+shift+up or alt+shift+down
  ```
- > **文件内快速定位**
  ```console
  Mac: cmd+shift+o
  Windows / Linux: ctrl+shift+o
  ```
  >> 【[:star:][`*`]】 //notes：查找函数和类，并快速跳转过去。估计查找其他的也会方便很多～
- > **在项目内快速定位**
  ```console
  Mac: cmd+t
  Windows / Linux: ctrl+t
  ```
- > **跳转到指定行**
  ```console
  Mac: ctrl+g or cmd+p, :
  Windows / Linux: ctrl+g
  ```
- > **返回光标位置**
  ```console
  Mac: cmd+u
  Windows / Linux: ctrl+u
  ```
- > **代码格式化 当前选中代码**
  ```console
  Mac: cmd+k, cmd+f
  Windows / Linux: ctrl+k, ctrl+f
  ```
- > **跳转到文件顶部/尾部**
  ```console
  Mac: cmd+up and cmd+down
  Windows: ctrl+up and ctrl+down
  Linux: ctrl+home and ctrl+end
  ```
  >> //notes：其实本来只是想找这个功能，无意间发现了更多～

## 打开配置文件 `setting.json`

User and Workspace Settings https://code.visualstudio.com/docs/getstarted/settings
- > **Creating User and Workspace Settings** <br> To open your user and workspace settings, use the following VS Code menu command:
  ```console
  On Windows/Linux - File > Preferences > Settings
  On macOS - Code > Preferences > Settings
  ```

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
>> 【[:star:][`*`]】 //notes：补充：在Mac下快捷键为：`Option + Z`

## 向下复制一行代码

vscode 向下复制当前行（即visual studio 中的Ctrl + D）功能快捷键 https://blog.csdn.net/haihui1996/article/details/87937912
```console
打开vscode左下角键盘快捷键设置，找到copy line down，即可查看当前默认快捷键为“shift + Alt + ↓”

双击快捷键，输入自己想要的快捷组合，如Ctrl+D，然后回车即可设置自己的组合了
```
>> 【[:star:][`*`]】 //notes：补充：在Mac下快捷键为：`Shift + Option + ↓`
>>> //notes2：向上复制一行的话之需要把方向键换成向上即可（但是用处不大- -）。

## 代码块整体左移右移

```
多行代码同时左移一个tab键（等于 `选中要移动的代码然后 shift + tab`）
ctrl+[

多行代码同时右移一个tab键（等于 `选中要移动的代码然后 tab`）
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
>> //notes：`1、按住alt，用鼠标左键点击，可以出现多个光标，输入的代码可以在光标处同时增加。`  -->  Mac下对应的方法为把 `alt` 换成 `option`（`⌥`） 即可。

VSCode 又酷又实用的多光标编辑 https://www.v2ex.com/t/843239 || https://github.com/tjx666/blog/blob/07ed16b474dfad7a0ba2142c8c4f805645914315/src/VSCode%E5%8F%88%E9%85%B7%E5%8F%88%E5%AE%9E%E7%94%A8%E7%9A%84%E5%A4%9A%E5%85%89%E6%A0%87%E7%BC%96%E8%BE%91.md

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

## 拖拽条颜色修改

vscode拖拽条看不清配色修改 https://blog.csdn.net/qq_43243842/article/details/125718175
```json
    "workbench.colorCustomizations": {
        "scrollbarSlider.background": "#bba76d",
        "scrollbarSlider.hoverBackground": "#cfb56a",
        "scrollbarSlider.activeBackground": "#fbdd86"
    }
```

## 关闭引号的自动补全（其实主要是为了关闭``的自动补全）
>> //notes：实际上没有改配置文件，而是 `Preferences` --> `Settings` --> 搜索关键词 quote --> `Editor: Auto Closing Quotes` 值选择 `never` 即可。

Autoclose single and double quotes vscode https://stackoverflow.com/questions/45808557/autoclose-single-and-double-quotes-vscode
- https://stackoverflow.com/questions/45808557/autoclose-single-and-double-quotes-vscode/56130328#56130328
  * > It's worth noting that vscode has a separate editor setting for auto closing quotes from that of brackets. If you have: `"editor.autoClosingQuotes": "never"` in your settings, then vscode will never close quotes. On the other hand, if you have `"editor.autoClosingQuotes": "always"`, then it will always add the extra closing quote.

## vscode每个工作空间单独主题

Different theme per window in Visual Studio Code https://stackoverflow.com/questions/52514491/different-theme-per-window-in-visual-studio-code || VS Code: different color themes for different projects https://dev.to/mkubdev/visual-studio-code-different-color-themes-for-different-projects-467k
- > Navigate to `File > Preferences > Settings`
- > Select the `Workspace Settings` tab at the top of the settings screen. Anything you edit in here will now be specific to this workspace.
- > Search for `colorTheme` and select the color theme you would like for this specific workspace.

## 【[:star:][`*`]】 vscode文件标签栏折叠

vscode 文件标签栏多行显示 https://blog.csdn.net/mj475002864/article/details/115456004
- > 设置步骤
  * > 按住 `ctrl + shift + p`
  * > 输入 `open workspace settings` 选择打开工作区设置
  * > 输入 `workbench.editor.wrapTabs`，勾选该设置项即可

## vscode对比文件（diff文件）

How to do a Diff in VS Code (Compare Files) https://vscode.one/diff-vscode/
- > **Diff from Explorer Panel**
  * > 1.Right click the first file and "Select for Compare"
  * > 2.Right click on the second file and "Compare with Selected"
  * > Note: you can also `CTRL-select both files`, right click on one, and select "Compare Selected" to achieve the same thing
  >> 【[:star:][`*`]】 //notes：在这一部分里提到的“选择文件”，都是指从最左边的 `EXPLORER` 面板中去选择文件。另外最后 Note 部分的方法更方便。
- > **Diff from command line**
  * > This is convenient if you want to build up muscle memory of typing out the commands into the terminal. Here's how to do it.
    ```sh
    code --diff file1.js file2.js
    ```

## vscode显示所有函数

vscode左下角显示大纲（显示所有函数方法） https://blog.csdn.net/shuipaopaoJin/article/details/95939081

## 不小心关闭了c/c++代码错误提示（error squiggles），如何重新启用

How can I re-enable error squiggles? #2546 https://github.com/Microsoft/vscode-cpptools/issues/2546
- https://github.com/Microsoft/vscode-cpptools/issues/2546#issuecomment-502875688
- https://github.com/Microsoft/vscode-cpptools/issues/2546#issuecomment-584231109

## 移除最近打开的目录

How to delete recent opened file session on Visual Studio Code? https://stackoverflow.com/questions/37111181/how-to-delete-recent-opened-file-session-on-visual-studio-code

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode未验证技巧

***--------------------------------------------------分割线--------------------------------------------------***

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode for C/C++

Visual Studio Code 如何编写运行 C、C++ 程序？ - 知乎 https://www.zhihu.com/question/30315894

万字长文把 VSCode 打造成 C++ 开发利器 - 腾讯技术工程的文章 - 知乎 https://zhuanlan.zhihu.com/p/96819625

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode for python

VSCode基础使用+VSCode调试python程序入门 https://blog.csdn.net/u013600225/article/details/52971528

vscode - 设置 Python 版本 https://blog.csdn.net/Marryvivien/article/details/113487151
```console
使用快捷键 Ctrl+Shift+P 打开命令窗口:
选择 “Python: Select Interpreter”，弹窗显示现有的 Python 版本:
回车选择需要的Python 版本即可。
```
>> //notes：本来选择 Python 解释器在 vsc 界面最下方点一下就行，但是有时候（or 有的版本？）最下面不出现这个让你选择解释器的选项。。。

## vsc and conda

VS Code终端环境错误造成问题 -- 文件无法编译并且终端无任何显示 https://hbaaa.github.io/2020/05/30/vscode%E7%BB%88%E7%AB%AF%E6%B2%A1%E6%9C%89%E4%BB%BB%E4%BD%95%E5%86%85%E5%AE%B9/
- > We noticed you’re using a conda environment. If you are experiencing issues with this environment in the integrated terminal, we recommend that you let the Python extension change “terminal.integrated.inheritEnv” to false in your user settings. 我们注意到您正在使用conda环境。 如果您在集成终端中遇到此环境问题，建议您在用户设置中让Python扩展名将“ terminal.integrated.inheritEnv”更改为false。

python extension that recommends terminal.integrated.inheritEnv: false causes Terminal to fail on Linux #14464 https://github.com/microsoft/vscode-python/issues/14464

Add prompt to flip "inheritEnv" setting to false to fix conda activation issue #7607 https://github.com/microsoft/vscode-python/issues/7607

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

VSCode -- how to set working directory for debugging a Python program https://stackoverflow.com/questions/38623138/vscode-how-to-set-working-directory-for-debugging-a-python-program
- https://stackoverflow.com/questions/38623138/vscode-how-to-set-working-directory-for-debugging-a-python-program/55072246#55072246
  * > In `launch.json`, specify a dynamic working directory (i.e. the directory where the currently-open Python file is located) using:
    ```json
    "cwd": "${fileDirname}"
    ```

***--------------------------------------------------分割线--------------------------------------------------***

## vsc Python test

Python testing in Visual Studio Code https://code.visualstudio.com/docs/python/testing
- > **Configure tests**
  * > If both frameworks are enabled, then the Python extension will only run `pytest`.
    >> 【[ :star: ][`*`]】 //notes：这是我成功的（用 unittest 而不用 pytest）一个配置。
    ```conf
    {
        "python.testing.unittestArgs": [
            "-v",
            "-s",
            "./tests",
            "-p",
            "test_*.py"
        ],
        "python.testing.pytestEnabled": false,
        "python.testing.unittestEnabled": true
    }
    ```
- > **Test discovery**

Visual Studio Code test sidebar button disappeared https://stackoverflow.com/questions/67071773/visual-studio-code-test-sidebar-button-disappeared

## vsc Python Linting

Linting Python in Visual Studio Code https://code.visualstudio.com/docs/python/linting
- > **Enable linters**
  * > To enable linters, open the Command Palette (`⇧⌘P`) and select the **Python: Select Linter** command. This command adds `"python.linting.<linter>Enabled": true` to your settings, where `<linter>` is the name of the chosen linter.
- > **Run linting**
  * > To perform linting:
    + > Linting runs automatically when you save a file.
    + > Open the Command Palette (`⇧⌘P`), then enter and select **Python: Run Linting**.
  * > Issues are shown in the **`Problems`** panel and as underlines in the code editor. Hovering over an underlined issue displays the details:

其他参考链接：
- VS Code | 配置 flake8 和 yapf https://www.jianshu.com/p/53cd688185af

**主要参考官方的就行，简书那个链接不是很需要。总体过程如下**：
1. 安装flake8：`python3 -m pip install -U flake8` （有的时候是你先 **Enable linters** 后，vsc 就会提示你是否安装，然后点击就可以安装了，也是走的这个命令。图片就跟官方文档 **Enable linters** 部分的那个配图是一样的）
2. 启用linter：参见官方 **Enable linters** 部分。
3. 使用linter：参见官方 **Run linting** 部分。其实启用后只要一保存文件，下面的窗口 `PROBLEMS` 就会出现提示了。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode for latex

VS Code 与 LaTeX 真乃天作之合 https://www.jianshu.com/p/57f8d1e026f5

vscode 写 LaTeX 可否做到代码与预览滚动同步？ https://www.v2ex.com/t/784233
- > LaTeX 请用 TeXStudio，可以按行定位到 PDF
- > vs code 的话推荐试试 tex workshop 。虽然不能自动滚动，但可以快捷键同步位置。一键编译什么的也很好用。
- > 正反向定位一直都有啊，tex-workshop，记得把 synctex 打开就行，ctrl+左键反向定位，编译的时候正向定位

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
