
🌀 中国独立博客列表 https://github.com/ns2250225/chinese-independent-blog
- SaltTiger -- 每天一本编程书，每天进步一点点 https://salttiger.com/

--------------------------------------------------
## Matrix67
--------------------------------------------------

不可解问题(Undecidable Decision Problem) http://www.matrix67.com/blog/archives/55
```
    看黑书介绍NP的时候有一个“不可解问题”，非常不可思议，费劲周折在网上查到了些英文资料，搞明白了，非常有意思，在这里说一下。
    不可解问题(Undecidable Decision Problem)指的是这样一种问题：他无论如何也不可能有一个正确的算法来解决。虽然不可思议，但这种问题被证明确实是存在的。图灵在1936年（那时还没电脑，我们的父亲是在没有设备支持的纯理论基础上提出来的，致敬）提出了第一个不可解问题的实例：The Halting Problem。
    The Halting Problem是问，输入一段程序代码和一个针对此程序的输入，能否编程判断运行这个程序后程序是否会终止。
    这个问题的答案是否定的。也就是说，不可能有一种算法可以正确判断一个指定的程序运行后，给予指定的输入，程序最后出不出得来。换句话说，The Halting Problem是一个不可解问题。
    虽然这感觉似乎不可能，但在严格的证明下谁也无法发言反对。
    证明过程非常简单，假设The Halting Problem是有解的，并且已经用程序实现了，那么我们只需要再编写一个程序Program Bug，就会发现存在矛盾。
    
    反证：既然解决The Halting Problem的算法已经实现了，那么我们一定能定义一个函数
    
Function Halting(a,b:input_type):boolean;

    其中，a是读入的程序源码，b是输入数据。这个函数的功能就是返回对于指定的程序源码和输入数据，程序是否能顺利退出。
    下面编写一个程序：
    
Program Bug;
var
    code:input_type;
begin
   get(code);   //读入code
   if halting(code,code) then repeat until false
      else halt;
end.

    好，现在运行Bug这个程序，并且输入Bug这个程序本身的代码。这样，halting(code,code)其实质就是在判断这个Bug程序本身了。如果The Halting Problem认为Bug程序会正常退出，那么就让程序进入一个死循环，否则立即退出程序。矛盾产生。
    //简直是在挑战表达力极限
    //做人要厚道，转帖请注明出处
```

停机问题、Chaitin常数与万能证明方法 http://www.matrix67.com/blog/archives/901
> 我写一个程序从小到大枚举所有的偶数，看是不是有两个质数加起来等于它：如果找到了，继续枚举下一个偶数；否则输出这个反例并结束程序。然后我编译它。这个编译器不是可以判断我这程序能否终止么？如果编译器说我这个程序会无限执行下去的话……我不就相当于把Goldbach猜想证到了吗？或者，编译器说程序最终会终止，那Goldbach猜想不就直接被推翻了吗？反正，那个证Goldbach猜想的奖金肯定是我的了。

Buffon投针实验：究竟为什么是pi？ http://www.matrix67.com/blog/archives/2494
- Buffon's Needle, the Easy Way http://blog.sigfpe.com/2009/10/buffons-needle-easy-way.html
- Math Surprises: An Example http://www.cut-the-knot.org/ctk/August2001.shtml
> 蒙特卡洛思想及MCMC - CSDN博客 https://blog.csdn.net/u014568921/article/details/46565027


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


--------------------------------------------------
## 弯曲评论
--------------------------------------------------

云来了，安全盒子怎么办
http://www.valleytalk.org/2017/07/27/%e4%ba%91%e6%9d%a5%e4%ba%86%ef%bc%8c%e5%ae%89%e5%85%a8%e7%9b%92%e5%ad%90%e6%80%8e%e4%b9%88%e5%8a%9e/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


--------------------------------------------------
## [始终](https://liam0205.me/)
--------------------------------------------------

在 LaTeX 中使用含有中文的 PDF 书签避免乱码的正确姿势 https://liam0205.me/2014/11/22/latex-pdf-cjk-bookmarks/

LaTeX 黑魔法（四）：插入动画（animate 宏包教程） https://liam.page/2017/08/10/importing-animate-in-LaTeX/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

