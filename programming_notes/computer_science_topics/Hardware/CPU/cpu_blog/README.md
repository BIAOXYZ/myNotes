
CPU 深夜狂飙，一帮大佬都傻眼了・・・ https://www.ithome.com/0/656/692.htm || https://mp.weixin.qq.com/s/HWfSdwfYnknJEhfaTPOhyw
- > “部长，我俩都是遍历的 `/proc/` 目录下的内容，按理说，所有的进程都会在这里啊，我也想不通为什么找不到・・・”，`top` 老哥委屈的说到。
- > “就是通过 `opendir`/`readdir` 这些系统调用函数来遍历的，这都是帝国提供的标准接口，应该不会出错，除非・・・”，说到这，`top` 打住了。 <br> “除非什么？” <br> “除非这些系统调用把那个进程给过滤掉了，那样的话我就看不到了，难道有人潜入帝国内核，篡改了系统调用？”
- > 眼看部长急的团团转，一旁的 `netstat` 起身说到：“部长，我之前结识一好友，名叫 `unhide`，捉拿隐藏进程是他的拿手好戏，要不请他来试试？”
- > `top` 有点表示怀疑，问到：“敢问兄台用的什么路数，为何我等都看不到这几个进程的存在？” <br> unhide 笑道：“没什么神秘的，其实我也是遍历 `/proc/` 目录，和你们不同的是，我不用 `readdir`，而是从进程 id 最小到最大，挨个访问 `/proc/$pid` 目录，一旦发现目录存在而且不在 `ps` 老哥的输出结果中，那这就是一个隐藏进程。” <br> 一旁的 `ps` 笑道：“原来还有我的功劳呐”
- > “大家请看，进程打开的文件都会在 `/proc/pid/fd` 目录下，socket 也是文件，我刚看了一下，这个进程刚好有一个 socket。再结合 `/ proc / tcp` 信息，可以确定这个 socket 就是目标端口号 7777 的那一条！”

CPU 加了缓存后，有人急了～ https://www.ithome.com/0/654/674.htm || https://mp.weixin.qq.com/s/pntcKUaCyetWHDsOZHwU2Q

主板上这家伙，要当 CPU 和内存的中间商 https://www.ithome.com/0/652/903.htm || https://mp.weixin.qq.com/s/UKPagzvcwyY5RzOLWIff5g

中断还是轮询？取个数据包真麻烦 || https://mp.weixin.qq.com/s/QmZP0P4BrSJ1p6YI6cmyVQ

什么？一个核同时执行两个线程？ https://www.ithome.com/0/646/476.htm || https://mp.weixin.qq.com/s/HwDqCk8vtMdSEVSCLHAsbg

就为了一个原子操作，其他 CPU 核心罢工了 https://www.ithome.com/0/645/439.htm || https://mp.weixin.qq.com/s/jx0EajGXGrM3fR14P9Bm7Q

一个整数＋1 引发的灾难 https://www.ithome.com/0/645/040.htm || https://mp.weixin.qq.com/s/hFWSItFYIzWLr_RFne2lBA

CPU 瞒着内存竟干出这种事 https://www.ithome.com/0/644/894.htm || https://mp.weixin.qq.com/s/Pm_jdPUB_9Aq8hhpbrF5QA

可怕！CPU 竟成了黑客的帮凶 https://www.ithome.com/0/644/724.htm || https://mp.weixin.qq.com/s/XEDCCQntIRghWhfigciWSA  【from `编程技术宇宙`】

完了！CPU 一味求快出事儿了 https://www.ithome.com/0/644/626.htm  【from `编程技术宇宙`】
- 回复里的：
  * > 乱序执行部分实际上既讲了流水线，又讲了乱序执行，而乱序执行部分反而比较短，也没有配图，可能会造成混乱。 <br> 乱序执行是基于这样的事实，即一些指令并不能在一个运算(Execute)周期内完成，比如乘法和除法可能需要高达几十周期，而负责数值计算的组件ALU支持的各种运算可以同时进行，甚至许多架构中同一个核心会配备多个进行同种运算的单元。这样在计算 c=b×a 的同时，如果下一个指令与上一条指令运算结果无关，比如 d=b+a，就可以同时运行；而如果下一条指令依赖上一条的结果，比如 e=c-b，就需要等待c的值计算完成。这种并行被称为指令级并行。 <br> 至于如何确定指令之间的依赖关系，以及如何管理指令的执行与等待，就相对复杂，可以自行搜索tomasulo算法。这也是为什么现代处理器分成前端和后端，以及可以使用数量远多于指令集所支持的寄存器的原因
    >> 好家伙，昨天刚考完tomasulo算法，感觉又复习了一遍计算机体系结构
  * > 通俗易懂的讲解方式，并不代表就要用这种幼稚的表达方式，好好说人话也可以做到通俗易懂的讲解的。建议可以去看看B站硬件茶谈的科普视频
