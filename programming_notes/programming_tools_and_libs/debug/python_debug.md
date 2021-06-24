
# PDB

`26.2. pdb — The Python Debugger` https://docs.python.org/2/library/pdb.html

<<用PDB库调试Python程序>> http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html
- > 用pdb调试有多种方式可选：
  * > 1.命令行启动目标程序，加上 `-m` 参数，这样调用 `myscript.py` 的话断点就是程序的执行第一行之前 `python -m pdb myscript.py`
  * > 2. 在Python交互环境中启用调试
    ```py
    >>> import pdb
    >>> import mymodule
    >>> pdb.run(‘mymodule.test()’)
    ```
  * > 3. 比较常用的，就是在程序中间插入一段程序，相对于在一般IDE里面打上断点然后启动debug，不过这种方式是hardcode的
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

## 3.一些结果（跟debug无关了，就是记一下方便后续看）

分别在该项目训练完成后和预测完成后打印一下训练数据和测试数据，方便看过程。PS：这个项目熟了以后就不用开图形了，又慢又麻烦。
```py
model.fit(data)
print(data)

model.predict(test_data)
print(test_data)
```

```sh
# 回归的
$ python example.py --model regression
   id  age  weight  label    f_0  res_1     f_1   res_2      f_2    res_3  \
0   1    5      20    1.1  1.475 -0.375  1.4375 -0.3375  1.40375 -0.30375   
1   2    7      30    1.3  1.475 -0.175  1.4575 -0.1575  1.44175 -0.14175   
2   3   21      70    1.7  1.475  0.225  1.4975  0.2025  1.51775  0.18225   
3   4   30      60    1.8  1.475  0.325  1.5075  0.2925  1.53675  0.26325   

        f_3     res_4       f_4     res_5       f_5  
0  1.373375 -0.273375  1.346037 -0.246037  1.321434  
1  1.427575 -0.127575  1.414818 -0.114818  1.403336  
2  1.535975  0.164025  1.552377  0.147622  1.567140  
3  1.563075  0.236925  1.586768  0.213232  1.608091  
   id  age  weight    f_0     f_1      f_2       f_3       f_4      f_5  \
0   5   25      65  1.475  1.4975  1.51775  1.535975  1.552377  1.56714   

   predict_value  
0        1.56714  
$ 
```

```sh
# 二分类的
$ python example.py --model binary_cf
   id  age  weight  label  f_0  res_1  f_1     res_2       f_2     res_3  \
0   1    5      20      0  0.0   -0.5 -0.2 -0.450166 -0.381873 -0.405675   
1   2    7      30      0  0.0   -0.5 -0.2 -0.450166 -0.381873 -0.405675   
2   3   21      70      1  0.0    0.5  0.2  0.450166  0.381873  0.405675   
3   4   30      60      1  0.0    0.5  0.2  0.450166  0.381873  0.405675   

        f_3     res_4       f_4     res_5      f_5  
0 -0.550131 -0.365834 -0.707819 -0.330081 -0.85709  
1 -0.550131 -0.365834 -0.707819 -0.330081 -0.85709  
2  0.550131  0.365834  0.707819  0.330081  0.85709  
3  0.550131  0.365834  0.707819  0.330081  0.85709  
   id  age  weight  f_0  f_1       f_2       f_3       f_4      f_5  \
0   5   25      65  0.0  0.2  0.381873  0.550131  0.707819  0.85709   

   predict_proba  predict_label  
0       0.702052              1  
$ 
```
