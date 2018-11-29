

# General IDEs

## [Visual Studio Code](https://github.com/Microsoft/vscode)|(https://code.visualstudio.com/)

How to close an opened folder in Visual Studio Code https://stackoverflow.com/questions/30028469/how-to-close-an-opened-folder-in-visual-studio-code/37549173
> The command to close the currently opened folder can be found from `File` -> `Close Folder`. You can also use the shortcut: Ctrl+K F

***--------------------------------------------------分割线--------------------------------------------------***

vscode golang配置说明 https://www.cnblogs.com/nickchou/p/9038114.html
```
vscode也可以通过ctrl+shift+p运行命令一次性安装所有这些工具
Go: Install/Update Tools
```

***--------------------------------------------------分割线--------------------------------------------------***

VSCode基础使用+VSCode调试python程序入门 https://blog.csdn.net/u013600225/article/details/52971528

***--------------------------------------------------分割线--------------------------------------------------***


## [Atom - The hackable text editor](https://github.com/atom/atom)|(https://atom.io/)

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# IDEs for C/C++


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for Go


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# IDEs for Java

## [Eclipse](https://github.com/eclipse)

Eclipse教程 http://www.runoob.com/eclipse/eclipse-tutorial.html

Eclipse使用技巧 - 2. Eclipse自动补全功能轻松设置 https://blog.csdn.net/u012812482/article/details/51121377

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


## [IntelliJ IDEA](https://github.com/JetBrains/intellij-community)

This is a tutorial of IntelliJ IDEA, you can know how to use IntelliJ IDEA better and better. https://github.com/guobinhit/intellij-idea-tutorial

## Maven

Maven 项目构建基础 - 王下邀月熊的文章 - 知乎 https://zhuanlan.zhihu.com/p/28371336

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for Python


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# IDEs for TeX/LaTeX

TexStudio / TexMaker and Github https://tex.stackexchange.com/questions/112396/texstudio-texmaker-and-github


# Online IDEs

Papeeria -- LaTeX and Markdown online https://www.papeeria.com/
