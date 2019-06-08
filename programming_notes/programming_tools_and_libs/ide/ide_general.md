

# General IDEs

## [Visual Studio Code](https://github.com/Microsoft/vscode)|(https://code.visualstudio.com/)

中文版 Awesome VS Code https://github.com/formulahendry/awesome-vscode-cn

Collection of helpful tips and tricks for VS Code. https://github.com/Microsoft/vscode-tips-and-tricks

### vscode新闻

Visual Studio Code 1.26 发布，大量新特性来袭 - Microsoft Visual Studio - cnBeta.COM https://www.cnbeta.com/articles/soft/756969.htm

### vscode已验证技巧

VS Code 使用小技巧 - 赵吉彤的文章 - 知乎 http://zhuanlan.zhihu.com/p/22880087
```
- 预览markdown Ctrl+Shift+V  //所以Typora彻底没用了
- 自动保存：File -> AutoSave ，或者Ctrl+Shift+P，输入 auto
```

How to close an opened folder in Visual Studio Code https://stackoverflow.com/questions/30028469/how-to-close-an-opened-folder-in-visual-studio-code/37549173
> The command to close the currently opened folder can be found from `File` -> `Close Folder`. You can also use the shortcut: Ctrl+K F

如何让 Visual Studio Code 自动换行？ - wansho的回答 - 知乎 https://www.zhihu.com/question/35042902/answer/400070742
```
English环境下
点击菜单栏 View--> Toggle Word Wrap 选项.
或者直接 快捷键 : alt + Z
```

### vscode护眼色修改

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

### vscode连接远程服务器开发

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

***--------------------------------------------------分割线--------------------------------------------------***

### vscode for go

vscode golang配置说明 https://www.cnblogs.com/nickchou/p/9038114.html
```
vscode也可以通过ctrl+shift+p运行命令一次性安装所有这些工具
Go: Install/Update Tools
```

VS code golang 开发环境搭建 - CSDN博客 https://blog.csdn.net/hil2000/article/details/51714607
> https://github.com/golang/tools

在Visual Studio Code配置GoLang开发环境 - CSDN博客 https://blog.csdn.net/chszs/article/details/50076641
> "要注意，GoLang的安装要确保两个环境变量，一个是GOROOT环境变量；二是PATH环境变量要包含$GOROOT\bin值。"

***--------------------------------------------------分割线--------------------------------------------------***

### vscode for python

VSCode基础使用+VSCode调试python程序入门 https://blog.csdn.net/u013600225/article/details/52971528

***--------------------------------------------------分割线--------------------------------------------------***

### vscode for latex

VS Code 与 LaTeX 真乃天作之合
https://www.jianshu.com/p/57f8d1e026f5


## [Atom - The hackable text editor](https://github.com/atom/atom)|(https://atom.io/)

Atom使用纪要
http://www.cnblogs.com/Darren_code/p/atom.html

使用Atom打造无懈可击的Markdown编辑器
http://www.cnblogs.com/libin-1/p/6638165.html
> 这么一番配置后确实写markdown好叼。。。但是基本的markdown预览不如VS CODE。再加VSC的其他优势，还是选后者吧

Register as default atom:// URI handler?
https://discuss.atom.io/t/register-as-default-atom-uri-handler/50982

Facebook 宣布停止维护 Nuclide 和 Atom IDE - SNS 社交网络 - cnBeta.COM https://www.cnbeta.com/articles/tech/798313.htm

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# IDEs for C/C++


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for Go


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# IDEs for Java

## [Eclipse](https://github.com/eclipse)

Eclipse教程 http://www.runoob.com/eclipse/eclipse-tutorial.html

Eclipse使用技巧 - 2. Eclipse自动补全功能轻松设置 https://blog.csdn.net/u012812482/article/details/51121377

Eclipse详细设置护眼背景色和字体颜色并导出 https://jingyan.baidu.com/article/d5a880eb6c4f7813f147ccef.html
```
1.Windows -> Preference -> General -> Editors -> Text Editors 
2.Appearance color options -> Background color
3.勾掉System Default，点击'Color'颜色块，将出现颜色选择面板
4.色调：85。饱和度：120。亮度：208
```

Eclipse 的 Workspace 下边有一个 .metadata 的目录，是做什么用的？ https://bbs.csdn.net/topics/300034735
```
不用放到svn里。
.metadata 里保存的是你当前正在使用的eclipse的配置，包括workspace的布局、log等。
所以，.metadata 是跟项目本身无关的，只跟各自机器中的eclipse设定有关，不需要放到svn里。
别人从svn里打包项目时，就不会造成连你个人eclipse的自定义配置也打包进去了。

如果你尝试着将.metadata 删除，你的eclipse打开后，就恢复到最原始的欢迎界面了，workspace的配置在.metadata 里，被你删了。

另外，一个workspace里有可能建了多个项目，比如一个是你个人自己的练习项目，一个是公司的实际项目，你需要放到svn里的应该是
公司的项目，而不包括你个人的那个项目，这个时候，如果你把.metadata 也放到svn里，然后被别人打包到他本地上后，运行时，
会连你个人的项目里的错误或配置也报出来，或找不到项目这个你个人的项目的错误提示。
```

