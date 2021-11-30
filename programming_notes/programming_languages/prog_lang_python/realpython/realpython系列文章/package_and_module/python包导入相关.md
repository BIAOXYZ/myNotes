
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

# from stackexchange.com

Relative imports - ModuleNotFoundError: No module named x https://stackoverflow.com/questions/43728431/relative-imports-modulenotfounderror-no-module-named-x
- https://stackoverflow.com/questions/43728431/relative-imports-modulenotfounderror-no-module-named-x/43859946#43859946

Import a module from a relative path https://stackoverflow.com/questions/279237/import-a-module-from-a-relative-path

Relative imports in Python 3 https://stackoverflow.com/questions/16981921/relative-imports-in-python-3
