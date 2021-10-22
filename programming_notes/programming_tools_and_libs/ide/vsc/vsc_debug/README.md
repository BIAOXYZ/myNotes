
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