怎样从Eclipse当中打开一个存在的项目？ https://blog.csdn.net/samxx8/article/details/6562572
> "多么常见又难以解决的问题！我花了三天时间才解决掉。"
> "第五、在新的对话框当中，设置Select root directory为c:/test‍，也就是要导入工程的上一级目录"
```
notes: 正如作者原文里那句，其实还真是会把人绊一阵子，不过三天倒不至于。。。
总结下核心的点就是，假设你的工程代码目录结构为：
D:\projects\hyperledgerSCF\CAproject
其中.project和.classpath在CAproject文件夹中(也就是CAproject是真正的工程代码的总目录)。
这个时候eclipse的workspace一定得设置到D:\projects\hyperledgerSCF

- D：
  -- projects
    --- hyperledgerSCF
      ---- CAproject
        ----- .project
        ----- .classpath
        ----- src
        .
        .
        .
```

eclipse 创建项目报项目存在的解决方案：eclipse Invalid project name: Project "xxx" already exists.
```
因为某种原因，自己手动去删了了工作空间的某个项目，或者因为创建项目时发生异常，在eclipse上看不到某个项目的名称，但是再次新建同样的项目都会报，无效名称，项目XXX已经存在。

Invalid project name: Project "xxx" already exists.

我们可以手段去工作空间去把的项目信息路径下（workspace\.metadata\.plugins\org.eclipse.core.resources\.projects）去删除xxx这个项目的信息，然后去刷新Project Explorer，这样eclipse会自动重新构建以下项目空间，然后就真的没有了xxx这个项目了，就可以重新创建xxx这个项目了。

eclipse打开过的工程信息保存路径

workspace\.metadata\.plugins\org.eclipse.core.resources\.projects
```
***//注：其实不用刷新，全删除再重新建一下就OK。***

Eclipse调试的时候提示Source not found
- 启动debug时Source not found for Class<T>.getDeclaredMethods0(boolean) line: https://blog.csdn.net/leidijava/article/details/8625472
- https://stackoverflow.com/questions/19547535/source-not-found-when-debugging-all-projects
```
我的和第一个帖子里的情况一样，就是多打了个断点，然后这个断点涉及的类或者方法没有源码，eclipse就报这个错。把断点去掉就好了。
第二个帖子那种把相应源码下载下来的方法估计肯定也可以，但是费时间，项目没那么多时间仔细搞这些。
```

## [IntelliJ IDEA](https://github.com/JetBrains/intellij-community)

This is a tutorial of IntelliJ IDEA, you can know how to use IntelliJ IDEA better and better. https://github.com/guobinhit/intellij-idea-tutorial

## [Maven](https://github.com/apache/maven)

Maven 项目构建基础 - 王下邀月熊的文章 - 知乎 https://zhuanlan.zhihu.com/p/28371336

***第一个排版更好也更全些，但是第二个还是有些内容第一个里没有***
- Maven常用命令：https://www.cnblogs.com/wkrbky/p/6352188.html
- mvn常用命令 http://www.cnblogs.com/holly/archive/2013/06/15/3137041.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for Python

## Jupyter

### Jupter官网

- https://jupyter-notebook.readthedocs.io/en/latest/
- http://jupyter.org/documentation
- https://nbviewer.jupyter.org/

### Jupter general

jupyter notebook 可以做哪些事情？ - 知乎 https://www.zhihu.com/question/46309360
- jupyter notebook 可以做哪些事情？ - 猴子的回答 - 知乎 https://www.zhihu.com/question/46309360/answer/254638807

数据分析为什么常用Jupyter而不是直接使用Python脚本或Excel? - 知乎 https://www.zhihu.com/question/37490497
- 数据分析为什么常用Jupyter而不是直接使用Python脚本或Excel? - Michael翔的回答 - 知乎 https://www.zhihu.com/question/37490497/answer/101293910
  * > "如果通过github + nbviewer.jupyter.org/ 还能将.ipynb文件可视化的分享给别人"

你真的会用Jupyter吗？这里有7个进阶功能助你效率翻倍 https://mp.weixin.qq.com/s/N6DTOCGKU7cy3n9EmdLoCw

#### 已实践过的Jupyter Notebook教程

