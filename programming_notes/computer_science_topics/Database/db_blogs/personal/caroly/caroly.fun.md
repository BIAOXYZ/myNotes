
分类/分布式数据库 https://caroly.fun/categories/disdatabase
- 【[:star:][`*`]】 分布式数据库（七） https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%83

【[:star:][`*`]】 分布式数据库（七） https://caroly.fun/archives/%E5%88%86%E5%B8%83%E5%BC%8F%E6%95%B0%E6%8D%AE%E5%BA%93%E4%B8%83
- > **HTAP 的两种存储设计**
  * > **Spanner：存储合一**
    + > 首先，先看看 Spanner 的方案。Spanner2017 论文“Spanner: Becoming a SQL System”中介绍了它的新一代存储 Ressi，其中使用了类似 PAX 的方式。这个 PAX 并不是 Spanner 的创新，早在 VLDB2002 的论文 ["Data Page Layouts for Relational Databases on Deep Memory Hierarchies"](https://research.cs.wisc.edu/multifacet/papers/vldbj02_pax.pdf) 中就被提出了。论文从 CPU 缓存友好性的角度，对不同的存储方式进行了探讨，涉及 `NSM`、`DSM`、`PAX` 三种存储格式。