https://github.com/Liam0205/jsondagcc
- > A C++ Library for Parsing JSON configure file into a DAG (Directed Acyclic Graph).

--------------------------------------------------
## Miskcoo's Space  ([About](http://blog.miskcoo.com/about)) 及其链接的博客
--------------------------------------------------

- 扩展欧几里得算法与中国剩余定理 http://blog.miskcoo.com/2014/09/chinese-remainder-theorem
- 从多项式乘法到快速傅里叶变换 http://blog.miskcoo.com/2015/04/polynomial-multiplication-and-fast-fourier-transform
- 扩展大步小步法解决离散对数问题 http://blog.miskcoo.com/2015/05/discrete-logarithm-problem
- Codeforces 上的一些组合计数问题 http://blog.miskcoo.com/2015/06/codeforces-combinatorics-and-probabilities-problem

### [0.肆玖](http://dna049.com/)

《Lecture on Modules and Rings》读书笔记 http://dna049.com/2017/05/06/Note-on-Lecture-of-Modules-and-Rings/

### [hzwer](http://hzwer.com/) 

http://hzwer.com/2048/

深度强化学习介绍 http://hzwer.com/8908.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

--------------------------------------------------
[飞龙] (https://blog.csdn.net/wizardforcel)
--------------------------------------------------

飞龙的计算机公开课推荐 https://blog.csdn.net/wizardforcel/article/details/79350545

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

--------------------------------------------------
[虫师 测试教程网 主要维护者之一，致力于软件测试技术的分享与推广。](https://www.cnblogs.com/fnng/)
--------------------------------------------------

maven环境快速搭建 https://www.cnblogs.com/fnng/archive/2011/12/02/2272610.html

随笔分类 -linux https://www.cnblogs.com/fnng/category/355466.html by 虫师
- linux那点事儿（四）----用户管理详解 http://www.cnblogs.com/fnng/archive/2012/05/06/2485973.html
- linux那点事儿（五）----用户管理常用命令 https://www.cnblogs.com/fnng/archive/2012/05/13/2498366.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 惨绿少年@clsn.io https://www.cnblogs.com/clsn/

惨绿少年是什么？ https://www.cnblogs.com/clsn/p/8144252.html

sed命令详解 vim高级技巧 shell编程上 https://www.cnblogs.com/clsn/p/7639841.html

惨绿少年shell文章：
- Shell编程基础篇-上 https://www.cnblogs.com/clsn/p/7992981.html
- Shell编程基础篇-下 https://www.cnblogs.com/clsn/p/8006210.html
- Shell编程进阶篇(完结) https://www.cnblogs.com/clsn/p/8028337.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

--------------------------------------------------
## [编程随想的博客] (https://program-think.blogspot.com/)
--------------------------------------------------

- 扫盲 HTTPS 和 SSL/TLS 协议[4]：历史版本的演变及 Record 协议的细节 https://program-think.blogspot.com/2018/09/https-ssl-tls-4.html
- 扫盲 HTTPS 和 SSL/TLS 协议[3]：密钥交换（密钥协商）算法及其原理 https://program-think.blogspot.com/2016/09/https-ssl-tls-3.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## [jeremy的技术点滴] (https://jeremyxu2010.github.io/)

kuberntes中的redis集群性能调优 https://jeremyxu2010.github.io/2019/06/kuberntes%E4%B8%AD%E7%9A%84redis%E9%9B%86%E7%BE%A4%E6%80%A7%E8%83%BD%E8%B0%83%E4%BC%98/

使用vagrant搭建验证环境 https://jeremyxu2010.github.io/2019/03/%E4%BD%BF%E7%94%A8vagrant%E6%90%AD%E5%BB%BA%E9%AA%8C%E8%AF%81%E7%8E%AF%E5%A2%83/

### 代码相关的

编写Kubernetes Operator https://jeremyxu2010.github.io/2019/05/%E7%BC%96%E5%86%99kubernetes-operator/

巧妙调试docker容器 https://jeremyxu2010.github.io/2019/04/%E5%B7%A7%E5%A6%99%E8%B0%83%E8%AF%95docker%E5%AE%B9%E5%99%A8/

使用TravisCI做个人博客的自动构建 https://jeremyxu2010.github.io/2019/03/%E4%BD%BF%E7%94%A8travisci%E5%81%9A%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2%E7%9A%84%E8%87%AA%E5%8A%A8%E6%9E%84%E5%BB%BA/

使用docker in docker https://jeremyxu2010.github.io/2019/02/%E4%BD%BF%E7%94%A8docker-in-docker/

搭建k8s的开发调试环境 https://jeremyxu2010.github.io/2018/08/%E6%90%AD%E5%BB%BAk8s%E7%9A%84%E5%BC%80%E5%8F%91%E8%B0%83%E8%AF%95%E7%8E%AF%E5%A2%83/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## [骏马金龙](https://www.cnblogs.com/f-ck-need-u/)

网站架构从0起步系列文章总目录 https://www.cnblogs.com/f-ck-need-u/p/7576137.html

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## k8s、docker、go等与cloud-native相关的博客 //由于全部是个人网站（尽管有的有公众号或掘金知乎等的页面），所以我对长期存在性略有些存疑。

面向信仰编程 Draveness's Blog https://draveness.me/

胡伟煌个人博客 https://www.huweihuang.com/

Aylei's Blog https://aleiwu.com/

运维之美 https://www.hi-linux.com/

Howtoing运维教程 https://www.howtoing.com/

Cizixs Write Here https://cizixs.com/

世民谈云计算（微信公众号ID：SammyTalksAboutCloud） https://www.cnblogs.com/sammyliu/
- 你云我云•兄弟夜谈会 第一季 企业云 https://www.cnblogs.com/sammyliu/p/10292133.html

aoho's blog - Golang http://blueskykong.com/categories/Golang/

阳明的博客 https://www.qikqiak.com/
- `#kubernetes` https://www.qikqiak.com/tags/kubernetes/

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 华校专blog

【[:star:][`*`]】 huaxz1986 https://github.com/huaxz1986 || http://www.huaxiaozhuan.com/
- 《算法导论》中算法的C++实现 https://github.com/huaxz1986/cplusplus-_Implementation_Of_Introduction_to_Algorithms
  * > 本项目中的所有算法均来自于《算法导论》第三版 另：本人搜集了个人笔记并整理成册，命名为《AI算法工程师手册》，详见: www.huaxiaozhuan.com
- 《UNIX环境高级编程》第三版中文笔记 https://github.com/huaxz1986/APUE_notes
- python_tools https://github.com/huaxz1986/python_tools

AI算法工程师手册 http://www.huaxiaozhuan.com/
- 统计学习
  * 1.线性模型 http://www.huaxiaozhuan.com/%E7%BB%9F%E8%AE%A1%E5%AD%A6%E4%B9%A0/chapters/1_linear.html
  * 7.梯度提升树 http://www.huaxiaozhuan.com/%E7%BB%9F%E8%AE%A1%E5%AD%A6%E4%B9%A0/chapters/7_GBT.html

## ARTHURCHIAO'S BLOG
- Articles (中文) https://arthurchiao.art/articles-zh/
- Articles (EN) https://arthurchiao.art/articles/

[译] [论文] XDP (eXpress Data Path)：在操作系统内核中实现快速、可编程包处理（ACM，2018） http://arthurchiao.art/blog/xdp-paper-acm-2018-zh/ || https://github.com/ArthurChiao/arthurchiao.github.io/blob/master/_posts/2021-08-01-xdp-paper-acm-2018-zh.md


[译] ltrace 是如何工作的（2016） https://arthurchiao.art/blog/how-does-ltrace-work-zh/

[译] strace 是如何工作的（2016） https://arthurchiao.art/blog/how-does-strace-work-zh/

[译] Linux 系统调用权威指南（2016） https://arthurchiao.art/blog/system-call-definitive-guide-zh/ || https://github.com/ArthurChiao/arthurchiao.github.io/blob/master/_posts/2019-01-30-system-call-definitive-guide-zh.md

bcc/ebpf 安装及示例（2019） https://arthurchiao.art/blog/bcc-ebpf-tutorial-zh/

--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
