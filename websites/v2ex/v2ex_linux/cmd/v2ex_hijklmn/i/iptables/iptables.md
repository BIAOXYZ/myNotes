
有没有 iptables 的博客或者教程 https://www.v2ex.com/t/1083476
- > 朱双印的还行吧 https://www.zsythink.net/archives/tag/iptables
- > https://linux.die.net/man/8/iptables
- > 用 nftables 吧
- > 建议楼主不是极端自定义需求且极端守旧的话直接抛弃 iptables 吧，linux 下 iptables 是过时的东西，它的替代品是 `nftables` ，从 centos8 开始就正式弃用 iptables 了（ ***iptables 相关命令是指向 nftables 的软链接*** ）。 <br> ***iptables 和 nftables 都可以简单理解为是后端程序，而前端操作这俩的工具除了他俩自带的工具外，还有一个 `firewall-cmd`*** ，这个东西在 centos7 时代作为默认启用功能且有自己的 systemd 服务，centos7 开始就正式不启用 iptables 的服务了，firewall-cmd 可以覆盖绝大部分常规场景。也是红帽主推的功能。 <br> ***如果 linux 系统是 sm 专用版的话，一般防火墙在融合二中配置，你直接改 iptables 是完全不生效的***，通用系统的话，iptables 也没有存在的必要性。
  >> 谢谢建议，我去了解下 `nftables` 和 `firewall-cmd`
  >>> 大佬，请问下 nftables 有没有什么办法兼容 docker ？
- > netfilter 可以做很多事情的
- > 朱双印的 iptables ，其他一些基础网络知识的话可以看我 gitbook https://github.com/zhangguanzhang/simple-container-network-book/blob/master/eBook/directory.md
- > 很多系统都逐渐迁移到 nftables 了，直接学 ntfables ，比 iptables 更容易理解。
- > 用 nftables 吧，我感觉写 nftables 的配置比 iptables 容易很多
- > nftables ，官方文档看完就差不多了，都是示例
- > ***Netfilter 网站上有教程，有个图介绍 packet 在内核里的流程对理解 iptables 很有帮助***。现在都推 nftables ，但个人认为它远不如 iptables 直观，有人说它的目标之一是方便机器处理。iptables 支持第三方的内核模块，比如 xtables-addons ，我找不到让 nftables 和这些内核模块交互的文档，多半不支持。因为这个问题，日常使用 nftables 能干的 iptables 也能干，而 iptables 能干的 nftables 替代不了。

iptables 表链关系傻傻分不清 https://www.v2ex.com/t/1001655
- > 这个问题你随便找张 iptables/netfilter 的图就明白了，对于默认 chain 来说，能够适用的 table 不一样。
- > 这篇挺好的： https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture
- > https://www.zsythink.net/archives/1199 收藏了快 10 年了
