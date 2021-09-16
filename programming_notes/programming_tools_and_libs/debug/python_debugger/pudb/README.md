
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

# 实战

不入侵源代码的话，安装完成后和 `pdb` 不入侵源代码的调试方式是一样的，就是把模块名字改成 `pudb` 即可，也就是：`python -m pudb my-script.py`
