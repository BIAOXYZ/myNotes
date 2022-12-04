
# 官方

>> 【[:star:][`*`]】 //notes：官方这两篇里最大的收获就是明确了 python3.3 以上最好用 `venv`，python2 系列最好用 `virtualenv`。`pyenv` 看来只是装装不同版本 python 就好，管理虚环境可能不需要它了——但是它的虚环境管理插件也只是调用了相应的命令而已，而且它能够整齐地把虚环境相关目录都放到 `.pyenv` 下面的版本目录里，所以其实也不是不能用（不过也不是没坏处，引入了额外的复杂性）。。。所以结论是仍然没有结论。。。但是好歹有些进步，那就是 `virtualenv` 估计装的场景要少了（毕竟很多系统默认已经是 python3 了）——但是好像装了也没啥坏处- -。

venv --- 创建虚拟环境 https://docs.python.org/zh-cn/3/library/venv.html || venv — Creation of virtual environments https://docs.python.org/3/library/venv.html
- > **See also**: [Python Packaging User Guide: Creating and using virtual environments](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment)
- > **Creating virtual environments**
  * > Deprecated since version 3.6: `pyvenv` was the recommended tool for creating virtual environments for Python 3.3 and 3.4, and is deprecated in Python 3.6. || `3.6 版后已移除: pyvenv 是 Python 3.3 和 3.4 中创建虚拟环境的推荐工具，不过 在 Python 3.6 中已弃用。`

Installing packages using pip and virtual environments https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/
- > This guide discusses how to install packages using `pip` and a virtual environment manager: either `venv` for Python 3 or `virtualenv` for Python 2. These are the lowest-level tools for managing Python packages and are recommended if higher-level tools do not suit your needs.
- > **Installing virtualenv**
  * > **Note**: If you are using ***Python 3.3 or newer***, the `venv` module is the preferred way to create and manage virtual environments. `venv` is included in the Python standard library and requires no additional installation. ***If you are using `venv`, you may skip this section***.
    ```py
    python3 -m pip install --user virtualenv
    ```
- > **Creating a virtual environment**
  * > `venv` (for Python 3) and `virtualenv` (for Python 2) allow you to manage separate package installations for different projects. They essentially allow you to create a “virtual” isolated Python installation and install packages into that virtual installation. When you switch projects, you can simply create a new virtual environment and not have to worry about breaking the packages installed in the other environments. ***It is always recommended to use a virtual environment while developing Python applications***.
  * > To create a virtual environment, go to your project’s directory and run venv. ***If you are using Python 2, replace `venv` with `virtualenv` in the below commands***.
    ```py
    python3 -m venv env
    ```

# 其他

如何在Ubuntu 18.04服务器上安装Python 3并建立本地编程环境 https://www.digitalocean.com/community/tutorials/ubuntu-18-04-python-3-1-zh
>> //notes：其实并不是因为 `venv` 的原因，而是因为 digitalocean 本来文章写得不错了，竟然都出中文的了。。。什么是业界良心- -
