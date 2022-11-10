
# py-spy

漫画：如何分析运行中的Python程序？ https://juejin.cn/post/6844904062433886215 || https://www.163.com/dy/article/F7CLDCVB05318EB9.html
- > **使用`py-spy`**
  * > 通过 pip 安装 py-spy
    ```sh
    pip3 install -i https://pypi.doubanio.com/simple/ py-spy
    ```
  * > 首先来使用top命令，它会生成类似Unix系统中top命令的效果，它有两种使用方式，分别如下。
    ```sh
    # 如果python程序正在运行，直接通过pid进行采样
    sudo py-spy top --pid 12345
    # OR
    # 如果python程序没有运行，可以使用如下命令
    sudo py-spy top -- python myprogram.py
    ```
  * > 此外，还可以让py-spy生成火焰图（flame graph），通过火焰图可以更直观的判断出程序的性能情况。py-spy生成火焰图只需使用record命令则可，与top命令类似，同样有两种使用方式，如下。
    ```sh
    py-spy record -o profile.svg --pid 12345
    # OR
    py-spy record -o profile.svg -- python myprogram.py
    ```
    > 如果你不清楚怎么看火焰图，不用紧张，后面会介绍火焰图的使用方法。
  * > 如果你的程序突然卡死了，你又不清楚它为何会卡死，此时就可以通过py-spy的dump命令来查看当前程序的调用堆栈，通过调用堆栈来判断Python程序挂在何处。dump命令只能用于正在运行的Python程序。
    ```sh
    py-spy dump --pid 12345
    ```
- > **读懂火焰图**
  * > 火焰图通常是svg图片，可以直接通过Chrome浏览器打开。
  * > py-spy生成的火焰图其火焰是向下的，而有些工具生成的火焰图其火焰是向上，样式不同，但没有什么本质区别。
  * > 看到刚刚py-spy生成的火焰图。![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/2/10/1702f4bae5bb683a~tplv-t2oaga2asx-zoom-in-crop-mark:3024:0:0:0.awebp)
  * > 火焰图的y轴表示程序的调用栈，每一层都是一个函数，调用栈越深，火焰就越高，最底部就是当前正在执行的函数，上方都是它的父函数。
  * > 火焰图x轴表示抽样数，如果一个函数在x轴占据的宽度越宽，表示它被抽样程序抽到的次数越多，也就表示该方法的执行时间较长。
  * > 需要注意，火焰图x轴不代表时间，而是所有调用栈合并后，按字母顺序排列而成。
  * > 此外，火焰图的颜色没有特殊含义。
  * > 火焰图是可以互动的。

Python 程序如何定位到 cpu 占用过高的代码呢 https://www.v2ex.com/t/829743
- > https://github.com/emeryberger/scalene
  >> Scalene: a high-performance, high-precision CPU, GPU, and memory profiler for Python https://github.com/plasma-umass/scalene
- > https://github.com/benfred/py-spy
- > dtrace / bpftrace
