
# General IDEs

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

## CLion

使用Clion优雅的完全远程自动同步和远程调试c++ https://www.cnblogs.com/qiumingcheng/p/11185073.html || https://cloud.tencent.com/developer/article/1406250

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for Go

Golang Guide: A List of Top Golang Frameworks, IDEs & Tools https://intelligentbee.com/2017/08/14/golang-guide-list-top-golang-frameworks-ides-tools/
- Integrated Development Environment (IDEs) for Golang
  * 4.Wide
    + 🌈 一款基于 Web 的 Go 语言 IDE，随时随地玩 golang。 https://wide.b3log.org/ || https://hacpai.com/tag/wide || https://github.com/b3log/wide

## [GoLand](https://www.jetbrains.com/go/)

IDE 怎么同时高亮多个变量，进行跟踪，比如 Goland、IDEA 等工具？ https://www.v2ex.com/t/762213
- > `Command/Ctrl + Shift + F7`
  >> https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf 第一页，第三列，倒数第八个就是，一楼正确的

请教 Go Mod 到底怎么用...被虐哭.. https://www.v2ex.com/t/582361

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

### Jupytext 

Jupytext https://github.com/mwouts/jupytext
- > Have you always wished Jupyter notebooks were plain text documents? Wished you could edit them in your favorite IDE? And get clear and meaningful diffs when doing version control? Then... Jupytext may well be the tool you're looking for!
- > Jupytext can save Jupyter notebooks as
  * Markdown and R Markdown documents,
  * Scripts in many languages.

***--------------------------------------------------分割线--------------------------------------------------***

## IDE pycharm

### pycharm in cloud-native

使用 PyCharm、Okteto 和 Kubernetes 搭建远程开发环境 https://www.qikqiak.com/post/remote-deploy-env-with-okteto/

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

## Thonny

2018新增开源软件最受欢迎Top 50 - Open Source 开源 - cnBeta.COM https://www.cnbeta.com/articles/soft/812345.htm
> 适合初学者的 Python IDE Thonny https://www.oschina.net/p/thonny

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for TeX/LaTeX

TexStudio / TexMaker and Github https://tex.stackexchange.com/questions/112396/texstudio-texmaker-and-github


# Online IDEs

Papeeria -- LaTeX and Markdown online https://www.papeeria.com/
