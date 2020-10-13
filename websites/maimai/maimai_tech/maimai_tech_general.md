
# 脉脉技术类其他

Http的rest调用，和rpc调用有啥区别？啥时候用rest啥时候用rpc？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mjc2MTkxMzIsImlhdCI6MTYwMjM1NjM1MH0.wf9-RwpM2upCo_QjSK5oAYvreBg3Boy9TXVD24In_WM
- > 区别：1、接口风格：rpc面向动词，rest面向名词 2、rpc协议需自定义，rest只需封装http；3、rpc使用简单，rest配置较多，如需知道get还是post等 4、rpc报文字段简洁且可用gzip等压缩技术，http报文头较大，传输效率rpc高 5、rpc实现难度大。在微服务中，服务治理模块可用rpc，其他配套设施如监控配置中心等可用rest
- > dubbo是rpc的一种实现，feign是基于http的一种封装，他们都是可以作为服务治理框架用来进行远程调用，Dubbo配合zk，feign配合eureka，但因为rpc传输效率高，所以可以考虑dubbo替换feign，剩下的一些配置中心啥的就可以采用sc全家桶了
- > RPC是一种远程方法调用协议， 通俗点讲就是调用一个本地接口方法，实际远程调用到另外一个服务的接口方法上。 dubbo 是具体实现，而http不是，基于http的feign才是
- > rpc指远程服务调用，http是一种具体通信协议。比如像dubbo这种rpc实现框架，既可以用默认的dubbo协议，也可以用http协议。只是默认的协议让大众产生了一种先入为主的错觉。

一个很原始的问题，为什么数组从0开始计数?是否合理?如果从1开始会有什么问题吗？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYzNTE4MDUsImlhdCI6MTU5MTI0NTQxM30.QoG77fZb6L8n57CuZRAyTKyciTZUOnLmXlpG24AOfmY

不懂就问。。。。问下倒排索引，百度了也没看懂，搜出来的结果很多但都是一个版本。主要是为啥叫“倒排”？没看懂，有高手解答一下吗？ 有bat tmd的大佬在吗？在外散修的大佬们在吗 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYwOTk0NDIsImlhdCI6MTU4OTQzMzA1NH0.DZqyr2MYO9psQ5GThrfwR9YVTukh6p52HCfvRkJhF4Y
- > 比如两条数据，id=1，内容“饭好吃”，id=2,内容“饭难吃”。对这两段内容分词，可获得三个词，饭-对应id为1和2，好吃--对应id为1，难吃--对应id为2。当你搜索“饭”，就可以很快获取到id为1和2。再通过id去获取其内容。
- > 倒排是和正排对应的，所谓正排就是给你一个doc id，你可以获得他的所有item。那么与之相反，倒排就是给你个term id，你可以获得所有包含这个term的doc
- > 简单来说，通常文章是key，里面的词是value。 倒排就是词是key，文章是value。这就像搜索引擎，你搜了一个query，给的是一个字符串，然后把这个字符串切开，去倒排索引里匹配，把包含的捞出来，返回给你文章（网页）

面试官问了一题进程如何切换？瞬间感觉自己啥都不会 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYwNDIwNDYsImlhdCI6MTU4ODc2NjUzM30.OmcCwD-ilDYqnk4h-AS9PEu1OPai0zSB8eLEu0Q4yeE

2038年1月19日绝对是程序员的噩梦 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU4MjUxNjcsImlhdCI6MTU4NzUzMzE1NH0.hQuYZVXc0MQWmiFDc-BV0KLV2kk_-xFAkOtYubPzHbM
- > 现在很多人用时间戳存时间，就是一个数字比如1587440858，而如果用32位的int存的话，那int最大表示2147483647，也就是2038-01-19 11:14:07这个时间，再大了溢出了

面试题提问，有http为什么要用dubbo，期待大佬们的回答 阿里腾讯美团滴滴华为引流 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU2MDk5MjQsImlhdCI6MTU4NTMwNzk0NH0.WsAUUfUHlGLEhXypL6lhqlcev0pKWShiUtY0PrmMNqU
- > 不用维护域名，因为域名解析的缓存千奇百怪
- > 长链接，适合高并发，http每次需要三次握手四次挥手
- > 知乎上热贴，rpc比http强在哪，可以看看
- > 当你每扩容一批机器你就得切nginx你就知道为什么了
- > 链接是一方面，另一方面http报文里面有很多无用信息，rpc协议通常都是相当简化的

面试题：如何快速定位死锁 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NTQzNTYsImlhdCI6MTU4NTIwOTUxMX0.UAvO_vPImQ4ZYxjwDvqOwZB3r0JcG4sNzABjF7nC7F4
- > top看cpu占用，看load
- > 如果是C++，gdb attach 到进程上，generate core，gdb 打开 core，threads apply all bt
- > C++一般是 top -Hp和pstack配合用
- > pstack 就够了
