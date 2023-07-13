
# PuDB

PuDB: a console-based visual debugger for Python https://github.com/inducer/pudb

Getting Started https://documen.tician.de/pudb/starting.html
- > **Debugging from a separate terminal**
- > **Remote debugging**
- > **Using the debugger after forking**

Installing https://documen.tician.de/pudb/misc.html
- > Install PuDB using the command:
  ```py
  pip install pudb
  ```

Shells https://documen.tician.de/pudb/shells.html
- > Internal shell
  * > At any point while debugging, press `Ctrl-x` to switch to the built in interactive shell. From here, you can execute Python commands at the current point of the debugger. Press `Ctrl-x` again to move back to the debugger.
- > External shells
  * > To open the external shell, press the `!` key while debugging. Unlike the internal shell, external shells close the debugger UI while the shell is active. Press `Ctrl-d` at any time to exit the shell and return to the debugger.

# 常用快捷键

注：一下均是在 `pudb` 的调试界面的命令，也就是用 `python -m pudb my-script.py` 启动后进入的那个界面。
```sh
# 打一下这个，很多就知道了。
?

# 常规 debuger 里会用到的。
n
s
c
f

# 退出
q

# 输出不会在 pudb 的界面里显示，可以按 o 回到 shell 看下输出，然后回车返回 pudb 界面。
o
# 直接运行到指定行
t
# 遍历 module（主要方便打断点用？比如：https://github.com/inducer/pudb/issues/405 ）
m

# 其他
ctrl + x
ctrl + p
```

# 实战

## 1.基本调试

不入侵源代码的话，安装完成后和 `pdb` 不入侵源代码的调试方式是一样的，就是把模块名字改成 `pudb` 即可，也就是：`python -m pudb my-script.py`

## 2.其他

在调试某个项目时，中间有一层是c++的动态库，所以看不到代码。不过pudb竟然打出了这个提示，但是也没时间试试到底行不行了。
```console
 <no source code available>                                                          Variables:
                                                                                      _ctx: Context
  If this is generated code and you would like the source code to show up here,       lh_is_const: False
  add it to linecache.cache, like                                                     name: None
                                                                                      rh_is_const: False
      import linecache                                                                x: Tensor
      linecache.cache[filename] = (size, mtime, lines, fullname)                      y: Tensor
                                                                                      
  You can also set the attribute _MODULE_SOURCE_CODE in the module in which this func 
  was compiled to a string containing the code. 
```

# 设置

## 更换主题

How can I select or change the theme on pudb (Python Debugger)? https://stackoverflow.com/questions/63491724/how-can-i-select-or-change-the-theme-on-pudb-python-debugger
- https://stackoverflow.com/questions/63491724/how-can-i-select-or-change-the-theme-on-pudb-python-debugger/63881896#63881896
  * > There is a config menu `Ctrl + p` and there you can select a theme.
- https://stackoverflow.com/questions/63491724/how-can-i-select-or-change-the-theme-on-pudb-python-debugger/75304600#75304600
  * > I edited the pudb config file at `~/.config/pudb/pudb.cfg` and set `theme = dark vim`. For example, here is the snippet from my `pudb.cfg`:

## 调试多进程

Cannot use pudb for multiprocessing https://stackoverflow.com/questions/47967490/cannot-use-pudb-for-multiprocessing

Use puDB to Debug Python Multiprocessing Code https://auro-227.medium.com/use-pudb-to-debug-python-multiprocessing-code-c0c5551d010c
