
# 1

记 C++开发中的一个小坑 https://www.v2ex.com/t/835428
```console
最近写的功能里，发现一个单元测试在 Debug 下可以通过，但是在 RelWithDebInfo 下却报错。错误发生在使用memcmp比较两个内存地址处。抽象出来的代码如下：
```
```cpp
struct GID{
  MyType m_type; // Member with alignment as 8
  bool used; // bool has alignment of 1
};

GID gid1;
...
GID gid2 = gid1;

assert(memcmp(&gid1, &gid2, sizeof(GID)) == 0); // failed for RelWithDebInfo
```
```console
后来经过排查，发现 Debug 时 gid2.used 成员之后内存是干净的，padding 均为 0 ，但是在 RenWithDebInfo 下 gid2.used 之后内存却有随机值，导致了memcmp失败。
经过搜索发现了 auto-generated copy constructor 是不会将 padding 置零。读了 memcmp 的文档后也发现已经有提示过了。真是学无止境。

https://stackoverflow.com/questions/70979077/does-c-standard-guarantee-the-initialization-of-padding-bytes-to-zero-for-non
https://en.cppreference.com/w/cpp/string/byte/memcmp
```
- > 1.变量或结构体要初始化 <br> 2.结构体字节对齐
- > 最关键的问题 不是模式问题 跟 `memcmp` 也没太大关系 (虽然用来这样比较两个结构存在非常大的问题,正常情况自己做操作符重载) 
  * > 关键在于 初始化的问题 主要原因 c++ 隐式的行为太多了 这次的问题 属于开发工具 为了 debug 模式下 查找问题容易些 在 c++标准之外做了额外的处理 导致了 本来未知行为的代码(也就是错误) 变成了固定行为(也就是 memcmp 比较的内存相等 )
  * > https://en.cppreference.com/w/cpp/language/default_initialization#:~:text=otherwise%2C%20no%20initialization%20is%20performed%3A%20the%20objects%20with%20automatic%20storage%20duration%20(and%20their%20subobjects)%20contain%20indeterminate%20values.
  * > https://en.cppreference.com/w/cpp/language/value_initialization
  * > https://en.cppreference.com/w/cpp/language/zero_initialization
  * > 很多时候都会说 声明变量的时候 就做主动初始化的操作 就比如 T{} T (...)等 这也是个好的习惯 但是很多时候 这种也是属于多余的操作 这就要看自己对代码的把控了
  * > 反正就是 切勿对未知的内存做操作就行了 更多的情况 不要关注 debug 模式下可以 release 模式下又不可以 再比如 gcc 下可以 msvc 下又不可以...... 只以标准规定的来做
  * > c++标准这东西 还是多写代码吧 做的多了 就慢慢熟悉了 不过嘛 平常一定按照标准规定的流程做 总没错的
  * > 虽然其他的方法也能解决问题 但是也容易带来很多问题
  * > 总结就是 该初始化就初始化 把控好 c++的各种隐式的默认行为 能使用明确的 就不要依赖隐式默认的
