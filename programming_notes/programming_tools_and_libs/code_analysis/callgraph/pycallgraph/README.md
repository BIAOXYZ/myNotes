
# 官方

pycallgraph is a Python module that creates call graphs for Python programs. https://github.com/gak/pycallgraph

Python Call Graph https://pycallgraph.readthedocs.io/en/master/

pycallgraph2 is a maintained fork of pycallgraph, a Python module that creates call graphs for Python programs. https://github.com/daneads/pycallgraph2

# 其他

Python中动态与静态 Call Graph（调用关系图）分析工具 - 忘荃的文章 - 知乎 https://zhuanlan.zhihu.com/p/108481835
- > 调用图可以是动态的或静态的。动态调用图是程序执行的记录，因此，动态调用图尽管是准确的，但仅描述了该程序的一次运行。而静态调用图则旨在展示程序的所有可能的调用过程。确切的静态调用图是一个无法NP问题，因此静态调用图的产生算法通常只能是以overapproximations的方式去近似。也就是说，在图中表示的一些调用关系，可能在实际的运行过程中根本不会发生。
- > 在不同语言和场景中有不同的Call Graph 分析工具，详情参考这里。在本文中我们将会介绍适用于python代码分析的 ***动态调用图分析工具 `pycallgraph`*** 和 ***静态调用图分析工具 `pyan`***。前者远比后者有名，但是我们确实两个都需要。而且后者因为不需要运行程序就能直接对程序进行分析，所以更加快速便捷。
- > 前面讲得更适合分析有很多py文件的python大工程（尤其适合用于探索一个不太熟悉的python库），如果是刚入门的同学的话，可能更需要一个对自己小程序中的数据进行可视化的话，推荐看看下面这个文章。
  * > 实时可视化Debug：VS Code 开源新工具，一键解析代码结构 - 机器之心的文章 - 知乎 https://zhuanlan.zhihu.com/p/109212146

Python - 使用pycallgraph生成函数关系图 https://www.cnblogs.com/anliven/p/10004665.html

图形化显示 Python 函数之间的调用关系 https://www.k0rz3n.com/2019/02/22/%E5%9B%BE%E5%BD%A2%E5%8C%96%E6%98%BE%E7%A4%BA%20Python%20%E5%87%BD%E6%95%B0%E4%B9%8B%E9%97%B4%E7%9A%84%E8%B0%83%E7%94%A8%E5%85%B3%E7%B3%BB/
- > **0X02 使用方法**
  * > 1.在项目主函数所在文件中引入依赖包
  * > 2.设定要显示或者不要显示的函数
  * > 3.main()前调用我们的绘图函数

python生成函数关系调用图｜Python 主题月 https://juejin.cn/post/6979581663588122655

python函数调用关系图（python call graph） https://blog.csdn.net/anque1234/article/details/101423303 || https://www.cnblogs.com/ai-ldj/p/14635598.html

[Python] 绘制Python代码的函数调用关系：graphviz+pycallgraph https://blog.csdn.net/qq_41683065/article/details/104816995
