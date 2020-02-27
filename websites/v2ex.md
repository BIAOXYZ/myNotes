
# V2EX用户帖

## PingCAP

从大数据到数据库 https://www.v2ex.com/t/630424
> 从大数据到数据库 https://pingcap.com/blog-cn/from-big-data-to-databases/

Kubernetes 中如何保证优雅地停止 Pod https://www.v2ex.com/t/551129

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# V2EX技术类

## hardware

不小心把 iso 文件 cp 到硬盘… https://www.v2ex.com/t/626910
```
本来想弄个 Debian 10 的启动盘，不小心把 iso 文件 cp 到 sda （正确应该是 cp 到 sdb ）…就是执行了一下命令：
sudo cp ~/Download/debian-10.2.0-amd64-i386-netinst.iso /dev/sda

幸好第一个分区是 Windows，没伤及 Ubuntu 系统分区。唉，心塞…明天再恢复分区表吧
```
- > lsblk 看清楚再打字
- > 类似的还有 dd 的 if of 反了，233。
- > /dev/sda 是设备啊，又不是文件系统里的目录，不能接受文件 cp 吧？
  >> @dandycheung #4 所以这里的 cp 就变成了把 iso 文件写入数据到设备，而不是复制 iso 文件到某个目录
- > 复制最后一个参数一般是目录或者文件，楼主直接写设备也是骚操作
  >> @mikeguan #9 这是官方教程的命令，用于生成 U 盘启动盘。操作是没问题的，只是我搞错了设备

龙芯 & Golang！ https://www.v2ex.com/t/606364

## linux

请教关于 Linux 双网卡绑定的细节 https://www.v2ex.com/t/645341

crontab 是怎么实现的？ https://www.v2ex.com/t/619692

