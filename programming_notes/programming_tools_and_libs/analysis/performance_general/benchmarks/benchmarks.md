
# SPEC

Standard Performance Evaluation Corporation https://en.wikipedia.org/wiki/Standard_Performance_Evaluation_Corporation

Standard Performance Evaluation Corporation https://www.spec.org/
- https://www.spec.org/benchmarks.html

英特尔定制编译器优化 CPU 跑分最高 9%，SPEC 宣布近 2600 项成绩无效 https://www.ithome.com/0/750/785.htm
- > IT之家 2 月 19 日消息，SPEC 近日发布编译器通知，表示近期发现英特尔 oneAPI DPC++ 编译器存在特殊优化问题，宣布 2600 多项英特尔 SPEC CPU 2017 基准测试成绩无效。
- > Phoronix 网站的 Michael Larabel 认为，英特尔专门设计的编译器最高可以将速度提升 9%，SPECint 的速度提升约 4%。
- > IT之家注：SPEC 成立于 1988 年，是由斯坦福大学、清华大学、微软、等全球几十所知名大学、研究机构、IT 企业组成的全球性的、权威的第三方应用性能测试组织，旨在确立、修改、认定一系列服务器应用性能评估的标准。
- > 该组织最新的 SPEC CPU 2017 是一套 CPU 子系统测试工具，包括 4 大种类共 43 个测试，包括测试整型运算速度、浮点运算速度的 SPECspeed 2017、SPECspeed 2017 Floating Point，以及测试整型并发速率、浮点并发速率 SPECrate 2017 Integer、SPECrate 2017 Floating Point。
- 回复里的：
  * > 没太懂，为啥定向优化也算作弊
    >> 它是编译器判断是不是SPEC代码来生成特定的优化代码来作弊的，事实上如果你把SPEC代码中使用到的逻辑应用到其他项目中就没办法得到相同的性能加成，那这就是作弊，因为无法完全体现处理器的真实性能水平，就像以前的龙芯疯狂优化SPEC 2006的结果一样，跑分好看实际用起来就… <br> 一般来说要是Intel真的对自己的处理器有信心的话也不至于走这种旁门左道，估计是被AMD的EPYC给搞心虚了，反正这种用户也都是大客户，能忽悠到一个算一个。
    >>> 龙芯用主线版本的gcc也能跑到近似的分数，intel这是它自己的编译器作弊，以前spec06时intel cpu用icc跑出来分数涨幅更夸张
