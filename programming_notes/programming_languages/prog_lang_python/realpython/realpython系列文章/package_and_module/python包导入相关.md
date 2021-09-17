
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
