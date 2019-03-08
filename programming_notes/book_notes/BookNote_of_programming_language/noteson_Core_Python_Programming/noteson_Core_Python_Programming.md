
# general info

- Core Python Programming https://book.douban.com/subject/1874839/
- Python核心编程（第二版） https://book.douban.com/subject/3112503/
- Python 核心编程 第二版 https://legacy.gitbook.com/book/wizardforcel/core-python-2e/details

**PS: 这本书第一版情况不明。但是第三版还不如第二版，所以大家基本都是看第二版。**

# [第1章　欢迎来到Python世界](https://wizardforcel.gitbooks.io/core-python-2e/content/3.html)

### 1.3.12　解释性和（字节）编译性

> 当源文件被解释器加载或者显式地进行字节码编译的时候会被编译成字节码。由于调用解释器的方式不同，源文件会被编译成带有.pyc或.pyo扩展名的文件，你可以在第12章学到更多的关于扩展名的知识。

### 1.5.2　从命令行启动脚本

> Unix平台还可以在不明确指定Python解释器的情况下，自动执行Python解释器。如果你使用的是类Unix平台，你可以在你的脚本的第一行使用shell魔术字符串（“sh-bang”）。
>> `!/usr/local/bin/python`  -->  注：这三个例子最前面都少了个`#`吧。。。
>
> 有一个更好的方案，许多Unix系统有一个命令叫env，位于/bin或/usr/bin中。它会帮你在系统搜索路径中找到python解释器。如果你的系统拥有env，你的启动行就可以改为下面这样。
>> `!/usr/bin/env python`
>
> 或者，如果你的env位于/bin的话，
>> `!/bin/env python`


