
# Memray

Memray is a memory profiler for Python https://github.com/bloomberg/memray || https://bloomberg.github.io/memray/

# Pyflame

~~🔥 Pyflame: A Ptracing Profiler For Python. This project is deprecated and not maintained. https://github.com/uber-archive/pyflame~~  -->  `This repository has been archived by the owner. It is now read-only.`

5.pyflame简单使用.md https://github.com/wufeiqun/blog/blob/6c4df2be852c9e929fbbe829e370b85f61d6e892/python/5.pyflame%E7%AE%80%E5%8D%95%E4%BD%BF%E7%94%A8.md
- > 参考链接
  * > 如何读懂火焰图 https://www.ruanyifeng.com/blog/2017/09/flame-graph.html

# filprofiler

filprofiler -- The Fil memory profiler for Python https://github.com/pythonspeed/filprofiler

# 其他

有没有开源的工具对 Python 运行的类或函数 性能时间分析的工具 https://www.v2ex.com/t/902990
- > profiler <br> line_profiler
- > 随手一搜不是很多么... <br> Python 程序调试分析大杀器 - 知乎 - https://zhuanlan.zhihu.com/p/505344229
- > VizTracer ？
- > python 标准库自带 cprofile, 结果是二进制文件, 可以用自带的 pstats 查看结果.
  ```sh
  python -m cProfile -o script_stat.prof my_script.py
  python -m pstats script_stat.prof
  ```
- 个人补充链接：
  * Python 性能分析器¶ https://docs.python.org/zh-cn/3/library/profile.html
    + https://github.com/python/cpython/tree/3.11/Lib/profile.py
  * line_profiler and kernprof https://github.com/pyutils/line_profiler
  * Python程序调试分析大杀器 - 字节的文章 - 知乎 https://zhuanlan.zhihu.com/p/505344229
    + > pystack-debugger
    + > hypno
    + > py-spy
    + > 【[:star:][`*`]】 austin
      - > 本以为 `py-spy` 已经足够强大了，没想到又找到了这个无敌的`austin`！
      - > 项目地址：[austin](https://github.com/P403n1x87/austin)，[austin-tui](https://github.com/p403n1x87/austin-tui)
    + > 其它项目
  * 【[:star:][`*`]】 VizTracer https://github.com/gaogaotiantian/viztracer
