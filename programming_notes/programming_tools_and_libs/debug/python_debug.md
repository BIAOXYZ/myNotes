
# PDB

`26.2. pdb — The Python Debugger` https://docs.python.org/2/library/pdb.html

pdb --- Python 的调试器 https://docs.python.org/zh-cn/3/library/pdb.html
- > 3.7 新版功能: 内置函数 `breakpoint()`，当以默认参数调用它时，可以用来代替 `import pdb; pdb.set_trace()`。

<<用PDB库调试Python程序>> http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html
- > 用pdb调试有多种方式可选：
  * > 1.命令行启动目标程序，加上 `-m` 参数，这样调用 `myscript.py` 的话断点就是程序的执行第一行之前 `python -m pdb myscript.py`
  * > 2.在Python交互环境中启用调试
    ```py
    >>> import pdb
    >>> import mymodule
    >>> pdb.run(‘mymodule.test()’)
    ```
  * > 3.比较常用的，就是在程序中间插入一段程序，相对于在一般IDE里面打上断点然后启动debug，不过这种方式是hardcode的
    ```py
    if __name__ == "__main__":
        a = 1
        import pdb
        pdb.set_trace()
        b = 2
        c = a + b
        print (c)
    ```
    > 然后正常运行脚本，到了 `pdb.set_trace()` 那就会定下来，就可以看到调试的提示符(Pdb)了

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧 https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/

# pdb++

pdb++, a drop-in replacement for pdb https://github.com/pdbpp/pdbpp

# ipdb

Python 程序如何高效地调试？ - Rui L的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/26046582

Python 程序如何高效地调试？ - 小明的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/123220574

# PySnooper

PySnooper - Never use print for debugging again https://github.com/cool-RR/PySnooper

实时可视化Debug：VS Code 开源新工具，一键解析代码结构 - 机器之心的文章 - 知乎 https://zhuanlan.zhihu.com/p/109212146
- > 之前机器之心曾介绍过极简 DeBug 工具 [PySnooper]() ，我们只需要向感兴趣的函数增加一个装饰器，就能得到该函数的详细 log，包含哪行代码能运行、什么时候运行以及本地变量变化的确切时间等等。

Python 代码调试神器：PySnooper https://www.cnblogs.com/wongbingming/p/13974982.html

PySnooper 源码阅读 https://zdyxry.github.io/2019/04/27/PySnooper-%E6%BA%90%E7%A0%81%E9%98%85%E8%AF%BB/

# 其他

Cyberbrain: Python debugging, redefined. https://github.com/laike9m/Cyberbrain
- > Cyberbrain consists of a Python library and various editor/IDE integrations. Currently it supports VS Code and Gitpod. See our plan on expanding the support.

ApacheCN Python 译文集 https://github.com/apachecn/apachecn-python-zh
- 七、测试和调试分布式应用 （Distributed Computing with Python） https://github.com/apachecn/apachecn-python-zh/blob/8707a37451/docs/py-dist-comp/8.md || https://py.apachecn.org/#/docs/py-dist-comp/8
