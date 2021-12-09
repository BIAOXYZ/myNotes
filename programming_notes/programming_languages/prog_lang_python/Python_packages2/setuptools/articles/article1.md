
# 1

【[:star:][`*`]】 编写 python package 中的 setup.py 文件 https://www.jianshu.com/p/9a5e7c935273
- > **引言**
  * > 之前我们项目组在使用 python 的过程中，经常遇到用 `pip install -e .` 的方式安装 python package 的情况，这些 package 中都有一个 `setup.py` 文件，里面指定了 package 的依赖、描述性的信息等。
  * > 但是我们从来没有为自己的 package 写过类似的 `setup.py` 文件。如果需要在程序中调用自己写的 package，一般是设定环境变量 `PYTHONPATH` 或者在 python 程序中设置 `sys.path` 来具体指定 package 的搜索路径。如果只是在本地调用自己的 package，路径相对固定，这种方式也没什么问题，如果要将 package 分享给别人甚至分享到 PyPI 上，这种路径设置的方式就有些简陋了。如果我们为 package 编写了 `setup.py` 文件，那么 package 路径的问题、依赖的问题以及描述性的信息管理就可以交给 `pip` (package installer for Python) 处理。 用户只需要通过 `pip install -e .` 的方式安装即可。
  * > 在学习编写 `setup.py` 文件的过程中，我们感觉[这篇文章](https://blog.godatadriven.com/setup-py)讲解的非常透彻，所以将它的内容整理总结出来，目的是方便以后自己和其他研究人员参考。
- > **一个简单的 package 例子**
  * > 如果还不太了解 module 和 package 的概念和用法，可以参考 [python 官方的 tutorial](https://docs.python.org/3/tutorial/modules.html#modules)。
  * > 在这里我们先创建一个文件夹 `setuppy_tutorial`，后边所有的操作都在这个文件夹中进行。假设在这个文件夹中有一个 package 名为 `greeting_pkg`，文档路径结构如下：
    ```console
    .
    └── greeting_pkg
        ├── greeting_module.py
        └── __init__.py
    ```
    > 其中 `__init__.py` 为空文件，`greeting_module.py` 文件内容如下：
    ```py
    def greeting_func(name):
        print("Hello, ", name)
    ```
    > 也就是说，这个 `greeting_pkg` package 包含一个 module 文件 `greeting_module.py`，其中的函数 `greeting_func` 可以打印出输入的名字并问候。
  * > 例如，当 `greeting_pkg` package 处于当前目录时，进入 python 环境，调用 module 并执行其中的函数：
    ```py
    $ python
    >>> from greeting_pkg.greeting_module import greeting_func
    >>> greeting_func("De Gang")
    Hello,  De Gang
    ```
    > 如果 `greeting_pkg` package 没有处于当前目录，在调用 module 时就会出现如下路径错误
    ```py
    >>> from greeting_pkg.greeting_module import greeting_func
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ModuleNotFoundError: No module named 'greeting_pkg'
    ```
  * > python 搜索 module 的路径由 `sys.path` 决定，可以通过如下命令查看（这里用了虚拟环境，名称为 testsetuppy）：
    ```py
    >>> import sys
    >>> print('\n'.join(sys.path))
    
                <--- 这里有空字符串
    /home/automan/pyenv/testsetuppy/lib/python36.zip
    /home/automan/pyenv/testsetuppy/lib/python3.6
    /home/automan/pyenv/testsetuppy/lib/python3.6/lib-dynload
    /usr/lib/python3.6
    /home/automan/pyenv/testsetuppy/lib/python3.6/site-packages
    ```
    > 显示的路径列表中包括：
      + > 1.当前路径 (以空字符串表示)
      + > 2.`PYTHONPATH` 中的路径（如果没有设置环境变量 PYTHONPATH，这一项就不存在）
      + > 3.与 python 安装位置相关的其他路径
    > 可以在 python 程序中扩展 `sys.path` 中的路径，如果自己编写的 module 不在上述 `sys.path` 路径中，就会出现找不到 module 的错误。
    > 
    > `setup.py` 文件的作用之一是提供了一种通过 `pip` 标准化安装 package 的方式，避免了额外设置路径的麻烦。
- > **添加一个最简洁的 `setup.py` 文件**
  * > 在刚才的 `setuppy_tutorial` 文件夹中 (即与 `my_greetings` package 在同一目录中) 编写如下的 `setup.py` 文件：
    ```py
    from setuptools import setup, find_packages
    
    setup(
        name='greeting_pkg',
        packages=find_packages()
    )
    ```
    > 其中，`name` 是在 pip 中注册的名字（如果我们将这个 package 分享到 PyPI，必须保证这个名字与 PyPI 中已有 package 注册的名字不重复），***与 package 文件夹的名字可以不同，但一般只要不涉及到重名，最好用与 package 相同的名字，方便用户记忆***。`packages` 后边跟的是这个 package 的名字以及它内部的 subpackage 的名字，这里我们只有 `greeting_pkg` 一个 package。
  * > 现在文档路径结构如下：
    ```console
    .
    ├── greeting_pkg
    │   ├── greeting_module.py
    │   └── __init__.py
    └── setup.py
    ```
    > 用如下命令安装这个 package
    ```py
    pip install -e .
    ```
    > 确认一下是否安装成功：
    ```sh
    $ pip list
    
    Package       Version Location                 
    ------------- ------- -------------------------
    greeting-pkg  0.0.0   /home/automan/setuppy_tutorial
    pip           19.2.1  
    pkg-resources 0.0.0   
    setuptools    41.0.1  
    wheel         0.33.4  
    ```
    > 此时我们的 package `greeting-pkg` ***可以像其他通过 `pip` 安装的 package 一样使用，不必考虑路径问题***。
  * > 这里再回头说一下 `pip install -e .` 安装命令，其中参数 `-e` 表示以 editable 方式安装，这样对于原 python 文件的改动可以直接反映到安装的 package 中，不必重新安装。
  * > 例如，将 `greeting_module.py` 文件改成如下内容：
    ```py
    def greeting_func(name):
        print("Cheers, ", name)    # "Cheers" 替换了原本的 "Hello"
    ```
    > 再调用该 module 时效果如下：
    ```py
    $ python
    >>> from greeting_pkg.greeting_module import greeting_func
    >>> greeting_func("De Gang")
    Cheers,  De Gang   # 马上反映了对原 python 文件的修改
    ```
- > **扩展 `setup.py`**

# 其他

Python打包分发工具setuptools https://juejin.cn/post/6844903906158313485

Python打包之setuptools https://www.cnblogs.com/Zzbj/p/11535625.html
