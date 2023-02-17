
# 硬件性能对比

latency.txt https://gist.github.com/jboner/2841832
```console
Latency Comparison Numbers (~2012)
----------------------------------
L1 cache reference                           0.5 ns
Branch mispredict                            5   ns
L2 cache reference                           7   ns                      14x L1 cache
Mutex lock/unlock                           25   ns
Main memory reference                      100   ns                      20x L2 cache, 200x L1 cache
Compress 1K bytes with Zippy             3,000   ns        3 us
Send 1K bytes over 1 Gbps network       10,000   ns       10 us
Read 4K randomly from SSD*             150,000   ns      150 us          ~1GB/sec SSD
Read 1 MB sequentially from memory     250,000   ns      250 us
Round trip within same datacenter      500,000   ns      500 us
Read 1 MB sequentially from SSD*     1,000,000   ns    1,000 us    1 ms  ~1GB/sec SSD, 4X memory
Disk seek                           10,000,000   ns   10,000 us   10 ms  20x datacenter roundtrip
Read 1 MB sequentially from disk    20,000,000   ns   20,000 us   20 ms  80x memory, 20X SSD
Send packet CA->Netherlands->CA    150,000,000   ns  150,000 us  150 ms

Notes
-----
1 ns = 10^-9 seconds
1 us = 10^-6 seconds = 1,000 ns
1 ms = 10^-3 seconds = 1,000 us = 1,000,000 ns

Credit
------
By Jeff Dean:               http://research.google.com/people/jeff/
Originally by Peter Norvig: http://norvig.com/21-days.html#answers

Contributions
-------------
'Humanized' comparison:  https://gist.github.com/hellerbarde/2843375
Visual comparison chart: http://i.imgur.com/k0t1e.png
```

# 编程语言性能对比

performance of hello world in c vs c++ https://github.com/smason/lemire-hello

我们选择了Rust，因为它太快了 https://mp.weixin.qq.com/s/YdxNbueReCMAAnEdj-LKUQ
- > 正如你在上图中看到的，Rust在性能方面的表现几乎与C和C++持平，而CPython（我们大多数人所使用的）尽管使用量很大，但仅比最后一名好上一些。你可以点击这个GitHub上的项目`[1]`来了解更多，结果会不时地更新。
- > 你可能记得以下这个表格，来自于Pereira等人发表的一篇论文`[2]`。
- > 相关链接：
  * > 1. https://niklas-heer.github.io/speed-comparison/
  * > 2. https://repositorium.uminho.pt/bitstream/1822/69044/1/paper.pdf
