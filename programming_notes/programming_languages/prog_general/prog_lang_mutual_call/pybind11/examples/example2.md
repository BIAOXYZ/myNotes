
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

pybind11教程 - 奇迹哥的文章 - 知乎 https://zhuanlan.zhihu.com/p/362834539
