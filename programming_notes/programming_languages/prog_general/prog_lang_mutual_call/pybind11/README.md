
# 官方

pybind11 — Seamless operability between C++11 and Python https://github.com/pybind/pybind11

pybind11 — Seamless operability between C++11 and Python https://pybind11.readthedocs.io/en/stable/
- > **pybind11** is a lightweight ***header-only*** library that ***exposes C++ types in Python and vice versa***, mainly to ***create Python bindings of existing C++ code***. Its ***goals and syntax are similar to*** the excellent [Boost.Python](https://www.boost.org/doc/libs/1_58_0/libs/python/doc/) library by David Abrahams: to minimize boilerplate code in traditional extension modules by inferring type information using compile-time introspection.

Build systems https://pybind11.readthedocs.io/en/stable/compiling.html
- > **Building with setuptools**
  * > For projects on PyPI, building with setuptools is the way to go. Sylvain Corlay has kindly provided an example project which shows how to set up everything, including automatic generation of documentation using Sphinx. Please refer to the [python_example](https://github.com/pybind/python_example) repository.
- > **Building with CMake**
  * > A working sample project, including a way to invoke CMake from setup.py for PyPI integration, can be found in the [cmake_example](https://github.com/pybind/cmake_example) repository.

CMake helpers https://pybind11.readthedocs.io/en/stable/cmake/index.html

# error

CMake finding Python library and Python interpreter mismatch during pybind11 build #99 https://github.com/pybind/pybind11/issues/99

CMake and pybind11 using inconsistent Python Versions https://stackoverflow.com/questions/62773837/cmake-and-pybind11-using-inconsistent-python-versions

# 问题

How to strip trailing whitespace in CMake variable? https://stackoverflow.com/questions/39496043/how-to-strip-trailing-whitespace-in-cmake-variable || 如何在CMake变量中去掉尾部空格？ https://www.thinbug.com/q/39496043
- https://stackoverflow.com/questions/39496043/how-to-strip-trailing-whitespace-in-cmake-variable/42676416#42676416

# 其他

pybind11的最佳实践 - Gemfield的文章 - 知乎 https://zhuanlan.zhihu.com/p/192974017

使用pybind11 将C++代码编译为python模块 - Gemfield的文章 - 知乎 https://zhuanlan.zhihu.com/p/52619334
- > `PyExc_ImportError, "Python version mismatch: module was compiled for Python %s, " "but the interpreter version is incompatible: %s.", compiled_ver, runtime_ver);`

pybind11 https://mikethreeacer.medium.com/pybind11-4f538dbbc946

pybind11 for C++14/C++17 https://stackoverflow.com/questions/63682868/pybind11-for-c14-c17
- https://stackoverflow.com/questions/63682868/pybind11-for-c14-c17/63711626#63711626
  * > Yes, it works with C++11/14/17/20, see [corresponding section](https://pybind11.readthedocs.io/en/stable/compiling.html#configuration-variables) in docs.
    ```console
    By default, pybind11 will compile modules with the compiler default or the minimum standard required by pybind11, whichever is higher.
    ```

【码记录】在Ubuntu16.04使用pybind11+cmake实现python调用C++运行ncnn模型 - megaZ的文章 - 知乎 https://zhuanlan.zhihu.com/p/393024636

## Mac下编译问题：
>> //notes：在Mac下编译时，似乎要多加上 `-undefined dynamic_lookup` 参数，否则会报一堆平台相关的错误。。。
>>> //notes：至于下面文章里linux下的编译语句多了 `-fPIC`，这个之前在别的编译时候遇到过，好像是跟动态库相关的。反正Mac是个辣鸡就对了～

Python 调用 C++ 之 pybind11入门（macOS） https://www.ryanligod.com/2018/10/29/2018-10-29%20pybind11%20%E5%85%A5%E9%97%A8/
- > 编译
  * > macOS下运行：
    ```sh
    $ c++ -O3 -Wall -shared -std=c++11 -undefined dynamic_lookup `python3 -m pybind11 --includes` example.cpp -o example`python3-config --extension-suffix`
    ```
  * > Linux下运行：
    ```sh
    $ c++ -O3 -Wall -shared -std=c++11 -fPIC `python3 -m pybind11 --includes` example.cpp -o example`python3-config --extension-suffix`
    ```