Jupyter Notebook 快速入门 https://www.cnblogs.com/nxld/p/6566380.html
- Jupyter notebook入门教程（上） https://blog.csdn.net/red_stone1/article/details/72858962
- Jupyter notebook入门教程（下） https://blog.csdn.net/red_stone1/article/details/72863749
> 注：第一个链接就是下面那俩链接(上)(下)综合起来了，直接看第一个就可以。之所以把那俩链接也记一下是因为一来多个备份，二来下面俩链接的作者还有不少机器学习相关的博文不错。

Jupyter notebook改变默认的的工作目录 https://blog.csdn.net/liwei1205/article/details/78818568
> 注：以我自己单位的机器修改过程为例：
```
找到配置文件的位置：
(base) C:\Users\LiangLiu>jupyter notebook --generate-config
Writing default config to: C:\Users\LiangLiu\.jupyter\jupyter_notebook_config.py

然后在对应的配置文件里进行如下修改：
## The directory to use for notebooks and kernels.
#c.NotebookApp.notebook_dir = ''
c.NotebookApp.notebook_dir = 'D:\\mytestcodes\\testpycodes'

这样就把默认工作目录改到了 D:\mytestcodes\testpycodes
```
**补充：1.后来在自己电脑上试了下，发现那句`jupyter notebook --generate-config`是必不可少的，如果不执行这句，相应目录下根本就没有`jupyter_notebook_config.py`这个配置文件————其实看语句也看出来了执行这句的目的就是为了生成一下这个配置文件。。。2.普通的windows命令行工具可能没有把`jupyter notebook`加进环境变量里，所以请用`Anaconda Prompt`执行上述命令~**


Jupyter NoteBook功能介绍 https://www.cnblogs.com/lvpengbo/p/8662290.html
```
类似于 Linux 的 Vim 编辑器，在 notebook 中也有两种模式：
    编辑模式：编辑文本和代码。选中单元并按 Enter 键进入编辑模式，此时单元左侧显示绿色竖线。
    命令模式：用于执行键盘输入的快捷命令。通过 Esc 键进入命令模式，此时单元左侧显示蓝色竖线。
如果要使用快捷键，首先按 Esc 键进入命令模式，然后按相应的键实现对文档的操作。比如切换成代码单元（Y）或 markdown 单元（M），
或者在本单元的下方增加一单元（B）。查看所有快捷命令可以按H。

--------------------------------------------------

那么如何用 Jupyter Notebook 制作幻灯片呢？首先在 notebook 的菜单栏选择 View > Cell Toolbar > Slideshow，这时在
文档的每个单元右上角显示了 Slide Type 的选项。通过设置不同的类型，来控制幻灯片的格式。有如下5中类型：
    Slide：主页面，通过按左右方向键进行切换。
    Sub-Slide：副页面，通过按上下方向键进行切换。
    Fragment：一开始是隐藏的，按空格键或方向键后显示，实现动态效果。
    Skip：在幻灯片中不显示的单元。
    Notes：作为演讲者的备忘笔记，也不在幻灯片中显示。
当编写好了幻灯片形式的 notebook，如何来演示呢？这时需要使用 nbconvert：
jupyter nbconvert notebook.ipynb --to slides --post serve
在命令行中敲入上述代码后，浏览器会自动打开相应的幻灯片

注：个人实验过程如下（因为之前已经修改过默认工作目录了）。不过有个问题是最后Ctrl+C结束不了，其它都正常。
(base) C:\Users\LiangLiu>d:
(base) D:\>cd mytestcodes\testpycodes
(base) D:\mytestcodes\testpycodes>jupyter nbconvert untitled.ipynb --to slides --post serve
[NbConvertApp] Converting notebook untitled.ipynb to slides
[NbConvertApp] Writing 282014 bytes to untitled.slides.html
[NbConvertApp] Redirecting reveal.js requests to https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.5.0
Serving your slides at http://127.0.0.1:8000/untitled.slides.html
Use Control-C to stop this server
WARNING:tornado.access:404 GET /custom.css (127.0.0.1) 0.50ms
.
```

[译]27个Jupyter Notebook小提示与技巧 https://cloud.tencent.com/developer/article/1194156

机器学习新手必看：Jupyter Notebook入门指南 https://blog.csdn.net/guleileo/article/details/80490921

关于jupyter notebook手动保存时生成的`.ipynb_checkpoints\`目录（windows下为例）：
> notes: 总结下就是，每当你手动save当前的.ipynb文件的时候（如果是自动保存的则不会生成该目录及目录中的文件），系统就会在当前目录（也就是原始文件或者说正在编辑的文件所在的目录）下新建（如果已经有这个备份了就在原来的备份之上进行，不再新建）一个名为`.ipynb_checkpoints`的目录，里面存有一个类似备份的.ipynb文件（**所以个人认为无需进行版本控制**），不过名字是原来名字加`-checkpoint`，如下所示：
```
noteson_Advanced_Mathematics_6th_edition_1st_volume.ipynb             //原始文件or正在编辑的文件
.ipynb_checkpoints\                                                   //每当手动保存就会有这个目录，及目录下的文件
    noteson_Advanced_Mathematics_6th_edition_1st_volume-checkpoint.ipynb
