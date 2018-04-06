
### 环境变量

<<Windows下PATH等环境变量详解>>
https://www.cnblogs.com/sunada2005/articles/2725277.html

> 虽然长，不过写的很好。绝大部分知识其实都知道了，但这个帖好的地方在于讲出了通用性。Linux下的环境变量也是这么一套方法。其实主要目的是搜索Windows下两个百分号括住一个变量名（比如 %GOROOT% ）是啥意思，也得到了解答:
```
set path=%path%;D:\Java\jdk1.6.0_24\bin

     把PATH放在两个百分号之间，指把PATH原有的值取出。
```
> 也就是Windows下的%var%等于Linux下的$var呗。

~顺便记几个Linux下的环境变量相关的帖子~

- Linux环境变量详解 - CSDN博客 https://blog.csdn.net/gatieme/article/details/25975465
- 【Linux】完全解读Linux环境变量 - CSDN博客 https://blog.csdn.net/xyw591238/article/details/51770247

### VPNs

SetupVPN
http://desktopclient.net/gw/index.html#/

###

<<解决Windows下修改环境变量后需重启才能生效的问题>>
http://blog.sina.com.cn/s/blog_49370c500100ov36.html
```
在“我的电脑”->“属性”->“高级”->“环境变量”中增加或修改环境变量后，需重启系统才能使之生效。
有没有什么方法可让它即时生效呢？下面介绍一种方法：

以修改环境变量“PATH”为例，修改完成后，进入DOS命令提示符，输入：set PATH=C: ，关闭DOS窗口。
再次打开DOS窗口，输入：echo %PATH% ，可以发现“我的电脑”->“属性”->“高级”->“环境变量”中设置的 PATH 值已经生效。

不用担心DOS窗口中的修改会影响环境变量的值，DOS窗口中的环境变量只是Windows环境变量的一个副本而已。
但是对副本的修改却会引发Windows环境变量的刷新，这正是我们想要的！
```

###

狗日的2345劫持，真TM服了，用了一堆知乎上的办法，下了好多软件，都不管用。最后是V2EX的办法——360杀毒的急救箱搞定的。。。

遇到最顽固的 2345 首页劫持，网上各种方法都试了
https://www.v2ex.com/t/214388

浏览器启动页被2345劫持怎么办？ - 知乎
https://www.zhihu.com/question/23157265

为什么 Chrome 浏览器的主页会被篡改为 hao123 ？遇到这种情况要如何修复？ - 知乎
https://www.zhihu.com/question/21883209
