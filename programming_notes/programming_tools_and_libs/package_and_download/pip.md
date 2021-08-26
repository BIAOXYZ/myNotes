
# pip, pipenv and others

# pip general

Python包管理器-pip https://juejin.im/post/5beb92e7e51d454fbd6b4bc4

最全的 pip 使用指南，50% 你可能没用过 https://juejin.im/post/5dc2bdabf265da4d4216bd29

Pipenv – 超好用的 Python 包管理工具 https://juejin.im/post/5b31ba8851882574e808e555

pip使用指南（基于pip 8.1.1） https://github.com/huaxz1986/python_tools/blob/master/packages/pip_usage.markdown

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

How to install pip with Python 3? https://stackoverflow.com/questions/6587507/how-to-install-pip-with-python-3

## pip安装指定版本的软件

```sh
sudo pip install cmake=3.21.1

# 或者加上 -U，应该是表示已有的话就升级。
sudo pip install -U cmake==xxx
```

# `requirement.txt`

初学Python-使用requirement.txt https://www.jianshu.com/p/d3e272243cd4
- > 第一步：自动生成requirement.txt，命令：
  >> `pip freeze > requirements.txt`
- > 第三步：安装requirement.txt，在新环境，执行命令即可一键安装完所需要的第三方库。命令：
  >> `pip install -r requirements.txt`
