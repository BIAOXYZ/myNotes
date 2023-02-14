
# pip官方

pip - The Python Package Installer https://github.com/pypa/pip

pip https://pip.pypa.io/en/stable/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pip general

Python包管理器-pip https://juejin.im/post/5beb92e7e51d454fbd6b4bc4

最全的 pip 使用指南，50% 你可能没用过 https://juejin.im/post/5dc2bdabf265da4d4216bd29

Pipenv – 超好用的 Python 包管理工具 https://juejin.im/post/5b31ba8851882574e808e555

pip使用指南（基于pip 8.1.1） https://github.com/huaxz1986/python_tools/blob/master/packages/pip_usage.markdown

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pip concrete

## intall pip

如何安装PIP来管理Linux中的Python包 https://www.howtoing.com/install-pip-in-linux/
```sh
在openSUSE上安装PIP

# zypper install python-pip	   # Python 2
# zypper install python3-pip   # Python 3
```
>> 类似net-tools。。。不能直接`XXX install pip`。。。

linux 同时安装python2 python3， 及pip 的安装使用 https://blog.csdn.net/u010080235/article/details/99859814
- > 由于ubuntu系统自带python2.7（默认）和python3.4，所以不需要自己安装python。
  >> //notes：发现不止ubuntu，debian（至少debian 9）也是同时自带了python和python3
- > 在不同版本中安装pip，可以使用一下命令：
  ```sh
  sudo apt-get install python-pip
  sudo apt-get install python3-pip
  ```

Centos中安装pip3/pip https://blog.csdn.net/gwz_6903/article/details/100678333
- > **一、python2**
  ```sh
  # 1.安装源
  yum -y install epel-release
  # 2.安装 pip
  yum install -y python-pip
  # 3.对安装好的 pip 进行升级
  pip install --upgrade pip
  # 到这里 pip 安装完成，即 /usr/bin 目录下有 pip , 但注意是 python2 下的。
  ```
- > **二、python3中pip3的安装**
  * > python3 中自带有 `pip3`，因此只需要添加 `pip3` 的软链接即可
  * > 在之前装的 python3 的 `/usr/bin` 目录下有 `pip3` （创建软链接）
    ```sh
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
    ```
    > 此时 `pip` 和 `pip3` 均可用

How to install pip with Python 3? https://stackoverflow.com/questions/6587507/how-to-install-pip-with-python-3
- https://stackoverflow.com/questions/6587507/how-to-install-pip-with-python-3/6587528#6587528

## pip安装指定版本的软件

```sh
sudo pip install cmake=3.21.1

# 或者加上 -U，应该是表示已有的话就升级。
sudo pip install -U cmake==xxx
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `requirement.txt`

初学Python-使用requirement.txt https://www.jianshu.com/p/d3e272243cd4
- > 第一步：自动生成requirement.txt，命令：
  >> `pip freeze > requirements.txt`
- > 第三步：安装requirement.txt，在新环境，执行命令即可一键安装完所需要的第三方库。命令：
  >> `pip install -r requirements.txt`

## 小技巧：跳过 `requirement.txt` 里失败的包，继续安装其他包

Stop pip from failing on single package when installing with requirements.txt https://stackoverflow.com/questions/22250483/stop-pip-from-failing-on-single-package-when-installing-with-requirements-txt
- https://stackoverflow.com/questions/22250483/stop-pip-from-failing-on-single-package-when-installing-with-requirements-txt/28795395#28795395
  * > Running each line with pip install may be a workaround.
    ```sh
    cat requirements.txt | xargs -n 1 pip install
    ```
    > Note: `-a` parameter is not available under MacOS, so old `cat` is more portable.
  * 回复里的：
    + > I had to do: `cat requirements.txt | cut -f1 -d"#" | sed '/^\s*$/d' | xargs -n 1 pip install` to remove anything in the comments and get rid of empty lines.
    + > At least with GNU `xargs`, there's `-a` flag option, which allows `xargs` read arguments from file, so this can be done as `xargs -n 1 -a requirements.txt pip install`. Prevents UUOC and excessive plumbing
    + > For windows :) `FOR /F %k in (requirements.txt) DO pip install %k`
    + > Even without the `-a` flag, consider `< requirements.txt xargs -n 1 pip install`, or if you don't like the redirect at the front, `xargs -n 1 pip install < requirements.txt`. :-) 

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pip打包发布

Python 打包自己的库到 PYPI （可pip安装） - 霾大的文章 - 知乎 https://zhuanlan.zhihu.com/p/79164800

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pip问题解决

## `subprocess.CalledProcessError: Command '('lsb_release', '-a')' returned non-zero exit status 1.`
>> //notes：起因是用 `update-alternatives` 方式升级python，结果这次 `pip` 出问题了，报上述错误。
>>> 网上搜了下，用了下面的方法，核心步骤是 `sudo cp /usr/lib/python3/dist-packages/lsb_release.py /usr/local/lib/python3.7/`。还有一些攻略说是直接删掉 `/usr/bin/lsb_release`，没有尝试这种，明显感觉不太好。

- pip报错“subprocess.CalledProcessError...lsb_release” - 老K的文章 - 知乎 https://zhuanlan.zhihu.com/p/150492500
- ubuntu 中pip 安装软件报错：“Command 'lsb_release -a' returned non-zero exit status 1.” https://www.jianshu.com/p/3a2877edebe8

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pip小技巧

## 直接在python脚本里安装需要的包

Installing python module within code https://stackoverflow.com/questions/12332975/installing-python-module-within-code

How to install a missing python package from inside the script that needs it? https://stackoverflow.com/questions/17271444/how-to-install-a-missing-python-package-from-inside-the-script-that-needs-it

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
