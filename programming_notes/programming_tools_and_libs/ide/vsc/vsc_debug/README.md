
# vscode debug 官方

Debugging https://code.visualstudio.com/docs/editor/debugging

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
