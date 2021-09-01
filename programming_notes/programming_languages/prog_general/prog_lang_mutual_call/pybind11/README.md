
# 官方

pybind11 — Seamless operability between C++11 and Python https://github.com/pybind/pybind11

pybind11 — Seamless operability between C++11 and Python https://pybind11.readthedocs.io/en/stable/
- > **pybind11** is a lightweight ***header-only*** library that ***exposes C++ types in Python and vice versa***, mainly to ***create Python bindings of existing C++ code***. Its ***goals and syntax are similar to*** the excellent [Boost.Python](https://www.boost.org/doc/libs/1_58_0/libs/python/doc/) library by David Abrahams: to minimize boilerplate code in traditional extension modules by inferring type information using compile-time introspection.

# 其他

pybind11的最佳实践 - Gemfield的文章 - 知乎 https://zhuanlan.zhihu.com/p/192974017

pybind11 https://mikethreeacer.medium.com/pybind11-4f538dbbc946

pybind11 for C++14/C++17 https://stackoverflow.com/questions/63682868/pybind11-for-c14-c17
- https://stackoverflow.com/questions/63682868/pybind11-for-c14-c17/63711626#63711626
  * > Yes, it works with C++11/14/17/20, see [corresponding section](https://pybind11.readthedocs.io/en/stable/compiling.html#configuration-variables) in docs.
    ```console
    By default, pybind11 will compile modules with the compiler default or the minimum standard required by pybind11, whichever is higher.
    ```
