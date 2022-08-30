
# 官方

subprocess --- 子进程管理 https://docs.python.org/zh-cn/3/library/subprocess.html

# 其他

Using Python's Subprocess to Display Output in New Xterm Window https://stackoverflow.com/questions/5558720/using-pythons-subprocess-to-display-output-in-new-xterm-window

Chapter 19 - The subprocess Module https://python101.pythonlibrary.org/chapter19_subprocess.html
- > **The `call` function**
- > **The `Popen` Class**
  * > The **`Popen`** class executes a child program in a new process. Unlike the **`call`** method, it does not wait for the called process to end unless you tell it to using by using the **`wait`** method.
- > **Learning to Communicate**

python subprocess.call() not working as expected https://askubuntu.com/questions/801493/python-subprocess-call-not-working-as-expected
- https://askubuntu.com/questions/801493/python-subprocess-call-not-working-as-expected/801496#801496
  * > By default `subprocess.call` doesn't use a shell to run our commands you so can't shell commands like `cd`.
  * > To use a shell to run your commands use `shell=True` as parameter. In that case it is recommended to pass your commands as a single string rather than as a list. And as it's run by a shell you can use `~/` in your path, too:
    ```py
    subprocess.call("(cd ~/catkin_ws/src && catkin_make)", shell=True)
    ```

# 问题

## 与 `echo -e` 无法兼容的问题

```py
>>> import os
>>> cmd = "echo '1234'"
>>> cmd1 = "echo -e '1234'"
>>> 
>>> os.system(cmd)
1234
0
>>> os.system(cmd1)
-e 1234
0
>>> 
>>> import subprocess
>>> subprocess.call(cmd, shell=True)
1234
0
>>> subprocess.call(cmd1, shell=True)
-e 1234
0
>>> 
```
