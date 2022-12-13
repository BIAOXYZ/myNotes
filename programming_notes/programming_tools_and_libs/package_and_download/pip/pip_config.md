
# 官方

Configuration https://pip.pypa.io/en/stable/topics/configuration/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 配置 pip 源

PyPI 镜像使用帮助 https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
- > **配置多个镜像源**
  * > 如果您想配置多个镜像源平衡负载，可在已经替换 index-url 的情况下通过以下方式继续增加源站：
    ```sh
    pip config set global.extra-index-url "<url1> <url2>..."
    ```
    > 请自行替换引号内的内容，源地址之间需要有空格

## 第二批

pip 换源、pip添加多个安装源且设置域名信任 https://www.cnblogs.com/dan-baishucaizi/p/13186738.html
```conf
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
extra-index-url=https://pypi.tuna.tsinghua.edu.cn/simple/
                http://pypi.mirrors.ustc.edu.cn/simple/
                https://pypi.org/
[install]
trusted-host=mirrors.aliyun.com
             pypi.tuna.tsinghua.edu.cn
             pypi.mirrors.ustc.edu.cn
             pypi.org
```
>> 【[:star:][`*`]】 //notes：这里切记不能写成下面这种形式。
  ```
  extra-index-url=xxx
  extra-index-url=yyy
  ```
>>> `解决：While reading from '/Users/***/.pip/pip.conf' [line 4]: option 'extra-index-url' in section 'global' already exists` https://www.cnblogs.com/night-xing/p/12094099.html

pip换源的注意事项 https://l-fay.github.io/2020/11/27/anaconda00/
- > 内容
  ```conf
  [global]
  index-url = https://pypi.tuna.tsinghua.edu.cn/simple
  extra-index-url=
      https://pypi.mirrors.ustc.edu.cn/simple/
      https://pypi.douban.com/simple/
      https://pypi.python.org/simple/
  [install]
  trusted-host = tuna.tsinghua.edu.cn
      pypi.douban.com
      mirrors.ustc.edu.cn
      python.org
  ```
- > 另外记一个***错误写法***：
  ```
  [global]
  index-url=http://pypi.douban.com/simple
  extra-index-url=http://mirrors.aliyun.com/pypi/simple/
  extra-index-url=https://pypi.tuna.tsinghua.edu.cn/simple/
  extra-index-url=http://pypi.mirrors.ustc.edu.cn/simple/
  [install]
  trusted-host=pypi.douban.com
  trusted-host=mirrors.aliyun.com
  trusted-host=pypi.tuna.tsinghua.edu.cn
  trusted-host=pypi.mirrors.ustc.edu.cn
  ```
  > 这样会报错：`option 'extra-index-url' in section 'global' already exists.`

python pip源配置 https://www.jianshu.com/p/87c2d914dcf7

## 第一批

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

Ubuntu 配置 pip.conf 添加国内源 https://www.jianshu.com/p/ac4df573b9d9

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
