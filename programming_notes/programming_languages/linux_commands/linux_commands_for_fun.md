

能从远程获得乐趣的 Linux 命令 https://mp.weixin.qq.com/s/daeBClgYBmCxX8msTCNa0g || https://linux.cn/article-10437-1-rel.html
- > 接下来，Opensource.com 的撰稿人 Manuel Dewald 提出了一种从终端获取当地天气的方法。它很简单，你只需安装 curl（或者，wget）。
  >> ***`curl wttr.in`***
```
root@cloudsec1 ~ $ curl wttr.in
Weather report: Durham, United States

     \   /     Clear
      .-.      39..42 °F
   ― (   ) ―   ← 4 mph
      `-’      9 mi
     /   \     0.0 in
                                                       ┌─────────────┐
┌──────────────────────────────┬───────────────────────┤  Wed 27 Mar ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│     \   /     Sunny          │     \   /     Sunny          │     \   /     Sunny          │     \   /     Clear          │
│      .-.      33..39 °F      │      .-.      44..50 °F      │      .-.      53 °F          │      .-.      44..48 °F      │
│   ― (   ) ―   ↓ 7-9 mph      │   ― (   ) ―   ↙ 8-10 mph     │   ― (   ) ―   ↙ 6-8 mph      │   ― (   ) ―   ← 4-9 mph      │
│      `-’      12 mi          │      `-’      12 mi          │      `-’      12 mi          │      `-’      12 mi          │
│     /   \     0.0 in | 0%    │     /   \     0.0 in | 0%    │     /   \     0.0 in | 0%    │     /   \     0.0 in | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘
                                                       ┌─────────────┐
┌──────────────────────────────┬───────────────────────┤  Thu 28 Mar ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│    \  /       Partly cloudy  │    \  /       Partly cloudy  │    \  /       Partly cloudy  │    \  /       Partly cloudy  │
│  _ /"".-.     48 °F          │  _ /"".-.     60 °F          │  _ /"".-.     60 °F          │  _ /"".-.     51..53 °F      │
│    \_(   ).   ← 1 mph        │    \_(   ).   ↖ 1-2 mph      │    \_(   ).   ↑ 5-7 mph      │    \_(   ).   ↑ 4-9 mph      │
│    /(___(__)  12 mi          │    /(___(__)  12 mi          │    /(___(__)  12 mi          │    /(___(__)  12 mi          │
│               0.0 in | 0%    │               0.0 in | 0%    │               0.0 in | 0%    │               0.0 in | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘
                                                       ┌─────────────┐
┌──────────────────────────────┬───────────────────────┤  Fri 29 Mar ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│    \  /       Partly cloudy  │    \  /       Partly cloudy  │    \  /       Partly cloudy  │    \  /       Partly cloudy  │
│  _ /"".-.     50..51 °F      │  _ /"".-.     64 °F          │  _ /"".-.     68 °F          │  _ /"".-.     60..62 °F      │
│    \_(   ).   ↗ 4-8 mph      │    \_(   ).   ↗ 6-7 mph      │    \_(   ).   ↑ 7-10 mph     │    \_(   ).   ↑ 6-13 mph     │
│    /(___(__)  12 mi          │    /(___(__)  12 mi          │    /(___(__)  12 mi          │    /(___(__)  12 mi          │
│               0.0 in | 0%    │               0.0 in | 0%    │               0.0 in | 0%    │               0.0 in | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘

Follow @igor_chubin for wttr.in updates
```

Linux玩家必备：Ubuntu完全配置指南 - DealiAxy的文章 - 知乎 https://zhuanlan.zhihu.com/p/56253982

十大 Linux 命令行游戏 - Linux中国的文章 - 知乎 https://zhuanlan.zhihu.com/p/33267251

摸鱼也要有技巧：3个 Linux 命令行工具让你假装很忙 https://www.ithome.com/0/447/794.htm
- > 我们要看的第一个工具是Genact。Genact只是简单地回放你选择的一个序列，在你出去喝茶休息的时候慢慢地、无限期地“编译”你的代码。它播放的序列由你决定，但默认情况下它包括一个加密货币挖掘模拟器、composer pHP 依赖管理器、内核编译器、下载器、内存管理等等。不过，我最喜欢的是显示simcity加载消息的设置。因此，只要没有人检查得太仔细，你就可以花整个下午的时间等待电脑完成进度条。
- > Hollywood采取了更直接的方式。它本质上是在终端中创建一个随机数和拆分屏幕的配置，并启动看起来很忙的应用程序，如htop、目录树、源代码文件和其他应用程序等，并每隔几秒钟进行切换。它以shell脚本的形式组合在一起，因此可以很容易地根据你的需要进行修改。
- > 我个人最喜欢的是Blessed-contrib，但是它并不是一个专门为了这种表演而设计的应用程序。相反，它是一个基于node.js的终端仪表板构建库的演示文件，该库名为fordated contrib。与其他两个命令不同的是，我实际上使用了fulded contrib的库来做一些实际工作的事情，而不仅仅是假装工作。它是一个非常有用的库，有可以用一组命令行显示信息的小部件。但它也很容易填充虚拟数据来实现类似《WarGames》中的梦想。

摸鱼求助：有没有命令或软件，能让终端仿佛一直在运行输出 https://www.v2ex.com/t/814142
- > `sudo snap install genact && genact`
- > 不需要装任何程序，直接 `curl parrot.live` 就可以了

Linux fun-o-matic https://gist.github.com/zlorb/4a3eff8981fcec8ca1c7 || https://gist.github.com/marianposaceanu/6615458
1. Install cowsay [0] via : `sudo apt-get install cowsay`
2. Install fortune [1] via : `sudo apt-get install fortune`
3. Install figlet [3] via : `sudo apt-get install figlet`
4. Make sure you have Ruby installed via : `ruby -v`
5. Install the lolcat [2] via : gem `gem install lolcat`
6. (option) Add to .bash_profile and/or .bashrc
```shell
$ echo "This is a banner" | figlet | lolcat
$ fortune | cowsay | lolcat
$ git log -1 | cowsay -f dragon-and-cow | lolcat
```
- [0] - http://en.wikipedia.org/wiki/Cowsay
- [1] - http://en.wikipedia.org/wiki/Fortune_(Unix)
- [2] - http://github.com/busyloop/lolcat
- [3] - http://www.figlet.org/

# cowsay

使用 cowsay 命令的 3 种有趣方式 | Linux 中国 https://mp.weixin.qq.com/s/OwfF65Uyb0tHbe6g6bTmPg
