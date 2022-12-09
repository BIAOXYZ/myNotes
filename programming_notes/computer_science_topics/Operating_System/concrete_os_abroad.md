
# Alpine Linux

Alpine Linux 3.11.0发布：安全轻量级的Linux发行版 https://www.ithome.com/0/464/378.htm
- > Alpine Linux 是一个面向安全的轻量级 Linux 发行版，该发行版以安全为理念，面向 x86 路由器、防火墙、虚拟专用网、IP 电话盒及服务器而设计。另外，不同于常见的 Linux 发行版，Alpine Linux 采用 `musl libc` 和 `busybox` 以减小系统的体积和运行时资源消耗。在保持瘦身的同时，Alpine Linux 还提供了自己的包管理工具 `apk`，可以在其网站上查询软件包，或直接通过 apk 命令进行查询和安装。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# CentOS Stream 后的代替者

“杀死”CentOS ，替代品 Rocky Linux 8.5 发布 https://www.infoq.cn/article/abggtqysr6bbry2vqych
- > **停止维护 CentOS 引开发者不满**
  * > 2020 年 12 月 CentOS 官网正式宣布，将停止维护 CentOS，并将更多资金和人力投入到 CentOS Stream 中。***原定于支持到 2029 年 5 月份的 CentOS 8 将于 2021 年 12 月 31 日寿终正寝***。然而，此消息一出便引发了广大开发者的强烈不满。具体为何呢？
  * > 多年来，***Fedora一直充当 RHEL 的上游***。这意味着新功能和更改先出现在 Fedora 中，其中一些功能和更改会加入到下一个版本的 RHEL 中。另一方面，***CentOS 是下游社区项目***，RHEL 引入的任何更改也将添加到 CentOS 中，因此 CentOS 向来有最稳定的发行版之称，在开发者群体中口碑非常高。
  * > 2019 年 9 月，Red Hat 宣布了 CentOS Stream，它是 CentOS 的滚动发行版本，***介于 Fedora Linux 的上游开发和 RHEL 的下游开发之间而存在***，当官方明确表示未来不会再发布由 RHEL 代码编译而成的 CentOS 后，意味着 CentOS Stream 先行，稳定之后再发布 RHEL，所以不难理解众多开发者对这个决策的不满。

被称作 CentOS 未来的 CentOS Stream 是个啥？ https://www.infoq.cn/article/ngt234wtjgpowitmlxwo
- > 至于 CentOS Stream 在 Linux 生态中的位置，一般来说， ***Fedora 是中上游，RHEL 是下游，CentOS Stream 是中游***。事实上， Fedora 完全从社区里来，红帽做的更多是打包和简单测试，对其稳定性及可靠性方面的工作做得是比较少，遵循滚动更新的方式，每半年发布一个新版本，新版本与旧版本之间保有基本的兼容性，也可能会丢弃一些老版本中不好的地方，这恰恰是企业级开发不能接受的。
  >> //notes：这可是红帽的构架师回答 InfoQ 的，基本能说明问题了吧。。。
- > RHEL 则是基于 Fedora 某个特定版本拉取分支，逐渐在这个版本上做增强，保证新旧版本之间的兼容性，并保证最终版本的稳定性。***CentOS Stream 则与 RHEL 的版本相对应，其 Git 提交记录完全一致，二者通过同样的构建流程、同样的测试用例***。简单来说，只有通过全部的测试用例，CentOS Stream 新版本才会发布，这些测试用例与 RHEL 可能重合，也可能不重合，但我们认为只有全部通过才是稳定的，才可以进入下一步，RHEL 也是如此，二者在稳定性上保持一致。
  >> 【[:star:][`*`]】 //notes：代码完全一样不假，可过去是先在 RHEL 上（RHEL 先当小白鼠），再在 CentOS 上的；现在可是反过来了。。。
- > 那么，既然二者一致，为什么还区分中游和下游呢？***所有在 RHEL 做的改动都会先进到 CentOS Stream 里面，方便社区生态伙伴一起共建，并让所有开发者第一时间享受到最新版本***。
  >> //notes：`方便社区生态伙伴一起共建，并让所有开发者第一时间享受到最新版本` —— 向社会（社区）输送人才（小白鼠版本）。。。
- > **InfoQ：CentOS Stream 与 RHEL 版本之间的对应关系是什么？**
  * > 张家驹：CentOS Stream 8 和 RHEL 8 是对应的，不过 RHEL 可能还有 8.1、8.2、8.3......这其中的区别是 CentOS Stream 永远只对应 RHEL 最新的稳定版。一般来说，我们的更新节奏是每六个月会更新一个小版本，假设当前 RHEL 的最新稳定版是 8.3，那么 CentOS Stream 一定是和该版本对应的。
  * > 很多传统企业可能基于闭源软件的认知，觉得新版并不是最稳定的，***但其实 CentOS Stream 是最新、最稳定的版本***。这其中还有一个问题是对已经将 CentOS Stream 部署在生产环境的企业而言，半年更新一次太过频繁，那应该怎么办？
    >> //notes：“新”和“稳定”本来就是冲突的啊。。。

欧洲核子研究中心、费米实验室押注 AlmaLinux，完美兼容 Red Hat Enterprise Linux https://www.ithome.com/0/659/863.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 嵌入式设备OS

BusyBox: The Swiss Army Knife of Embedded Linux https://busybox.net/about.html

BusyBox 简化嵌入式 Linux 系统 https://www.ibm.com/developerworks/cn/linux/l-busybox/index.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 移动设备OS

PrimeOS开启公测：在笔记本上运行Android应用和游戏 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/785527.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他OS

用于年幼学童教学的 Linux 发行版 PrimTux 发布第 4 版 - Linux - cnBeta.COM https://www.cnbeta.com/articles/soft/781939.htm
