
# for 循环变量大小不同在内外层的性能问题

第 120 题：为什么for循环嵌套顺序会影响性能？ https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/235
- > 两个循环的次数的是一样的，但是 j 与 k 的初始化次数是不一样的
  * > 第一个循环的 j 的初始化次数是 100 次，k 的初始化次数是 10w 次
  * > 第二个循环的 j 的初始化次数是 1w 次， k 的初始化次数是 1000w 次
  * > 所以相同循环次数，外层越大，越影响性能
- > 循环次数少的放在外层，减少内层变量的操作(初始化，比较，自增等)次数吧。

Why is a big loop within a small loop faster than a small loop within a big one? https://stackoverflow.com/questions/23107563/why-is-a-big-loop-within-a-small-loop-faster-than-a-small-loop-within-a-big-one

A big loop within a small loop always faster than a small loop within a big one? https://stackoverflow.com/questions/23914350/a-big-loop-within-a-small-loop-always-faster-than-a-small-loop-within-a-big-one

在有循环嵌套时, 要把大循环写在内, 小循环写在外, 原因在此 https://blog.csdn.net/xiaohuh421/article/details/44056189

## 第二批

内外大小循环耗时的底层分析 https://zhangjinkun.com/2016/06/01/fc50d06453c32324f61d9f7a12ec88fc/  【[:star:][`*`] //notes：这篇文章是这一类里唯一一个结论相反的。。。关键还图文并茂的- -回头有空再细看下吧。。。】
- > 结果还是比较明显的，大循环在外面，小循环在里面的速度远远快于大循环在里面，小循环在外面的速度，原因分析见下。

关于嵌套循环效率研究 https://www.cnblogs.com/tolimit/p/4276844.html
- > **引言**
  * > 大家都知道，当进行嵌套循环时，大循环放最外面和放最里面所造成的执行效率会不同，***本篇文章会通过汇编代码进行分析具体情况***。

for循环实战性能优化 https://www.cnblogs.com/east7/p/11602476.html
- > **1 嵌套循环**
  * > 两者耗时对比：
    ```console
    外大内小耗时：756859726
    外小内大耗时：451345484
    ```

两层for循序的，大的循环尽量在里面，小的循环尽量在外面。 https://blog.csdn.net/fsdf8sad7/article/details/102820669
- > 像以下的代码块,尽量不要将大循环放到外层循环。原因是CPU使用到分支预测技术，以上一个的判断来预测下一个判断。像以下代码大概会判断错误100次，如果换过来则判断错误100000次。而CPU设计引入了分支预测技术，主要是减少指令跳转的时候重新获取新指令。两层循环数差距越大，性能相差越明显。
  ```c
  for(int i = 0; i < 100; i++){
    for(int j = 0; j < 100000; j++){
      ......
    }
  }
  ```
