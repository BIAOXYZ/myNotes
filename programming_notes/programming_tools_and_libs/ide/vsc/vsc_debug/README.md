
# vscode debug 官方

Debugging https://code.visualstudio.com/docs/editor/debugging

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vsc debug 视频

C/C++ https://www.youtube.com/playlist?list=PLzREP1p8eayK9kwb9B_HuEjecr-ldkKK5

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vsc debug 文章

vscode上python进行debug大全 - 牧羊人的文章 - 知乎 https://zhuanlan.zhihu.com/p/673525708
- > **二、为你的debug配置参数（进阶**
  * > **1 创建多个调试配置**
  * > **2 相对路径设置**
    + > 如果程序里面涉及到了相对路径，可能会报错，解决办法是添加参数
    + > `cwd`：启动程序时的根目录配置
      ```json
      "cwd":"${fileDirname}"  // 设置相对路径，在debug时可以切换到当前文件所在的目录。
      ```
  * > **4 调试时传入命令行参数**
  * > **5 调试外部代码**
- > **三、分布式程序调试**

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vscode debug 其他

VSCode — how to set working directory for debug https://stackoverflow.com/questions/38623138/vscode-how-to-set-working-directory-for-debug

## debug进python的库函数

VSCode 调试器 - 让 Step Into 进入底层代码 - 李森科在zhihu的文章 - 知乎 https://zhuanlan.zhihu.com/p/138326186
- > **2 让 VSCode Step Into 至底层代码**
  * > 底层代码，在官方文档里称为standard library functions。我们又可以称之为Python的内置函数。 <br> 要让VSCode在调试中跳转至底层代码，只需要在 `launch.json` 中设置一个参数即可。
  * > 使用 `Ctrl + Shirt + P` 打开Command Palette，搜索launch。
  * > 打开launch对应的 `launch.json`，然后在下面加入这一行并保存。
    ```json
    "justMyCode": false
    ```
    > 再次调试代码，我们就可以和PyCharm一样Step Into到内置函数啦。

How to disable "just my code" setting in VSCode debugger? https://stackoverflow.com/questions/52980448/how-to-disable-just-my-code-setting-in-vscode-debugger

VS code 停用 justMyCode 调试库代码 https://blog.csdn.net/zywvvd/article/details/113753248

## debug with root or root privilege
>> //notes：这个的起因是：尝试用 vscode 调试 pg，在虚拟机里成功了，但是在 Github Codespaces 没成功。

How can I debug Go file in VS Code with root privileges? https://stackoverflow.com/questions/63505746/how-can-i-debug-go-file-in-vs-code-with-root-privileges
- https://stackoverflow.com/questions/63505746/how-can-i-debug-go-file-in-vs-code-with-root-privileges/71402050#71402050
  * > [Debugging programs and tests as root](https://github.com/golang/vscode-go/blob/master/docs/debugging.md#debugging-programs-and-tests-as-root) in the documentation of the VSCode Go addon has been updated accordingly with task and launch configuration examples to not only debug programs but also tests as root.
    >> https://github.com/golang/vscode-go/blob/caee58d0934cd0a00037224970c5fe349b32e978/docs/debugging.md#debugging-programs-and-tests-as-root
    ```json
    {
        "name": "Launch as Root",
        "request": "launch",
        "mode": "exec",
        "asRoot": true,
        "program": "${workspaceRoot}/myprogram",
        "console": "integratedTerminal",
        ...
    }
    ```
    >>> //notes：核心是有个 vsc 的配置参数 `"asRoot": true,`，但我不知道是不是只对 Go 语言有效。。。

VS Code debugging as root user https://stackoverflow.com/questions/70638525/vs-code-debugging-as-root-user

How to debug programs with "sudo" in VSCODE https://stackoverflow.com/questions/40033311/how-to-debug-programs-with-sudo-in-vscode

Debugging mixed Python C++ in VS Code. Can't enter sudo password https://stackoverflow.com/questions/64832766/debugging-mixed-python-c-in-vs-code-cant-enter-sudo-password

How to launch python in Visual Studio Code with superuser permission or root permission? (i.e. using sudo command) https://stackoverflow.com/questions/48144580/how-to-launch-python-in-visual-studio-code-with-superuser-permission-or-root-per

Unable to launch debugger (gdb) with root permissions. #861 https://github.com/microsoft/vscode-cpptools/issues/861
- > https://github.com/microsoft/vscode-cpptools/issues/861#issuecomment-318884887
  >> //notes：只是发现楼里有人回复说想调试 `Snort` 的时候碰到了一样的问题，决定先记录下。

Start gdb fail when attach debug a program.(Authentication is needed to run `/usr/bin/gdb' as the super user) #4988 https://github.com/microsoft/vscode-cpptools/issues/4988

## debug启动时的路径问题

vscode中使用python相对路径问题? - 知乎 https://www.zhihu.com/question/313379182
- vscode中使用python相对路径问题? - Achuan-2的回答 - 知乎 https://www.zhihu.com/question/313379182/answer/986009654
  * > 更改 `launch.json` 设置，在configurations中加入语句 `"cwd": "${fileDirname}"` 即可变成常规的相对路径模式
- vscode中使用python相对路径问题? - tnnmigga的回答 - 知乎 https://www.zhihu.com/question/313379182/answer/606965877
  * > 这不是由vscode造成的，是python插件的锅，本质上是命令行差异造成 <br> 区别就在于***pycharm是会先cd到文件目录后运行，vscode的python插件是直接绝对路径运行*** <br> 解决方法是手动 `chdir` 到指定目录 <br> 如果是改变到执行程序路径的话，windows下在读写文件以前添加一句 `os.chdir(sys.path[0])`。

## debug时直接运行到当前行

VSCode 调试器 - Run to Cursor - 李森科在zhihu的文章 - 知乎 https://zhuanlan.zhihu.com/p/138373787
- > `File` - `Preference` - `Keyboard Shortcuts` - 搜索 `run to cursor` - 设置快捷键（我设置的是Ctrl+Alt+R）
  >> //notes：我在Mac上设置成了 `control + F10`，因为根据下面这个回答，这个好像是 Visual Studio 的默认设置  -->  其实开始是设置成 `control + F9` 的，感觉这个也不错。
  >>> What is the shortcut key for Run to cursor https://stackoverflow.com/questions/47436/what-is-the-shortcut-key-for-run-to-cursor

## debug Python时（Windows下）连接语言服务器超时

Visual Studio Code Python Timeout waiting for debugger connection https://stackoverflow.com/questions/52462599/visual-studio-code-python-timeout-waiting-for-debugger-connection
- https://stackoverflow.com/questions/52462599/visual-studio-code-python-timeout-waiting-for-debugger-connection/52781131#52781131
  * > Open the `launch.json` file and add the following configuration:
    ```json
    {
         "name": "Python: Debug Console",
         "type": "python",
         "request": "launch",
         "program": "${file}",
         "console": "internalConsole"
    }
    ```
    > When you specify none `internalConsole` for the console, it will run the debugger in the debugger console instead of running in the internal or external terminal.
    >> //notes：另外补充下，原来的 `launch.json` 里这一项的旧值是 `//"console": "integratedTerminal"`。
