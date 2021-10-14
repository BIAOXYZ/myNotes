
【Python基础】PIP 镜像源配置轻松搞定 - DavyCloud的文章 - 知乎 https://zhuanlan.zhihu.com/p/106697938
- > **编辑配置**
  * > 在命令行直接执行 `pip config edit` 会自动为我们打开配置文件，但是在 Windows 环境下还不行：
    ```sh
    pip config edit
    ERROR: Could not determine editor to use.
    ```
    > 需要手动指定一个编辑器，就用记事本就行了：
    ```
    pip config edit  --editor notepad
    ```
    > Linux 系统中编辑器可以使用 vi，也可以是你习惯的其它编辑器
  * > 如果你从来没有设置过，它会报找不到指定路径，这是因为相应的文件夹没有创建。

修改pip源 https://www.jianshu.com/p/344b5b3c81f8

Python 修改 pip 源为国内源 - 花晓星辰的文章 - 知乎 https://zhuanlan.zhihu.com/p/109939711
- > 若要把 pip 源换成国内的，只需要把上面的代码改成下图这样（下图以清华大学源为例）：
  ```sh
  pip install markdown -i https://pypi.tuna.tsinghua.edu.cn/simple
  ```