- > C++主要问题是给码农的权限太高了，随随便便你就可以瞎搞内存。 <br> 我见过一个奇葩的就是有个数组每次都访问越界，不过其实越界了多数情况下也没什么问题，两个函数以后就切掉了。 <br> 但是就只有越界的时候恰好后面的内存里是某些特殊符号就会出问题。 <br> 所以就谁分到那块内存谁倒霉，表现就是随机炸。你最后 Debug 去吧，鬼知道哪天才能复现。 <br> 查出这个问题的时候也是运气好，恰好挂着调试器，它恰好炸了。。。
- > struct alignment 和 padding 的问题在 C 一样会有吧。 <br> 这事情跟没有初始化也没啥关系吧，这里问题是用了错误的比较方法。`GID gid2=gid1` 就是 well-defined 的初始化。懒得写比较函数的可以看看显式声明比较函数能不能用而不是用 `memcmp` 这种依赖 UB 的行为。
- > 真要搞这种字节对比，就应该给 `struct` 加上 `#pragma pack(1)`
- > 不是应该重载==做判断吗，怎么还能用内存判断相等
- > 这种比较方法的使用在大部分情况下是有问题的 这是可以确认的
  * > 最终原因就未初始化的结果 是未知的 op 也贴了问题所在 这种隐式的默认行为编译器也有差异问题 ***之所以 debug 模式下没问题 归根就是编译器的特殊处理的结果*** 其实也没必要讨论的 明显就是用错了 C4700 的警告 最新的 vc++下是视为错误的 g++ clang++ 倒是没错 但是这本身就是未知的行为 所以实现也有各自的差异 但是把个别编译器对这种未知行为的默认实现 当作标准来用就带来的 现在的问题
    ```c++
    #include <iostream>
    #pragma pack(8)
    struct AA
    {
      bool m;
      int k;
      bool d;
    };
    int main()
    {
      AA a;
      AA b = a;
      
      for (int i = 0; i < sizeof(a); i++)
      {
        std::cout << std::hex << (unsigned int)(((unsigned char*)&a)[i]) << ",";
      }
      std::cout << std::endl;

      for (int i = 0; i < sizeof(a); i++)
      {
        std::cout << std::hex << (unsigned int)(((unsigned char*)&b)[i]) << ",";
      }
      std::cout << std::endl;

      return 0;
    }
    ```
  * > a 未初始化结果
    ```sh
    g++ -Os main.cpp
    0,0,0,0,0,0,0,0,80,22,2,91,
    0,0,0,0,0,0,0,0,80,22,2,91,

    clang++ -Os main.cpp
    b4,34,e2,4b,ff,7f,0,0,0,0,0,0,
    c0,12,40,0,0,0,0,0,d0,10,40,0,
    ```
  * > 如果把 a 做零初始化后 `AA a{}; AA b=a;`
    ```sh
    g++ -Os main.cpp
    0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,

    clang++ -Os main.cpp
    0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,
    ```
    > 初始化后的结果是一样的
  * > 也不是说必须要主动的做零初始化 毕竟很多时候 做零初始化是多余的 不过就是很多时候是依赖编译器优化 还是自己主动优化 自己手动优化就要注意更多的细节
  * > 总结就是 对结构跟类用 memcmp 做比较是存在问题的
  * > 对未初始化的变量的使用上 是要注意的 不要依赖编译器对这种未知行为的实现 因为本身就是未知的行为 不是语言标准的规定 所以编译器实现上也没有必要的统一实现 结果上不同正常的 但是不要把对这种未知行为的实现 当成语言的标准来使用 (除非限定使用前提 ) 比如 此代码 必须在 g++ 甚至指定版本 指定 debug 下运行....

# 2

Debug 的时候又遇到这种灵异事件了 https://www.v2ex.com/t/837189
```console
CPP 写嵌入式代码，有个中等概率复现的 Bug ，在怀疑的地方写了行 printf 调试输出，Bug 便再也不复现。删掉调试输出，Bug 又出来了……
```
- > debug 版本合 release 版本不一样，还有内存越界这类如果破坏到堆栈了，可能加一行代码就结果不一样了。
- > 要是硬件时序问题，那就难搞了。。。
- > 编译器版本高的话可以试试看能不能链上 `AddressSantinizer` ，专治内存疑难杂症
- > 一般都是堆栈问题，仔细看一些调用地方，尤其是参数是数组的，我最近也被坑过一次
- > 很正常，我司很多驱动也会这样，加的 log 多就没问题，log 一去掉，就不行，跟硬件响应时间，时序啥的有关系
- > 不知道是裸跑，還是小系統，還是 linux 用戶空間 <br> 按照關鍵字查一遍：堆棧、越界、對齊、dma 、cache <br> 大多数人會選擇把問題藏起來，越藏日后越會遇到問題，就更加沒法查，只有選擇找到並解決根本問題才能真正成為高手 <br> 嵌入式一般不建議用 c++，查底層問題會麻煩一些
- > strip 之前导出符号表，异常的时候把内存镜像转储
  > 
  > 找到崩溃点，x86 是 esp ，arm 是 sp ，顺着栈里面找 callback 。开源的工具很多的
- > 曾经在生产环境发生过程序崩溃问题，代码审查怎么也找不到可疑代码，崩溃转储出来的内存分析验尸也找不到导致问题的原因。 <br> 最后实在没办法了跟甲方摊牌，对方同意直接在 debugger 里面跑程序，这才把 bug 给灭了
- > 把要打印的变量 传递到全局变量 换个地方打印试试呢
- > 可能是内存踩踏。添加的 print 语句可能刚好让指令或内存对象排布进入了一个调和状态，让漏洞无法再暴露
- > 是不是别处修改了这个变量，然后因为没有 volatile 就默认不会变化，优化掉了，加了 print 打破了优化
