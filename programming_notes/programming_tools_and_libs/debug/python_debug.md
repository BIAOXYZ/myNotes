
# PDB

`26.2. pdb — The Python Debugger` https://docs.python.org/2/library/pdb.html

<<用PDB库调试Python程序>> http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧 https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/

# PuDB

PuDB: a console-based visual debugger for Python https://github.com/inducer/pudb

# 其他

Cyberbrain: Python debugging, redefined. https://github.com/laike9m/Cyberbrain
- > Cyberbrain consists of a Python library and various editor/IDE integrations. Currently it supports VS Code and Gitpod. See our plan on expanding the support.

ApacheCN Python 译文集 https://github.com/apachecn/apachecn-python-zh
- 七、测试和调试分布式应用 （Distributed Computing with Python） https://github.com/apachecn/apachecn-python-zh/blob/8707a37451/docs/py-dist-comp/8.md || https://py.apachecn.org/#/docs/py-dist-comp/8

# 个人实战1

https://github.com/Freemanzxp/GBDT_Simple_Tutorial
>> 以该项目为例，下载好把需要的库都装好后，需要执行的语句是： `python example.py --model regression`。那么就出现了一个问题，这种程序该怎么用vscode调试？第一反应是改vscode的debug配置文件，加参数，但是目前没走通；第二个办法就是让程序不从vsc里面启动，而是先在vscode外面运行起来，然后attach上去，下面展示的就是这个过程。
>>> PS：pdb之类的调试手段不算，因为那是命令行的，那种没有太多障碍。

## 1.需要下载微软官方的 debugpy，anaconda的话只用简单的`conda install`还不行

debugpy - a debugger for Python https://github.com/microsoft/debugpy

`conda-forge / packages / debugpy 1.3.0` https://anaconda.org/conda-forge/debugpy
```sh
conda install -c conda-forge debugpy -y
```

## 2.debug用的 json 配置文件参考这俩帖子就行，其实就是官方原版

Python debug configurations in Visual Studio Code https://code.visualstudio.com/docs/python/debugging
- > **Command line debugging** 部分

VSCode调试在命令行输入的Python指令（如：带-m参数的Python指令） https://blog.csdn.net/weixin_39278265/article/details/107705492

```sh
# 如果没有 --wait-for-client，程序直接就运行到结束了。。。
$ python -m debugpy --listen 5678 example.py --model regression

# 应该用这句。
$ python -m debugpy --listen 5678 --wait-for-client example.py --model regression

# PS：看这个项目的代码，二分类和多分类就是把最后的 regression 换成 binary_cf 或 multi_cf 即可。
```