删除文件到底用啥命令啊?萌新求问 https://www.v2ex.com/t/599228
- > 由于之前的沙雕操作，我上了公司运维黑名单 现在公司服务器所有人都没有删除权限...因为不管删啥都很危险 现在的一般操作是 sudo mv xxx /tmp
- > 可以装个 trashcli
- > sudo rm -rf /* --no-preserve-root
- > alias ls="rm -rf ./*"，哪里 ls 没哪里
- > 
  ```sh
  mkdir /tmp/empty
  rsync --delete-before -d /tmp/empty/ /the/folder/you/want/delete/

  参考:
  https://www.cnblogs.com/shuaixf/p/3493025.html
  ```

求教: Linux 为什么限制线程数?TCP 连接数等 https://www.v2ex.com/t/581263

cat file.txt > file.txt 导致 file.txt 被清空 https://www.v2ex.com/t/572624

## c/c++

用 c 分配内存，为什么普遍都是用 malloc 而不是用 calloc？ https://www.v2ex.com/t/572612

## python

字典.keys()获得的键列表元素顺序是随机的吗？ https://www.v2ex.com/t/634283
- > 随机的，需要顺序，用 ordered dict
- > dart 有一个叫 LinkedHashMap,那是有顺序的
- > Python 3.7+ https://docs.python.org/3.7/whatsnew/3.7.html <br> In Python 3.7.0 the insertion-order preservation nature of dict objects has been declared to be an official part of the Python language spec. Therefore, you can depend on it.
- > 虽然有 order dict，但内部是有序的。如同上面老哥所述，在 3.x （ x 是几我给忘了）后的版本是有序的

Python 为什么趋近于零的数字会表示成 5.96046448e-08 https://www.v2ex.com/t/629937
- > 15. 浮点算术：争议和限制 https://docs.python.org/zh-cn/3.8/tutorial/floatingpoint.html

刚搞懂一个 logging 的用法，分享一下。 https://www.v2ex.com/t/613320

Python 之父开博客写的解析器系列文章 https://www.v2ex.com/t/588878

cpython 底层实现笔记 https://www.v2ex.com/t/560173
> Dive into CPython internals, trying to illustrate every detail of CPython implementation | CPython 源码阅读笔记, 多图展示底层实现细节 https://github.com/zpoint/CPython-Internals

## go

Go 代码编译为 C 代码 https://www.v2ex.com/t/648000
> A toy programming language base on Golang and compile to C, no name yet https://github.com/kitech/cygo

[7 天用 Go 从零实现系列] 第二期分布式缓存 GeeCache 已经完结 https://www.v2ex.com/t/645362
> 7 days golang apps from scratch (web framework Gee, distributed cache GeeCache, etc) 7天用Go动手写系列[从零实现] https://geektutu.com/post/gee.html || https://github.com/geektutu/7days-golang

Go 101 v1.13.m (v.1.14-pre) 电子书发布 https://www.v2ex.com/t/635029
> Go语言101 : 一本侧重于Go语言语法和语义的编程解释和指导书 https://github.com/golang101/golang101
>> Go语言101 https://gfw.go101.org/article/101.html

GO 切片问题求教 https://www.v2ex.com/t/606165

## java

方式 1 和方式 2 的却别到底在哪里？ https://www.v2ex.com/t/620135

## database

为什么手动编译后的 MongoDB 比官方提供的（包管理器下载）二进制版文件大这么多？ https://www.v2ex.com/t/635085
- > 可能是没 strip 吧，关键词 linux strip
- > 这么大也不像是 debug 版的大小啊，静态链接了？
- > linux 下用 readelf，其次就是看编译的时候有没有指定参数比如"-g"这种。

多源数据融合，建数仓，数据统计分析一般有哪些架构和技术？区别是什么？ https://www.v2ex.com/t/625567

腾讯基于 PostgreSQL 历时 8 年研发的 HTAP 分布式数据库 TBase 开源了，对数据库有兴趣的同学可以去了解体验一下 https://www.v2ex.com/t/619632

数据库的发展趋势是什么？ https://www.v2ex.com/t/612782
- > NoSQL 的建议看一下《 NoSql 精粹》，里面讲了不同的 nosql 数据库的擅长的地方、与关系型数据库的对比。挺薄的一本书的。作者是（著名的） Martin Fowler。
  * 《NoSQL 精粹》 http://www.java1234.com/a/javabook/database/2016/0721/6434.html
- > 看一下这本书: Designing Data-Intensive Applications, 就知道分布式(强)一致性有多么难做. 不知道 NewSQL 是怎么解决这个问题的.
  * 《Designing Data-Intensive Application》DDIA中文翻译 https://github.com/Vonng/ddia
    + 设计数据密集型应用 - 中文翻译 https://legacy.gitbook.com/book/vonng/ddia-cn/details
  * 《Designing Data-Intensive Applications》 http://www.java1234.com/a/javabook/javabase/2017/0914/8912.html

最近阅读了《MySQL 必知必会》这本书，写了一篇读书笔记，请大佬们过目！ https://www.v2ex.com/t/581631
- > 客官，这里有一份《MySQL 必知必会》读书笔记，请您笑纳! https://juejin.im/post/5d2335846fb9a07f021a2509

## 其他

有无计算机组成原理相关的课程和书推荐 https://www.v2ex.com/t/625781

serverless 底层技术是什么 https://www.v2ex.com/t/578918
- > 可以看一下这篇文章，作者尝试去获取 AWS Lambda 应用运行在什么环境里 [如何探测虚拟环境是物理机、虚拟机还是容器？](https://www.infoq.cn/article/536L*XPRudOwCkiTDgM4)
- > aws 有公布过部分的细节，可以看一下 blog。之前开源过 FireCracker，说是 lambda 的基础组件：[亚马逊AWS官方博客宣布推出 Firecracker 开源技术：适用于无服务器计算的安全、快速的 microVM](https://aws.amazon.com/cn/blogs/china/firecracker-open-source-secure-fast-microvm-serverless/)。阿里云无服务器函数印象中似乎是基于 Docker 的，不过似乎没看到一些相关的技术细节介绍

做一个基础很扎实的程序员是一种什么感受啊 https://www.v2ex.com/t/561411
- > 现在开始学基础也不会晚。最近也一直在看计算机基础相关圣经。我整理了一个计算机基础书单，可以参考参考 https://github.com/tagnja/resources-of-learning/blob/master/%23cs-foundations.md

推荐几篇零知识证明技术博客文章 https://www.v2ex.com/t/586006
> 深入浅出区块链 https://learnblockchain.cn/

翻译了一下破解编码面试这本书，放到 GitHub 上了 https://www.v2ex.com/t/609497
> https://github.com/F8F-1BearCat/CtCI-6th-Edition-CN

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# V2EX非技术类

做程序员最重要的还是一定要有自己的作品 https://www.v2ex.com/t/564913

统计了 V2EX 过去一周的在线人数 https://www.v2ex.com/t/579484

做了一个大厂的程序员职级对比的网站 https://www.v2ex.com/t/584792
> https://itlevel.vip
- > 可以像 levels.fyi 那样接入薪资和一些晒 offer 的帖子地址
  >> https://www.levels.fyi/

如何帮助一个中年农民因进城务工而找不到工作快要成为流浪汉的人？ https://www.v2ex.com/t/610654

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 休闲娱乐

动漫求推荐一些啊\~\~感谢 https://www.v2ex.com/t/574810
- > 去搜 bangumi.tv 的排行榜，在前 50 内自己挑想看的
- > 动画标签: 冒险 https://bangumi.tv/anime/tag/%E5%86%92%E9%99%A9/?sort=date
- > Bilibili > 番剧 > 番剧索引 > 评分    顺着看呗
- > https://bangumi.tv/ 搜索你喜欢的番，下面有推荐 <br> 或者点击该番对应的一个 tag,点进去，排名排序，然后挑选你感兴趣的 
  >> 或者可以尝试 bgmer 基于 bangumi 制作的推荐系统，例如 https://bangumi.tv/group/topic/345856
  
求大佬推荐好看的新老番！ https://www.v2ex.com/t/582232

https://github.com/ruanyf/weekly/issues/669
> [极简效率] Tophub.today ：聚合全网新闻社区热点排行榜 ！ https://www.v2ex.com/t/543670
>> 今日热榜 https://tophub.today/

上次开源了今日热榜的 API 接口，这次直接开源热榜 GO 后端代码吧 https://www.v2ex.com/t/589420 || https://github.com/timeromantic/TopList
> 今日热榜，一个获取各大热门网站热门头条的聚合网站，使用Go语言编写，多协程异步快速抓取信息，预览：https://www.printf520.com/hot.html

上班摸鱼、路上打发时间，进来看看吧 https://www.v2ex.com/t/583885
> 前两天有 v 友开放了 API，聚合了一些网站热门
>
> 并且作者也做了页面
>
> 今日热点 -- https://www.printf520.com/hot.html
>
> 但是折腾就是天性
>
> 花了点时间，又搞了一个
>
> ✨互联网热榜 -- https://www.telami.cn/hot/
>
> 代码放在 github 上，如果有需求，可以提 issue -- https://github.com/telami/hot

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 生活信息

上午刚买了套房，可以分享些行情 https://www.v2ex.com/t/582885

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# V2EX工具类

***远程共享/访问***：
- 目前免费远程控制软件有好用的吗？ https://www.v2ex.com/t/567221
- 大家可以放弃 TeamViewer 了，有更好的解决方案 https://www.v2ex.com/t/568443
- 花了点时间终于把 xrdp 跑起来了 https://www.v2ex.com/t/630325

大家有什么推荐的日常 Linux 软件？ https://www.v2ex.com/t/575901

shellcheck 真是写脚本的神器 https://www.v2ex.com/t/569910
> https://www.shellcheck.net/

chrome 书签越来越多，大家想过怎么处理吗 https://www.v2ex.com/t/599124
- > https://clipper.website
- > https://github.com/netnr/uuid  托管在 Git 的书签，Markdown 格式，有兴趣可以搞搞
  >> https://uuid.fun/
- > 开源地址： https://github.com/luchenqun/my-bookmark  在线体验： https://mybookmark.cn/  如果觉得好用，请 star 一下鼓励我继续完善！
- > https://www.gettoby.com/faq

vscode 在程序坞里的图标变得非常非常迷你，没办法恢复 https://www.v2ex.com/t/601519
> 大家有没有碰到过，有啥解决方案吗？除了重启，因为刚开机就这样了 QAQ
>> ![](https://i.loli.net/2019/09/17/QujWPAFkC5zO3l7.png)

开源一文多发平台 ArtiPub，让文章随处可阅 https://www.v2ex.com/t/602779
> https://github.com/crawlab-team/artipub

推荐一下我们搞的播客 《捕蛇者说》 https://www.v2ex.com/t/619892
> 捕蛇者说 https://pythonhunter.org/

不懂就问，红黑树的插入过程 https://www.v2ex.com/t/628855
> 《算法》中关于红黑树部分的内容我之前也看的很困惑，因为旋转的逻辑和别的地方看到的不太一样，比如 https://www.cs.usfca.edu/~galles/visualization/Algorithms.html 这个可视化算法的网站，后来干脆放弃《算法》，转向别的资料了。
>> notes：主要就是为了上面那个可视化算法的网站所以记一下。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# V2EX八卦贴（要不要开这个考虑了很久，后来想了想，还是开。。。）

女朋友家境不好，手机摔坏了要买手机，我推荐她买三星 A60，她非要买华为 Mate20 Pro https://www.v2ex.com/t/575148

公司之前离职的 hr 情商似乎有点低 https://www.v2ex.com/t/580454

码农老婆职业统计 https://www.v2ex.com/t/581073
- 目前（ 2019-07-10 09:12:40 ）此贴统计饼图：![程序员伴侣职业统计]( https://i.bmp.ovh/imgs/2019/07/f76f8d093f733d35.png)

有感于隔壁统计老婆职业帖子，我现在好纠结选哪个女朋友结婚 https://www.v2ex.com/t/581575

大家有什么办法排除焦虑吗 https://www.v2ex.com/t/582227
- > https://imgur.com/2R1XYcA
  >> https://www.weibo.com/1401527553/Hzjl1Et7G 【from: tombkeeper】
  ```
  每年 3 月 5 日是学雷锋日。不过现在不怎么提了。雷锋说过一句话：“在工作上，
  要向积极性最高的同志看齐；在生活上，要向水平最低的同志看齐”。这句话有着
  深深的五六十年代味道，看起来已经不合时宜。其实换成今天的语言就是：提高
  能力，控制欲望。

  你的爷爷见过的最好看的姑娘就是村口的小芳，村里生活最好的人家也不过顿顿
  能吃炒鸡蛋。而现在，你一打开屏幕，满眼的香喷喷紧绷绷鼓胀胀，戴着沛纳海
  去爱琴海。你很难不为之所动。然而如果为之所动了，也很难不焦虑。

  数字技术让我们获取信息变得异常便利，让我们更容易提升自己的能力，同时也
  更容易产生欲望。但能力提升的速度是多项式级别的，而欲望则很容易以指数级
  速度增长。所以，想减轻焦虑，提升能力是可选项，控制欲望是必选项。因为能
  力的提升永远赶不上欲望的膨胀。

  利用欲望让自己努力，控制欲望让自己快乐。
  ```
  
