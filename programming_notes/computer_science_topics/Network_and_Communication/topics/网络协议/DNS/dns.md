
DNS 中有哪些值得学习的优秀设计 https://www.ithome.com/0/678/439.htm || https://mp.weixin.qq.com/s/3FONsVCFYNvaz1yW1EVgxg  【from `小白debug`】
- > **最近的DNS服务器怎么知道根域的IP是多少？**
  * > 我们也知道根域，就是域名树的顶层，既然是顶层，那信息一般也就相对少一些。对应的IPV4地址只有13个，IPV6地址只有25个。
  * > 我们可以通过 `dig` 命令的 `+trace` 选项来查看一个域名的dns解析过程。
  * > ![](https://mmbiz.qpic.cn/mmbiz_png/AnAgeMhDIiamxOwe7s34YdbQGnicd6M5pAhnMjo9Y5JGAsaiarDea5RVwOsmWh3T7BTInOd41AFgvvNV51kEKb5Wg/640)
  * > 而前面提到的传说中的13个根域，从字母a-m，就都在上图中。

