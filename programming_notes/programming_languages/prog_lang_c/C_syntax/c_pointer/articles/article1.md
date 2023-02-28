
# 1

你管这叫指针？ https://www.ithome.com/0/666/763.htm || 你管这破玩意叫指针？ https://mp.weixin.qq.com/s/GVssqBoHWsOsRKTHXZR1lA
- > 本系列分三篇，用破玩意的方式彻底理解好指针的本质：
  * > 你管这破玩意叫指针 -- 基础篇
  * > 你管这破玩意叫指针 -- 进阶篇
  * > 你管这破玩意叫指针 -- 变态篇
- > 内存，通常被严谨地画成下面这个样子，一个下方是低地址上方是高地址的格子楼。
- > **三、变量定义与赋值**
  * > 其中变量的定义是为了方便程序员后面去用它，这部分不是给 CPU 看的。
  * > 而变量的赋值才是真正在内存中把数据放进去，这部分才真正涉及 CPU 具体指令的执行。
  * > 也就是说，如果你仅仅定义了一个变量 `int a;` 但是没有给它初始化的赋值操作，那么最终在 CPU 执行指令的时候，这个定义根本就没有任何体现。
- > **四、指针**
  * > 当然你不服，你就想让这个 `int *` 类型的指针变量，就真真正正在数值上只 +1，也就是让 p 等于 2，该怎么办呢？很简单，分成三步就好了：
    + > 第一步，把 `int *` 类型的 p 强转为 `char *` 类型的 p。
    + > 第二步，p + 1。
    + > 第三步，再把 `char *` 类型的 p 强转为 `int *` 类型。
    + > 完事！用代码表示就是：`p = (int *)((char *)p + 1);`
  * > 你会看到，C 语言项目中经常使用这样的玩法。
  * > 当然，你这一顿花里胡哨的操作，在 CPU 眼里，就是对一个内存地址处的值简简单单地 +1 而已。
- > **五、指针的本质**
  * > 我还可以把一个地址值，强行赋值给一个普通变量：
    ```c
    int a = 1;
    int b = &a;
    ```
    > 这时普通变量 `b` 里面存储着 `a` 的地址，我 `*b` 也同样可以访问到 `a` 并修改它的值：
    ```c
    *b = 999;
    ```
    > ***当然如果你真这么写编译器会报错，但没关系，我们可以先把普通变量 `b` 强转为指针变量，然后再 `*` 它***：
    ```c
    *(int *)b = 999;
    ```
  * > 当然啦，以上都是方便理解的伪指令，具体落实到真正的汇编语言，我会在后续的章节中讲述，直接从汇编语言理解指针，你就会发现指针就是个工具人而已。
- > **六、写在最后**
  * > 至此，我们的《你管这破玩意叫指针 -- 基础篇》就讲完了。
  * > 我们从最开始的内存格子出发，逐渐推导出类型系统和变量的作用，进而再引出本质上和普通变量没有任何区别的指针变量，最后再推导出指针变量相关的操作，带你看清了指针的本质。
  * > 最后，给大家推荐两个网站。
    + > 一个是可以将 C 语言代码实时编译成汇编代码，你可以用它来自己玩指针做实验，看它最终到 CPU 指令层面是什么样。 <br> https://godbolt.org
    + > 一个是 GNU C 手册，里面对各种语法和作用讲述的非常清楚，不要再用搜索引擎搜博客了。 <br> https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html
  * > 我相信本文看下来，一定有人想问，`short * p` 是不是应该写成：
    ```c
    short *p
    ```
    > 或者
    ```c
    short* p
    ```
    > 自己去上面的文档里找答案即可。
- 回复里的：
  * > 胡乱访问，strict-aliasing警告
  * > 一大半软件BUG都是直接或者间接地由指针造成，所以在可以用指针也可以不用指针的地方，不用指针，是软件可靠性提高的秘诀。
    >> 堆上开资源是逃不了的, 关键还是理清对象的所有权.