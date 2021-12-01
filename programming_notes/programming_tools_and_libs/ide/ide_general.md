
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

***--------------------------------------------------分割线--------------------------------------------------***

## Thonny

2018新增开源软件最受欢迎Top 50 - Open Source 开源 - cnBeta.COM https://www.cnbeta.com/articles/soft/812345.htm
> 适合初学者的 Python IDE Thonny https://www.oschina.net/p/thonny

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for TeX/LaTeX

TexStudio / TexMaker and Github https://tex.stackexchange.com/questions/112396/texstudio-texmaker-and-github


# Online IDEs

Papeeria -- LaTeX and Markdown online https://www.papeeria.com/
