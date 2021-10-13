
# 文章1

>> //notes：之前的例子虽然解决了基本的pybind11编译，和在命令行方式下的python里的使用，但是没有解决在代码文件里如何调用pybind11编译出的动态库的问题。
>>> 其实核心点是：把编出来的 `.so` 文件所在的目录加到 `sys.path` 里！

How do I import a module created with pybind11 on Ubuntu https://stackoverflow.com/questions/50688184/how-do-i-import-a-module-created-with-pybind11-on-ubuntu
- https://stackoverflow.com/questions/50688184/how-do-i-import-a-module-created-with-pybind11-on-ubuntu/50688379#50688379
  * > If you open a terminal, go to the directory where `arithmetic.cpython-36m-x86_64-linux-gnu.so` is located and run `python` followed by `import arithmetic` the module will get imported just like any other module.
  * > Another options is to use the method of
    ```py
    import sys
    sys.path.insert(0, 'path/to/directory/where/so-file/is')
    import arithmetic
    ```
    > With this method you can use both relative and absolute path.
- https://stackoverflow.com/questions/50688184/how-do-i-import-a-module-created-with-pybind11-on-ubuntu/50701735#50701735
  * > Besides the solution of setting the path in the Python script that is presented by @super, you have two more generic solutions.
  * > **Setting `PYTHONPATH`**
    + > There is an environment variable in Linux (and macOS) called `PYTHONPATH`. If you add the path that contains your `*.so` to the `PYTHONPATH` before you call Python, Python will be able to find your library.
    + > To do this:
      ```sh
      export PYTHONPATH="/path/that/contains/your/so":"${PYTHONPATH}"
      ```
      > To apply this 'automatically' for every session you can add this line to `~/.bash_profile` or `~/.bashrc` (see the same reference). In that case, Python will always be able to find your library.
  * > **Copying your to a path already in Python's path**
    + > You can also 'install' the library. The usual way to do this is to create a `setup.py` file. If set up correctly you can build and install your library using
      ```sh
      python setup.py build
      python setup.py install
      ```
      > (Python will know where to put your library. You can 'customize' a bit with an option like `--user` to use your home-folder, but this doesn't seems to be of particular interest to you.)
    + > The question remains: How to write `setup.py`? For your case you can actually call CMake. In fact there exists an example that does exactly that: [pybind/cmake_example](https://github.com/pybind/cmake_example). You can basically copy-paste from there.

【[:star:][`*`]】 pybind11教程 - 奇迹哥的文章 - 知乎 https://zhuanlan.zhihu.com/p/362834539

# 文章2

pybind11: C++ 工程如何提供 Python 接口 https://segmentfault.com/a/1190000023886545
- > **添加进 CMake**
  * > `CMakeLists.txt` 里 `add_subdirectory` pybind11 的路径，再用其提供的 `pybind11_add_module` 就能创建 pybind11 的模块了。
    ```cmake
    cmake_minimum_required(VERSION 3.1)
    project(start-pybind11 VERSION 0.1.0 LANGUAGES C CXX)
    
    set(MY_PYBIND ${MY_CURR}/third_party/pybind11-2.5.0)
    
    add_subdirectory(${MY_PYBIND})
    pybind11_add_module(example_pb example_pb.cpp)
    ```
  * > 如果想在已有 C++ 动态库上扩展 pybind11 绑定，那么 `target_link_libraries` 链接该动态库就可以了。
    ```cmake
    target_link_libraries(example_pb PUBLIC example)
    ```
- > **绑定一个函数**
  * > 我们先实现一个 `add` 函数，
    ```cpp
    int add(int i, int j) {
      return i + j;
    }
    ```
  * > 为了简化工程，可以直接实现在 `example_pb.cpp` 里，
    ```cpp
    #include <pybind11/pybind11.h>
    
    namespace py = pybind11;
    
    int add(int i, int j) {
      return i + j;
    }
    
    PYBIND11_MODULE(example_pb, m) {
      m.doc() = "example_pb bindings";
      m.def("add", &add, "A function which adds two numbers");
    }
    ```
  * > 之后，于 `CMakeLists.txt` 所在目录，执行 `cmake` 编译就完成了。

Setting up a C++/Python project with pybind11 and CMake https://medium.com/practical-coding/setting-up-a-c-python-project-with-pybind11-and-cmake-8de391494fca
