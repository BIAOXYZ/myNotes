
# 远程共享/访问专题

目前内网远程控制最好的方案就是 VNC 吗？最近试了 teamviewer 和 anydesk，都不太爽 https://www.v2ex.com/t/745358

小米公司员工私自将公司内网端口映射到公网 https://www.v2ex.com/t/726197
- > 很简单啊，frp 应用层识别啊。。。。我们有专业的设备和系统，所有公司流量都要从这些设备通过。甚至公司谁经常访问猎聘，51job,通过拆开 7 层报文，分析 url 就可以生成一个报表，谁最近访问这些网站数量和次数最多。。。

目前免费远程控制软件有好用的吗？ https://www.v2ex.com/t/567221

大家可以放弃 TeamViewer 了，有更好的解决方案 https://www.v2ex.com/t/568443

花了点时间终于把 xrdp 跑起来了 https://www.v2ex.com/t/630325

## 远程局域网

请教一个访问内网的问题。 https://www.v2ex.com/t/716006

怎么搭建“远程局域网”，用来联机打游戏 https://www.v2ex.com/t/661321
- > https://www.v2ex.com/t/621442 【[Slack 开源了他们的 overlay network 工具 Nebula](https://www.v2ex.com/t/621442)】
  * >
    ```console
    https://github.com/slackhq/nebula
    简单来说，就是可以用很简单的方式让全球各地的机器用安全的方式在同一个内网里。
    ``` 
  * > 用过 tinc 和 zerotier 之后还是更喜欢 zerotier，使用一点中心化让配置更简单了。
- > 想起这个 https://github.com/spacemeowx2/switch-lan-play
- > Nebula 或者 zerotier
- > 手柄游戏可以考虑 steamlink 公网串流；普通游戏 zerotier
- > 想简单的用 zerotier,想完全自己可控的可以考虑 tinc，可以参考 https://www.v2ex.com/t/649829
- > 我自己是用的 OpenVPN
- > VXLAN, EoIP, 各种 Tunnel 姿势了解一下
- > https://www.wireguard.com/

# 在线工具/环境

给大佬们推荐个玩具，一秒钟打开在线 VS Code 阅读 GitHub 代码 https://www.v2ex.com/t/752197
```console
在 GitHub 上读代码总是觉得不方便，即使有了 Octotree 这种东西也总觉得切来切去太麻烦了，clone 下来有的库超级大还太慢了，
于是便萌生了搞一个在线 VS Code 读 GitHub 代码的工具（这想法早就有了，一直懒得搞）
给大佬们推荐一个自己最近无聊做的小玩具，过年放假了方便各位大佬们在 GitHub 上读代码。

这小玩具用法很简单，比如你现在正在看 facebook/react 这个代码库的代码，觉得页面切来切去很麻烦，直接在
浏览器地址栏 github.com 中的 github 后面，加上个 1s，然后回车就行了，所有的公开代码库都可以。

URL 从 https://github.com/facebook/react 变成了 https://github1s.com/facebook/react

纯前端的哈，直接用的 gh-pages 托管，获取代码是 GitHub REST API，如果遇到了 Rate Limiting 设置个 OAuth Token 就好了，
没有自己的服务部署，所以这网站服务理论上不会挂。

仓库地址： https://github.com/conwnet/github1s

有啥好的建议欢迎提，反正过年在家也没啥事儿。
```
- > 一键开启github1s页面 https://greasyfork.org/zh-CN/scripts/421412

Gitako - 优雅、开源、免费的 GitHub 文件树插件 https://www.v2ex.com/t/722220
- Gitako - GitHub file tree https://chrome.google.com/webstore/detail/gitako-github-file-tree/giljefjcheohhamkjphiebfjnlphnokk

更多体验场景请至开发者实验室：https://developer.aliyun.com/adc/labs/
- 阿里云体验实验室 教你《搭建 Hadoop 环境》 https://www.v2ex.com/t/702879
  * > 搭建Hadoop环境 https://developer.aliyun.com/adc/scenario/cf48abdfe41e4187be079722b9dc15b6
- 阿里云体验实验室 教你《快速搭建 Docker 环境》 https://www.v2ex.com/t/702868
  * > 快速搭建Docker环境 https://developer.aliyun.com/adc/scenario/9fd79b8711984e309f20d82bc65a26fa

# 教程类

初一学生自学编程学哪门语言好 https://www.v2ex.com/t/744073
- > 少废话，上车 https://quickref.me/python
  >> //notes：后来发现这个网站还有pg的：https://quickref.me/postgres

# 待分类

有哪些本地代码库搜索利器 https://www.v2ex.com/t/741243
- > ripgrep +1. 在简单暴力的方法里面应该算是最快的了。
- > AnyTXT，可以实现文件内容搜索！
- > 没必要为了搜点代码再安装一个服务，那真是饶了九曲十八弯了。比 grep 更快，更友好的有 ack 。比 ack 更快的有 ripgrep 。这两个命令行工具，绝对能够满足速度要求。
- > 谢谢大家，直接在 windows 上装了 ripgrep 了
- > opengrok 啊

把自己简历做成了 npm 包 https://www.v2ex.com/t/715105

问下大家公司里都用什么工具压测 https://www.v2ex.com/t/664287

一键导出你的微信读书书籍和笔记 https://www.v2ex.com/t/661593
> `examples-of-web-crawlers/12.一键导出微信读书的书籍和笔记/` https://github.com/shengqiangzhang/examples-of-web-crawlers/tree/64d220eb41f7eea4e5f8366fe7b055d678821f29/12.%E4%B8%80%E9%94%AE%E5%AF%BC%E5%87%BA%E5%BE%AE%E4%BF%A1%E8%AF%BB%E4%B9%A6%E7%9A%84%E4%B9%A6%E7%B1%8D%E5%92%8C%E7%AC%94%E8%AE%B0

[userscript]我做了一个 script, 在 [anime1.me](https://anime1.me/) 和 [video.eyny.com](http://video.eyny.com/) 显示弹幕 https://www.v2ex.com/t/637976

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

2020 年求好用的录屏软件 https://www.v2ex.com/t/651861
- > command + shift + 5, mac 系统自带的
- > obs studio 免费全平台 https://obsproject.com/
- > 这里有一堆看看 https://withpinbox.com/explore/collection/360260

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# chrome相关

你最想推荐的浏览器（Chromium-based）扩展是什么？ https://www.v2ex.com/t/730033
- > 推荐个下载离线扩展文件.crx 的网站. https://chrome-extension-downloader.com/
