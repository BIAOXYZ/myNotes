
# 较系统攻略

Makefile 教程（译） https://www.v2ex.com/t/783648
```console
出于个人兴趣，翻译了一个 Makefile 教程，原作： https://makefiletutorial.com
中文版： https://makefiletutorial.vercel.app
```
>> Makefile Tutorial by Example https://github.com/theicfire/makefiletutorial

# 其他攻略

Make 命令教程 http://www.ruanyifeng.com/blog/2015/02/make.html

Makefile条件编译debug版和release版 https://www.cnblogs.com/caosiyang/archive/2012/06/13/2548051.html

Makefile missing separator. Stop.怎么解决 https://blog.csdn.net/limanjihe/article/details/52231243

# 问题

## 并行编译的 `-j`（`--jobs`）参数引起的问题
>> //notes：同样的项目，同样的环境，有的用 `make -j4` 能编过，但是我这边就是不行，换成 `make` 直接就过了。之前碰到过类似的，貌似是内存不够了；更早之前在编译pg的时候也遇到过，是把 `make -sj8` 换成 `make`。反正不管哪一次，都是老老实实用基本的 `make` 就可以了。原因嘛，除了内存不够那次比较明显，其他都没太找到，感觉下面这个文章里说的顺序错乱的问题是有一定可能的。

The Pitfalls and Benefits of GNU Make Parallelization https://www.cmcrossroads.com/article/pitfalls-and-benefits-gnu-make-parallelization
