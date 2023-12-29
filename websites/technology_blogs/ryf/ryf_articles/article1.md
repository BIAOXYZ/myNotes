
# 1

【[:ok:][:star:][`*`]】 为什么寄存器比内存快？ https://www.ruanyifeng.com/blog/2013/10/register.html || Friday Q&A 2013-10-11: Why Registers Are Fast and RAM Is Slow https://www.mikeash.com/pyblog/friday-qa-2013-10-11-why-registers-are-fast-and-ram-is-slow.html || https://cloud.tencent.com/developer/article/1094885
- > 计算机的[存储层次](https://zh.wikipedia.org/wiki/%E5%AD%98%E5%82%A8%E5%B1%82%E6%AC%A1)（memory hierarchy）之中，[寄存器](https://zh.wikipedia.org/wiki/%E5%AF%84%E5%AD%98%E5%99%A8)（register）最快，内存其次，最慢的是硬盘。![](https://www.ruanyifeng.com/blogimg/asset/201310/2013101401.png)
- > 同样都是晶体管存储设备，为什么寄存器比内存快呢？
- > [Mike Ash](https://www.mikeash.com/pyblog/friday-qa-2013-10-11-why-registers-are-fast-and-ram-is-slow.html)写了一篇很好的解释，非常通俗地回答了这个问题，有助于加深对硬件的理解。下面就是我的简单翻译。
- > **原因一：距离不同**
  * > 距离不是主要因素，但是最好懂，所以放在最前面说。***内存离CPU比较远，所以要耗费更长的时间读取***。
  * > ***以`3GHz`的CPU为例，电流`每秒钟`可以振荡`30亿`次，`每次`耗时大约为`0.33纳秒`。<ins>光在`1纳秒`的时间内，可以前进`30厘米`</ins>。也就是说，<ins>在CPU的`一个时钟周期内`，光可以前进`10厘米`</ins>。因此，如果内存距离CPU超过`5厘米`，就不可能在一个时钟周期内完成数据的读取，这还没有考虑硬件的限制和电流实际上达不到光速。相比之下，寄存器在CPU内部，当然读起来会快一点***。
    >> 【[:star:][`*`]】 //notes：每次看到这段，都禁不住感叹人类的伟大！！！
  * > 距离对于桌面电脑影响很大，***对于手机影响就要小得多***。手机CPU的时钟频率比较慢（iPhone 5s为`1.3GHz`），***而且手机的内存紧挨着CPU***。
- > **原因二：硬件设计不同**
  * > 苹果公司新推出的iPhone 5s，CPU是A7，寄存器有`6000多位`（`31`个`64位寄存器`，加上`32`个`128位寄存器`）。而iPhone 5s的内存是`1GB`，约为`80亿位（bit）`。这意味着，高性能、高成本、高耗电的设计可以用在寄存器上，反正只有6000多位，而不能用在内存上。因为每个位的成本和能耗只要增加一点点，就会被放大80亿倍。
  * > 事实上确实如此，***内存的设计相对简单，每个位就是一个电容和一个晶体管，而寄存器的设计则完全不同，多出好几个电子元件。并且通电以后，寄存器的晶体管一直有电，而内存的晶体管只有用到的才有电，没用到的就没电，这样有利于省电***。这些设计上的因素，决定了寄存器比内存读取速度更快。
- > **原因三：工作方式不同**
  * > 寄存器的工作方式很简单，只有两步：
    ```console
    （1）找到相关的位，
    （2）读取这些位。
    ```
  * > 内存的工作方式就要复杂得多：
    ```console
    （1）找到数据的指针。（指针可能存放在寄存器内，所以这一步就已经包括寄存器的全部工作了。）
    （2）将指针送往内存管理单元（MMU），由MMU将虚拟的内存地址翻译成实际的物理地址。
    （3）将物理地址送往内存控制器（memory controller），由内存控制器找出该地址在哪一根内存插槽（bank）上。
    （4）确定数据在哪一个内存块（chunk）上，从该块读取数据。
    （5）数据先送回内存控制器，再送回CPU，然后开始使用。
    ```
  * > ***内存的工作流程比寄存器多出许多步。每一步都会产生延迟，累积起来就使得内存比寄存器慢得多***。
  * > 为了缓解寄存器与内存之间的巨大速度差异，硬件设计师做出了许多努力，包括在CPU内部设置缓存、优化CPU工作方式，尽量一次性从内存读取指令所要用到的全部数据等等。
- 回复里的：
  * > ***这篇文章让我震惊的是潜意识里被认为是非常大的光速居然也是限制性因素，想想数量级确实只有`10^8`***
    >> 不能同意更多，之前对光速度概念都是光年什么的，没想到在计算机中竟然也是限制。。。。
    >>> 确实令我震惊，同时有一种大开眼界的感觉
  * > 我觉得有个很重要的问题没说到，根据计算机组成原理的知识，由于硬件设计不同，内存会掉电，要定时刷新充电，而寄存器的电总是满满的，这点不但影响了寄存器和内存的速度差异，也影响了他们的容量差异（单位体积的容量）
    >> 正解。***像A7这样的DRAM和CPU封装到一起了延迟影响不大***. 主要速度和成本区别在于register是寄存器做的，cache用`SRAM`,而内存是`DRAM`做的。
    >>> ***我觉着寄存器和内存都属于易失存储都不能掉电***。内存和寄存器差别在于一个是DRAM一个SRAM，存储单元的结构造成了他们的速度差别。***您所说的内存掉电可能指的是DRAM的刷新过程，的确这个过程造成了延迟***。
  * > 从计组的角度来看寄存器是稳态电路触发器不是存储器,这篇文章是想比较cache和内存？一个是SRAM一个DRAM用得着比？严重怀疑这作者没本科文凭
    >> 用不着这么激动。不妨当成另外一个角度看问题。
    >>> 作者能让没本科文凭的人明白，你不能。
  * > “在CPU的一个时钟周期内，光可以前进10厘米。因此，如果内存距离CPU超过5厘米，就不可能在一个时钟周期内完成数据的读取”这句话是不是有矛盾？也有可能是我没理解这句话的意思
    >> 意思是“读取”，就是往返
    >>> 从内存中读出来,再送回内存.我是这么理解的
  * > 看来很多人跟我一样，是想进来喷的 <br> 然后看了之后，只能说“不能同意更多" <br> 这让我们第一次意识到我们身边有的东西已经可以光速进行比较了 <br> 不说图有点旧啊
  * > ***可以去看看英文原文的评论，里面提到了很多有意义的信息，也可以加深理解***。
  * > 惊讶光速的应该是做纯软件吧。***高速电路里面，<ins>内存到cpu的总线必须要满足等长，不然有的bit到得早，有的到得迟，就乱了。所以PCB上很多弯弯曲曲的蛇形线就是用来凑长度的</ins>***。
  * > 上次去wiki搜 flash memory，顺着搜了DRAM和CPU，可以分的很清晰。 <br> 寄存器由好多个晶体管组成，成本高，和CPU同频好象（速度就在这里体现出来了）可以直接在寻址，而内存RAM之类电路简单，每个bit一个管，由电容存储数据，需要专用电路来不停的刷新电容保持数据不丢，也需要专门的寻址电路接口什么的，频率好象是和主板一样（板频是cpu的几分之一，慢），读写也要好多个指令周期。 <br> 基本上就是这样，可以自己去wiki. <br> 最好玩的是关于flash，就是我们用的U盘和固态硬盘，原来用浮闸Mos管做的，把电荷永久封在闸里，根据每个管能存的bit数不同还分为SLC,MLC,TLC，TLC是一管有3个状态电位，当然可靠性就更差，一直想去找个工具查一下我的U盘是哪种，没找到。
  * > 看了这篇日志，让我突然想起，现在的计算机真的太高级了，以至于大多数的使用者不知道了一些硬件常识！ <br> 现代计算机，虽然性能很高，但是和上世纪7、8十年代的计算机比，其实结构都差不多。现在讲存储，一般讲有内存和外存，内存一般有寄存器(register)，缓存(cache)和内存(memory)，有些小型应用例如MCU没有cache，甚至没有memory——直接从flash/ROM到register。寄存器是CPU基础单元，CPU直接处理的内存就它了，***好比医院，医生对面的椅子就是寄存器，要看病的病人(data)就座这个椅子(register)；已经挂号的(data)进入诊室(cache)排队，其他的就在医院里（memory）***。医生可以操作的就是面对面的病人，其他人要看病（如急病）也需先坐上这个位置，这是最快的。诊室里的座位相对于cache，一般cache都是sram存储器，速度很快，但一般cpu不会直接访问，而是要把数据挪到register后才可直接操作，而一般的内存为DRAM，速度比SRAM慢多了，而且通过总线访问，速度就更慢了。 <br> 应该说这不完全是距离问题，而是内存结构和总线结构和访问方式的问题。
  * > 这主要是SRAM和DRAM的差异，***DRAM为了节约晶体管，用了电容器维持电位，但电容器会漏电，需要周期性刷新，<ins>刷新期间不能读写</ins>***
  * > 总结的很好。***『深入理解计算机系统』***一书中讲的也不错
  * > 第三条完全是第二条导致的啊，是因为设计不同才导致的使用方式不同。
  * > "而内存的晶体管只有用到的才有电，没用到的就没电"这句话不对吧。DRAM是一直需要刷新的。
  * > 那显卡里面的显存呢？应该比内存快把 比寄存应该慢了点
  * > “电流实际上达不到光速” 这句话说得不妥。 <br> ***一般来说导体中电子移动速度是很慢的，米每秒级，但是电场建立的速度是很快的，与光速相同，这里要关心的是电场建立的速度***。但是三十万公里每秒是在真空中的速度，在介质中速度会低一些。
  * > 疯狂的程序员那个小说的作者当年是写汇编的，他同时用C++，当时他俩都是菜鸟，在哪互相比较汇编和C++。小说作者说，我什么都放到寄存器里运算，你算数我位移，你还能比我快？ <br> 几年之后，那个小说作者说，寄存器比内存快原因是因为寻址。`mov ax,bx`和`mov ax,[bx]`速度肯定不一样啊。当然了，他是从OS的角度说的。
  * > 在看JVM的书，***提到`“物理机会比虚拟机快一些，因为物理机能直接利用寄存器，而虚拟机基于栈，也就是内存”`***，感到疑惑，看了帖子之后豁然开朗。感谢！
    >> ***虚拟机基于栈说的是硬件编程模型上，最终运行还是基于寄存器的。之所以慢是因为中间层的消耗，并不是说虚拟机的运算时存储使用的是内存上的栈，栈最终还是会加载到寄存器中***，因为汇编语言操作的是寄存器。
  * > 我觉着其实关键因素还在设计、制造成本上，寄存器一般都使用SRAM实现而内存使用DRAM实现。 <br> ***SRAM比DRAM更快速、功耗更低（尤其是空闲状态，但SRAM功耗取决于它的访问频率，DRAM一般有固定刷新频率），所以从性能方面SRAM超越DRAM很多***。 <br> 从设计与制造成本 ***一般教材的SRAM单元有6个晶体管，DRAM有3个晶体管。更多的晶体管意味着更复杂的连线更昂贵的设计成本，更大的硅晶占用面积***。 <br> https://zh.wikipedia.org/wiki/%E9%9D%99%E6%80%81%E9%9A%8F%E6%9C%BA%E5%AD%98%E5%8F%96%E5%AD%98%E5%82%A8%E5%99%A8
  * > http://www.cypress.com/knowledge-base-article/sram-and-dram-difference SRAM和DRAM的区别，讲的挺好。当时学的，现在都忘了
- [英文原版](https://www.mikeash.com/pyblog/friday-qa-2013-10-11-why-registers-are-fast-and-ram-is-slow.html)里的回复：
  * > One other wrinkle is that, in the event RAM is full, the OS starts paging, placing RAM pages on disk (and having to go to disk to read that memory again). <br> The iPhone doesn't have paging (last I checked, at least), and will terminate applications that go above their memory quota (and send a low-memory warning to them before doing so). General purpose computers don't have this flexibility and have to deal with applications requesting more memory than is available in RAM. <br> Anyway, paging isn't necessarily germane to an article about the iPhone's memory layout, but it has a pretty big effect on workstation performance.
  * > You missed explaining the most important detail, and the real culprit: it's not about distance or the speed of light/electricity, it's about ***THE DELAYS IN SIGNAL PROCESSING that occurs in the memory controller*** etc.
