
# PuDB

PuDB: a console-based visual debugger for Python https://github.com/inducer/pudb

Getting Started https://documen.tician.de/pudb/starting.html

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
