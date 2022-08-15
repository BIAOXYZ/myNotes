
关于编程语言内存对齐的疑问 https://www.v2ex.com/t/872792
- > https://stackoverflow.com/questions/381244/purpose-of-memory-alignment
- > x86 架构对于对齐的内存，写入读取都是原子的（但自增运算需要用专门的指令，另说）其他一些架构甚至不支持非对齐内存的原子操作。你搜一下 unaligned access 就可以搜到很多内容了。 <br> struct 内部重排以减少不必要的 padding ，这是性能优化的基础技巧之一。一般我们会把 64 位变量放前面，然后 32 位，然后 16 位。因为 64 位对齐一定同时也是 32 位和 16 位对齐，反之未必。 <br> ***<ins>编译器不会对 struct 内的顺序进行重排，因为有些操作可能会默认各个变量之间的顺序</ins>***。
- > Linux Kernel 里的文章： https://github.com/torvalds/linux/blob/master/Documentation/core-api/unaligned-memory-access.rst <br> 但实际来说，最新的一些 x86 处理器实际是支持未对齐内存访问的，而且也可以认为没有性能下降。旧一些的 x86 处理器也支持，但是会有性能下降。当然指令还是那个指令。其他的要看具体 arch 支持程度了，不支持的话甚至会出现 misaligned access 异常。

枚举类型是从 0 开始还是从 1 开始 https://v2ex.com/t/868018
- > 有设计文档说应该从 1 开始不过有争论。有个例子：Mysql 的枚举是从 1 开始的，0 会报错。
  ```
  文档写： （✔）
  0 ，保留字
  1 ，状态 1
  2 ，状态 2

  文档： （ X ）
  1 ，状态 1
  2 ，状态 2
  ```

webAssembly 目前是个啥情况 https://www.v2ex.com/t/865575
- > 我看到好几个游戏领域的应用，把旧的 C++的客户端游戏搬到浏览器端。 https://universe.flyff.com/ 对我影响很大的一款游戏，飞飞。

这个各大语言性能测试结果挺有意思 https://www.v2ex.com/t/862452
```console
来自 https://github.com/GoodManWEN/Programming-Language-Benchmarks-Visualization
```
- > 这有另外一个更知名的： https://github.com/kostya/benchmarks
