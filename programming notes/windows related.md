
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


#### 环境变量最相关命令set

Windows 如何在cmd命令行中查看、修改、删除与添加环境变量 - CSDN博客
https://blog.csdn.net/stpeace/article/details/53451744
```
1、查看当前所有可用的环境变量：输入 set 即可查看。
2、查看某个环境变量：输入 “set 变量名”即可，比如想查看path变量的值，即输入 set path
3、修改环境变量 ：输入 “set 变量名=变量内容”即可，比如将path设置为“d:\nmake.exe”，只要输入set path="d:\nmake.exe"。
注意，此修改环境变量是指用现在的内容去覆盖以前的内容，并不是追加。比如当我设置了上面的path路径之后，如果我再
重新输入set path="c"，再次查看path路径的时候，其值为“c:”，而不是“d:\nmake.exe”；“c”。
4、设置为空：如果想将某一变量设置为空，输入“set 变量名=”即可。如“set path=” 那么查看path的时候就为空。
注意，上面已经说了，只在当前命令行窗口起作用。因此查看path的时候不要去右击“我的电脑”——“属性”........
5、给变量追加内容（不同于3，那个是覆盖）：输入“set 变量名=%变量名%;变量内容”。如，为path添加一个新的路径，
输入“ set path=%path%;d:\nmake.exe”即可将d:\nmake.exe添加到path中，再次执行"set path=%path%;c:"，
那么，使用set path语句来查看的时候，将会有：d:\nmake.exe;c:，而不是像第3步中的只有c:。
```
```
~~个人补充~~：也可以用 "echo %变量名%" 的方法查看某个环境变量的值。但是注意下面情形中后两种不行。

C:\Users\l00384038>set GOROOT
GOROOT=D:\Go\

C:\Users\l00384038>echo %GOROOT%
D:\Go\

C:\Users\l00384038>set %GOROOT%
环境变量 D:\Go\ 没有定义

C:\Users\l00384038>echo GOROOT
GOROOT
```

#### 

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

### 环境变量立即刷新

狗日的2345劫持，真TM服了，用了一堆知乎上的办法，下了好多软件，都不管用。最后是V2EX的办法——360杀毒的急救箱搞定的。。。

遇到最顽固的 2345 首页劫持，网上各种方法都试了
https://www.v2ex.com/t/214388

浏览器启动页被2345劫持怎么办？ - 知乎
https://www.zhihu.com/question/23157265

为什么 Chrome 浏览器的主页会被篡改为 hao123 ？遇到这种情况要如何修复？ - 知乎
https://www.zhihu.com/question/21883209


### VPNs

SetupVPN
http://desktopclient.net/gw/index.html#/

### teamviewer
- https://login.teamviewer.com/
- https://community.teamviewer.com/t5/Knowledge-Base/All-about-passwords/ta-p/28442#toc-hId-585378451
> 用easyaccess解决电脑连接的问题。Extras --> Options --> General 里先把当前电脑assign给teamviewer账户；然后 Extras --> Options --> Security 设置启用easyaccess

办公汪必备软件及技巧：两款远程控制软件助你下班不再往单位跑 - 什么值得买的文章 - 知乎
https://zhuanlan.zhihu.com/p/33211414

### tools general
 
https://www.appinn.com/windows-apps-that-amaze-us/
- qdir https://www.appinn.com/q-dir/
- everything https://www.appinn.com/everything/

代码界的美图秀秀 - 陈龙的文章 - 知乎
https://zhuanlan.zhihu.com/p/35811981