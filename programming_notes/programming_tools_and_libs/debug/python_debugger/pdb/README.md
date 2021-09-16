
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

How To Use the Python Debugger https://www.digitalocean.com/community/tutorials/how-to-use-the-python-debugger

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧 https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/
