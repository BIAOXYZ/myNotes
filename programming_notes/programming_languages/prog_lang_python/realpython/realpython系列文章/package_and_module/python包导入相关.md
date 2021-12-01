
Python 3.x | 史上最详解的 导入（import） https://blog.csdn.net/weixin_38256474/article/details/81228492
- > 在使用相对导入时，可能遇到ValueError: Attempted relative import beyond toplevel package <br> 解决方案：参考这篇文章，[链接]()。
  >> 解决python相对导入出现错误：Attempted relative import beyond toplevel package https://blog.csdn.net/SKY453589103/article/details/78863050

import 问题浅谈 - 程序员阿德的文章 - 知乎 https://zhuanlan.zhihu.com/p/69099185
- > `sys.path.append(os.path.dirname(__file__))` 表示的含义如下：
  * > 使用 `sys.path.append` 将某路径添加到 `sys.path` 中。
  * > `__file__` 获得该模块文件的绝对路径
  * > `os.path.dirname(__file__)` 获得模块文件所在的目录

10.9 将文件夹加入到sys.path https://python3-cookbook.readthedocs.io/zh_CN/latest/c10/p09_add_directories_to_sys_path.html

终于搞懂了Python模块之间的相互引用问题 - 华为云开发者社区的文章 - 知乎 https://zhuanlan.zhihu.com/p/349407590

python import 问题 https://skrlamei.github.io/blog/torch%E7%BC%96%E7%A8%8B/python%20import%E9%97%AE%E9%A2%98/
- > 解决方法¶ 人工添加绝对路径
  * > 添加dnri这个包所在的路径
    ```py
    import sys
    sys.path.insert(0,'/home/wbq/code_demo/dNRI')
    ```
  * > 稍微进阶一点，用个函数判断
    ```py
    parent_path = os.path.dirname(sys.path[0]) #/home/wbq/code_demo/dNRI/dnri
    print(parent_path)
    if parent_path not in sys.path:
        sys.path.insert(0,parent_path)

    import train_utils
    import utils.misc as misc    #不能用import dnri.utils.misc as misc,　因为dnri的路径在dNRI下
    ```
>> //notes：个人实战用的是这句（目的好像是为了使用父目录的module）：
```py
import sys,os
# print("sys.path[0] is: ", sys.path[0])
parent_path = os.path.dirname(sys.path[0])
sys.path.append(parent_path)
```

Python import常见用法 & 父目录引用子目录py文件 & 子目录引用父目录py文件 https://blog.csdn.net/d200746/article/details/103530943
- > 测试工程目录结构：
  ```sh
  $ tree
  .
  ├── module_1
  │   ├── test_import_2.py
  │   └── test.py
  ├── module_2
  │   ├── test_import_3.py
  │   └── test.py
  ├── test_import_0.py
  └── test_import_1.py
  
  2 directories, 6 files
  ```
- > **总结起来两句话**：
  * > 若要引用子目录上的py文件（例如 `test_import_1.py` 要引用 `module_1文件夹` 下的 `test_import_2.py`），需要***将被引文件所在目录升级为为模块***，即在被引文件的目录下创建 `__init__.py`。
  * > 若要引用父目录上的py文件（例如 `test_import_2.py` 要引用 `父目录文件夹` 下的 `test_import_1.py`），需要***将该父目录添加到当前文件的 `sys.path` 中***。

[Python]解决python3中关于import的疑难杂症 https://segmentfault.com/a/1190000039773026

python import 详解 https://www.jianshu.com/p/dacbed54d063

# 绝对（路径）导入 V.S. 相对（路径）导入

python相对路径引用问题的解决 - 陈生的文章 - 知乎 https://zhuanlan.zhihu.com/p/78498638
- > **4.One More Thing**
  * > 当你读到这里，已经理解了造成上述问题的原因之后，你应该还能想到另一种解决办法 —— 告诉python解释器额外的路径信息。具体做法就是将路径添加到 `sys.path` 中：
    ```py
    # from utils.evaluation_utils xx
    # raise ERROR 
    >>> import sys
    >>> import os

    # your project dir
    >>> PROJ_DIR = 'xxxx'

    # append to sys.path
    >>> sys.path.append(os.path.join(PROJ_DIR, 'nmt'))

    # no ERROR
    from nmt.utils.evaluation_utils xx
    ```
>> 【[:star:][`*`]】 //notes：添加到 `sys.path` 是个司空见惯的手段，不足为奇。但是项目比较复杂时要添加的太多了。我是看了这人上面这段示例代码，想到可以只把项目根目录添加到 `sys.path`，然后后面所有的项目相关导入都用绝对路径的导入形式。PS：相对（路径）导入虽然看起来更美观些，但是容易出错，还是尽量用绝对（路径）导入吧。

Python：相对导入与绝对导入（import）、os.path、__file__ https://www.cnblogs.com/qi-yuan-008/p/12833189.html

# from stackexchange.com

Relative imports - ModuleNotFoundError: No module named x https://stackoverflow.com/questions/43728431/relative-imports-modulenotfounderror-no-module-named-x
- https://stackoverflow.com/questions/43728431/relative-imports-modulenotfounderror-no-module-named-x/43859946#43859946

Import a module from a relative path https://stackoverflow.com/questions/279237/import-a-module-from-a-relative-path

Relative imports in Python 3 https://stackoverflow.com/questions/16981921/relative-imports-in-python-3

How to list imported modules? https://stackoverflow.com/questions/4858100/how-to-list-imported-modules

__init__.py is not turning the module into a package https://stackoverflow.com/questions/59915710/init-py-is-not-turning-the-module-into-a-package

How to import a module given the full path? https://stackoverflow.com/questions/67631/how-to-import-a-module-given-the-full-path
