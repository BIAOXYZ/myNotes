
# 官方

setuptools https://github.com/pypa/setuptools || https://setuptools.pypa.io/en/latest/

# 其他

【[:star:][`*`]】 Python Packaging User Guide https://packaging.python.org/en/latest/
>> //notes：这一系列看会应该就全通了，然而，暂时没有那么多时间和耐心。。。慢慢在 tutorials 里总结吧。。。

## `setup.py` 相关

`4. 构建C/C++扩展` https://docs.python.org/zh-cn/3/extending/building.html

花了两天，终于把 Python 的 setup.py 给整明白了 - 王炳明的文章 - 知乎 https://zhuanlan.zhihu.com/p/276461821

Python 库打包分发(setup.py 编写)简易指南 https://blog.konghy.cn/2018/04/29/setup-dot-py/

## 其他打包工具

Differences between distribute, distutils, setuptools and distutils2? https://stackoverflow.com/questions/6344076/differences-between-distribute-distutils-setuptools-and-distutils2
- https://stackoverflow.com/questions/6344076/differences-between-distribute-distutils-setuptools-and-distutils2/14753678#14753678
  * > As of March 2020, most of the other answers to this question are several years out-of-date. When you come across advice on Python packaging issues, remember to look at the date of publication, and don't trust out-of-date information.
  * > The [Python Packaging User Guide](https://packaging.python.org/en/latest/) is worth a read. Every page has a "last updated" date displayed, so you can check the recency of the manual, and it's quite comprehensive. The fact that it's hosted on a subdomain of python.org of the Python Software Foundation just adds credence to it. The Project Summaries page is especially relevant here.
  * > **Supported tools**:
    + > **`distutils`** is still the standard tool for packaging in Python. It is included in the standard library (Python 2 and Python 3). It is useful for simple Python distributions, but lacks features. It introduces the `distutils` Python package that can be imported in your `setup.py` script.
    + > **`setuptools`** was developed to overcome Distutils' limitations, and is not included in the standard library. It introduced ***a command-line utility*** called `easy_install`. It also introduced the `setuptools` Python package that can be imported in your `setup.py` script, and the `pkg_resources` Python package that can be imported in your code to locate data files installed with a distribution. One of its gotchas is that it monkey-patches the `distutils` Python package. It should work well with `pip`. [It sees regular releases](https://github.com/pypa/setuptools/releases).
    + > **`scikit-build`** is an improved build system generator that internally uses `CMake` to build compiled Python extensions. Because `scikit-build` isn't based on `distutils`, it doesn't really have any of its limitations. When ninja-build is present, `scikit-build` can compile large projects over three times faster than the alternatives. It should work well with `pip`.
    + > **`distlib`** is a library that provides functionality that is used by higher level tools like `pip`.
    + > **`packaging`** is also a library that provides functionality used by higher level tools like `pip` and `setuptools`.
  * > **Deprecated/abandoned tools**:
    + > **`distribute`** was a fork of `setuptools`. It shared the same namespace, so if you had Distribute installed, `import setuptools` would actually import the package distributed with Distribute. **Distribute was merged back into Setuptools 0.7**, so you don't need to use Distribute any more. In fact, the version on Pypi is just a compatibility layer that installs Setuptools.
    + > **`distutils2`** was an attempt to take the best of `distutils`, `setuptools` and `distribute` and become the standard tool included in Python's standard library. The idea was that `distutils2` would be distributed for old Python versions, and that `distutils2` would be renamed to `packaging` for Python 3.3, which would include it in its standard library. These plans did not go as intended, however, and currently, **`distutils2` is an abandoned project**. The latest release was in March 2012, and its Pypi home page has finally been updated to reflect its death.
  * > **Others**:
    + > There are other tools, if you are interested, read [Project Summaries](https://packaging.python.org/en/latest/key_projects/) in the Python Packaging User Guide. I won't list them all, to not repeat that page, and to keep the answer matching the question, which was only about `distribute`, `distutils`, `setuptools` and `distutils2`.
  * > **Recommendation**:
    + > If all of this is new to you, and you don't know where to start, **I would recommend learning `setuptools`**, along with `pip` and `virtualenv`, which all work very well together.
    + > If you're looking into `virtualenv`, you might be interested in this question: [What is the difference between `venv`, `pyvenv`, `pyenv`, `virtualenv`, `virtualenvwrapper`, etc?](https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe). (Yes, I know, I groan with you.)

Python 包管理工具解惑 https://blog.zengrong.net/post/python_packaging/