```
- What are Jupyter Notebook checkpoint files for? https://stackoverflow.com/questions/46421663/what-are-jupyter-notebook-checkpoint-files-for
- Should ipynb checkpoints be stored in git? https://stackoverflow.com/questions/36306017/should-ipynb-checkpoints-be-stored-in-git
  * > "Also, I use https://www.gitignore.io/ to create .gitignore files and according to them the checkpoints are temporary data." ———— 还有这种网站，专门搞.gitignore的。

#### 未实践过的Jupyter Notebook教程

如何在Jupyter Notebook中使用Python虚拟环境？ - 王树义的文章 - 知乎 https://zhuanlan.zhihu.com/p/29564719

Jupyter notebook远程访问服务器 https://blog.csdn.net/a819825294/article/details/55657496


***--------------------------------------------------分割线--------------------------------------------------***

## IDE pycharm

### pycharm日常

<<pycharm快捷键、常用设置、配置管理>> http://blog.csdn.net/pipisorry/article/details/39909057
```
Ctrl + /    行注释/取消行注释
Ctrl + Shift + F  或者连续2次敲击shift   全局查找{可以在整个项目中查找某个字符串什么的，如查找某个函数名字符串看之前是怎么使用这个函数的}
Ctrl + Y  删除当前插入符所在的行
Ctrl + G  查看当前行号、字符号 (跳转到输入的指定行)
Ctrl + D  复制选定的区域或行
```

你有哪些想要分享的 PyCharm 使用技巧？ - 知乎
https://www.zhihu.com/question/37787004

喏，你们要的 PyCharm 快速上手指南
https://zhuanlan.zhihu.com/p/26066151

### pycharm问题

Pycharm下运行程序查看每个变量的值的方法（类似于Spyder和MATLAB）
https://www.cnblogs.com/tq007/p/7285239.html


为什么用pycharm在同目录下import，pycharm会报错，但是实际可以运行？ - regin的回答 - 知乎
https://www.zhihu.com/question/52880389/answer/134369870


{linux下安装pycharm有问题，目前还没时间看}
https://stackoverflow.com/questions/27727826/problems-installing-pycharm

pycharm的configuration相关
- https://www.jetbrains.com/help/pycharm/creating-and-editing-run-debug-configurations.html
- https://www.jetbrains.com/help/pycharm/running-without-any-previous-configuring.html


***--------------------------------------------------分割线--------------------------------------------------***

## IDE Anaconda

http://python.jobbole.com/tag/anaconda/
- Anaconda使用总结 http://python.jobbole.com/86236/
- 致Python初学者：Anaconda入门使用指南 http://python.jobbole.com/87522/

<<Anaconda修改国内镜像源>>
https://jingyan.baidu.com/article/1876c8527be1c3890a137645.html

<<清华大学开源软件镜像站 - Anaconda>>
https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

### Anaconda问题解决

- anaconda没有创建启动快捷方式的解决办法
http://blog.csdn.net/w371500241/article/details/78582403

- Python，Pycharm，Anaconda等的关系与安装过程~为初学者跳过各种坑
https://www.cnblogs.com/tq007/p/7281105.html

### Anaconda安装使用

<Pycharm，Anaconda的安装，集成开发环境，包安装>
https://www.jianshu.com/p/98b2fbb3a45c

<python 科学计算 发行版 Anaconda安装使用教程>
http://blog.csdn.net/bitcarmanlee/article/details/51917642

<最省心的Python版本和第三方库管理——初探Anaconda>
https://zhuanlan.zhihu.com/p/25198543

<python anaconda 怎么安装？>
https://www.zhihu.com/question/30123965

<Anaconda介绍、安装及使用教程> https://zhuanlan.zhihu.com/p/32925500
> 7. 在“Advanced Installation Options”中不要勾选“Add Anaconda to my PATH environment variable.”（“添加Anaconda至我的环境变量。”）。因为如果勾选，则将会影响其他程序的使用。如果使用Anaconda，则通过打开Anaconda Navigator或者在开始菜单中的“Anaconda Prompt”（类似macOS中的“终端”）中进行使用。

***--------------------------------------------------分割线--------------------------------------------------***

## Thonny

2018新增开源软件最受欢迎Top 50 - Open Source 开源 - cnBeta.COM https://www.cnbeta.com/articles/soft/812345.htm
> 适合初学者的 Python IDE Thonny https://www.oschina.net/p/thonny

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for TeX/LaTeX

TexStudio / TexMaker and Github https://tex.stackexchange.com/questions/112396/texstudio-texmaker-and-github


# Online IDEs

Papeeria -- LaTeX and Markdown online https://www.papeeria.com/
