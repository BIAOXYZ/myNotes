
# Jupter官网

- https://jupyter-notebook.readthedocs.io/en/latest/
- http://jupyter.org/documentation
- https://nbviewer.jupyter.org/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Jupter general

jupyter notebook 可以做哪些事情？ - 知乎 https://www.zhihu.com/question/46309360
- jupyter notebook 可以做哪些事情？ - 猴子的回答 - 知乎 https://www.zhihu.com/question/46309360/answer/254638807

数据分析为什么常用Jupyter而不是直接使用Python脚本或Excel? - 知乎 https://www.zhihu.com/question/37490497
- 数据分析为什么常用Jupyter而不是直接使用Python脚本或Excel? - Michael翔的回答 - 知乎 https://www.zhihu.com/question/37490497/answer/101293910
  * > "如果通过github + nbviewer.jupyter.org/ 还能将.ipynb文件可视化的分享给别人"

你真的会用Jupyter吗？这里有7个进阶功能助你效率翻倍 https://mp.weixin.qq.com/s/N6DTOCGKU7cy3n9EmdLoCw

Jupyter Notebook介绍、安装及使用教程 - 豆先生的文章 - 知乎 https://zhuanlan.zhihu.com/p/33105153

[译] 给初学者的 Jupyter Notebook 教程 https://juejin.cn/post/6844903605372190733

史上最详细、最完全的jupyter notebook使用教程，Python使用者必备！——ipython系列之三 https://blog.csdn.net/qq_27825451/article/details/84427269

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 已实践过的Jupyter Notebook教程

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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 未实践过的Jupyter Notebook教程

如何在Jupyter Notebook中使用Python虚拟环境？ - 王树义的文章 - 知乎 https://zhuanlan.zhihu.com/p/29564719

Jupyter notebook远程访问服务器 https://blog.csdn.net/a819825294/article/details/55657496
