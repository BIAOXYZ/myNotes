
# 脉脉数据库

想问一下mysql innodb 的mvcc在rr隔离级别下到底解决幻读没，我看有的是说间隙锁解决的 有人讲一下吗？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU4ODk4MDEsImlhdCI6MTU4NzUzMzY3NH0.yESruSQzmlM8NISB4dxhgkDWPn8QkMjljyd7Brh0Mv0

lsm 或者 b+树都是对于早期机械硬盘而设计的数据库结构，像lsm就是把随机写变成顺序写，但是现在ssd逐渐是主流，请问在对于ssd这种固态硬盘，他的缺点有哪些，我就知道有一个写放大，那么对于ssd，数据库的优化角度有哪些，请大佬们知道的说下呗 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU2OTY1NzAsImlhdCI6MTU4NjMyMzMyMH0.aJtXNA09oHye8-qbU6KGu3xp3so-KtByC2qXX_wZPLg
- > WiscKey了解一下
- > 有点像bitcask
- 自查链接:
  * 如何理解SSD的写放大? - 知乎 https://www.zhihu.com/question/31024021
  * WiscKey：LSM-Tree 写放大优化 https://www.jianshu.com/p/1b438f850844

今天被朋友问到一个问题，如果有1亿条数据，深度limit时，怎么优化？我是这么回答的，有木有问题。 https://maimai.cn/web/gossip_detail?src=app&webid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYWJiNzBlNjA2YzU4MTFlYWI2Zjc4MDE4NDRlNTAxOTAiLCJ1IjoxOTU4OTUxOTUsImlkIjoyNTU0NDg0N30.QMz3eiKFEn9HHF0RC1efsV3l5BKfPqCEsB36T3n75Bo
- > 我遇到过，当时解决是select * from a where id in (select id from a limit x，y) 充分利用主键索引比二级索引块的优势。如果这样都会事物超时，只能顺序分表了。
  >> 老哥，请问 select * from table where xxx limit a,b和select id from table where xxx limit a,b 速度有区别吗？
  >>> 有，假设 id 是自增主键，引擎是innodb，xxx上有索引。select * 的时候会先查索引找到对应的 id，再通过 id 找到这一行的数据，就是回表，两次IO。而 select id 只走一次IO
- > 典型的分裤分表和分页场景，经验：大于100w条数据时分表，查询时使用id作分页参数而不是limit
- > 只讨论一亿数据是没意义的，一行数据有多大？如果没有复杂查询的话能不能用nosql比如hbase？是oltp还是olap？

# 脉脉算法与数据结构

面试腾讯被问了红黑树和tarjan算法，果然还是我太弱。感觉找工作leetcode都已经不够了，得把算法导论拿出来。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY4NDIxNjMsImlhdCI6MTU5NjA5MDkxMn0.OzrBEUmVsWxa3KhREQR8r3oMnF2BMt4-6ITSv5enKDM
- > 这个有点难，不背很容易写错。如果只要求强联通分量的话，用kosaruju算法很容易写对，也是On复杂度，应该也可以过

算法菜鸡，问个算法题，知道的老哥回答一下：一个单向链表，要求相邻节点的值如果重复，则进行消除。要求空间复杂度O1，时间复杂度不高于N^2。输入abbcb 返回acb。输入abba 返回null https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY4NDI1MzAsImlhdCI6MTU5NjA5MTE0OX0.ahzQGndqX3Pf93swgRjOTfZ-Yg_YR2oVRiw5D6tnMDc
- > 一边遍历一边反转链表当一个栈来用 最后再整体反转

今天做了BFS相关的6道medium，实在是有点忙。。明天希望有时间能补上，题目是102/103/279/429/542/863…如果有一起练习的朋友，也一起坚持吧~6/2/2020 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYzMzY1NDgsImlhdCI6MTU5MTE1ODUxMn0.IwQec7C94WemC_s5AwoA-b-ZrOnbTyBAQ65T8fhHecI

leetcode第85题最大矩形，对着题干瞪眼一晚上，心态要崩 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NzMyNjQsImlhdCI6MTU4NTIxMTQ4Nn0.9fpBl4A5y6yG56Cdbi6-L4X3alNGk5gBl9FD9HgrGwY
- > 老哥先做84题，然后85就明白了
- > 有一道神题，Count of Range Sums，把离散化，uniq，二分查找，树状数组，前缀和都搞进去了，这道题我写了一个月了
- > 那是你没遇到过数论背景下的树形dp
- > 这题我面Amazon被面到了，84 85一起面的

最近面试的算法题，我想了很久还是没想到，求大佬指点。问题：“假设有一个数字类型的数组，量级达到数亿亿别。如何找到最大的第十个数字？” 答：“新建10个元素的数组，循环取出大数组的数据和小数组对比，大的替换到小数组，小的则抛弃” 再问：“如果要找最中间的那个数字，应该怎么找？” https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NDMwMjYsImlhdCI6MTU4NDkzNjAyMX0.eq-ByP2zeWe62KfZbyWpqWl2kLbWaQzek2qk1EtBw58
- > 二进制分治，按最高位是0或者1写入到两个文件，并记录两个文件写了多少个元素，然后就可以知道中间那个数在哪个文件里。接下来对次高位进行同样的操作。。。最后剩下的就是所求。其实就是转换成了求第k个数。
- > 建两个堆，一个大顶堆一个小顶堆。一个个读取数据放入两个堆中，注意需要保持两个堆的数据个数绝对值在1以内。这样两个堆的堆顶即为中间，把这些数据都读完，要找的数据就是两个堆的堆顶数据了。

# 脉脉cloud

K8S，想要【监听】k8s的服务变更后【推送消息】给自己开发的应用程序，看了好几个中英文档，都没找到相应资料。有大佬能指点下怎么找到资料，怎么着手去做么？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYxNTAxOTcsImlhdCI6MTU4OTg2MjkwMn0.JCznD3bEoHr52OH8lLlwe4_TRQ3g6M-EjTy3xEbT-6c
- > 所谓的k8s服务变更是指什么？如果指的是k8s资源的变更，使用client go里面的informer就行，或者直接用list watch api来监听
- > 本质上是监听etcd的数据变更？watcher 就好了吧
- > fabric8的watch功能

# 脉脉技术类其他

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

# 脉脉健康

两个月前检测出hpv高危阳性，现在复查还是阳明，感觉生活暗无天日，怎么办…… https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYzNDUyMzYsImlhdCI6MTU5MTI0NzAxOX0.PyUgZvQsEW-Wq12EVM39s8sluWQFhJvgcXqdQBbcNGE
- > 你是女孩子吗？HPV不可怕，听医生的建议好好治疗说不定能治愈，癌变几率不太大。
- > 别怕，我媳妇之前hpv好几种都是阳性。吃药+锻炼，一年后复查就没了
- > 去北京妇产医院找吕讷男大夫。别怕，没事，咱还年轻，加强锻炼，别熬夜，适当用药(遵医嘱)，保持健康饮食和心情愉悦。我之前三个hpv高危，后面也都转阴了。转阴后一定去打疫苗，大夫说26以后打四
- > 不要焦虑，主要是要增强自身免疫力，会自动清除病毒，有自愈的例子
- > 保持健康心态，早睡早起，休息好。没准半年后自己转阴～不要太多负担，加油
- > 90%的女性一生中都感染过hpv，大部分都会被免疫系统清除的
- > 我妈去年也是，两个高危的阳性，后面让她多注意休息，多运动，保持好心态，半年后复查就都是阴性了，把抵抗力提升好，一般都能好的，心态第一
- > 问题不大。外面美体美容还是少去，有些美体店消毒不干净的。还有汗蒸啥的也少去

# 脉脉八卦

#315曝光黑公司#，来来来，现在开始提名，哪些公司哪些点不好，值得被曝光一下~咱们职言“打假”走起 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY3NDM0MjMsImlhdCI6MTU5NTIyNjk2Nn0.6X1mFB_V6qL7CJdiW2z1W8JKYwODWg1lp04yKakgDIs

把这里当个树洞，说说我的经历，我发誓我说的是事实。我爱国，希望中国的公司越来越好，但是针对华为，我是矛盾的。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY3NjM0NDksImlhdCI6MTU5NTIyNjk2Nn0.Xhyp_NYyLZE0WyJEPFUaaSnK1gF2I_swdiKesu1eBZA

后悔做了字节的认证，感觉没有百度同事圈我的乐趣都要没有了 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY2MjM5NDUsImlhdCI6MTU5Mzc1MTAxMH0.V5lg549r2qPxsGEwcaY3Ek8ShvQ0g9sd7z0HhKz_IzU

这个阿里P8事件男主，是我前同事，看到这个消息的时候，我是非常震惊的……这货才毕业三年？为啥4年前我们就是同事？而且，他的经历不仅仅是网上爆的那5份，至少还有一家就是我们共事过的……这货技术巨水……被我们那家公司辞退了，这种伪造经历的，被开掉的经历，都能进阿里？阿里P8到底有多水 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY1MDA1MDcsImlhdCI6MTU5MjcxMzg3Mn0.SHBS8rgdUqBoeAFMAbPgAedrNy8-xiPOYePy9_evfYM

阿里一个人能在不同事业部同时担任P8么？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYwMzcwNzEsImlhdCI6MTU4ODc2NjM2Mn0._ZmUNWHGSizIsc21w1ts1NDQ02S6ncuidq7xBIO6Khs

如果你女朋友欠了十万信用卡你会帮她还吗（不是乱花，被朋友坑了）她在老家工资每个月四五千的违约金都抵不上，我刚买过房还有房贷每个月也剩不下多少钱 她不敢告诉家里 怕气着她爸妈 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYwMjk4OTUsImlhdCI6MTU4ODY1NTA5NH0.xb_Mex5Daelpl38yfz8v5x3B-K4fRDM4wHB0ri2rlHA

女朋友攒了两个月公司的零食，然后攒了一箱送给我当生日礼物，这是什么操作 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5NTgzMjIsImlhdCI6MTU4Nzk2MTEzMH0.CCylzaL_4vZ94OwaIa4N0vLrrCiuSM4YXE4xav-6OlQ

工作4年，普通二本，目前 package 不到25，但是明年跳槽时能确保 个人技术、项目经验、社区影响力、各项软技能综合水平能到P7＋左右的水平，请问下明年能拿到 字节2-2，腾讯3-2，阿里P7 的offer吗？这种情况下会忽略package低的影响吗？求教 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5MjIxMTMsImlhdCI6MTU4NzcwMDYwM30.iY00G_3pCMYhlwpO6NknSYrGycjU_glepp-LuxgRPVA

最近由于被父母催的紧，各种途径认识了一些妹子。如果把找对象当成一个okr的话，事后复盘也非常重要。我是一个典型的普通程序员，接触的妹子包括公务员小姐姐，国企小姐姐，pm小姐姐，rd小姐姐，设计小姐姐，金融小姐姐。地域上从南到北都有。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU4OTE2MDMsImlhdCI6MTU4NzUzMTg2Nn0.8eRrjswJivqHxVQU3Dww6zD3skhBPVk0SKZHwhL7HoA

头条用户运营前领导终于要滚蛋了，每天混吃混喝 躲休息室玩消消乐，淘宝 外卖资深用户，业务找她从来都是拖拖拖，没事看不到他 出事只会甩锅，这样的** 公司早该摒除了！！最后还是给了机会改过自新 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU3ODI4NTYsImlhdCI6MTU4NjkyMjgzMX0.qjracjZLFESxI8IFLf1NL_h5k9aGbGMEzqdN1tI1q4Y

没喝多真实情况，我带的一个新来的小实习生一直投怀送抱寻求身体接触，应该有所图（转正），如果你们怎么处理。我男的单身，实习生很好看。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU3NzM3ODUsImlhdCI6MTU4NjY2Nzk3OX0.y_d37q0ugzEJ4OSa70n_3mK9QUMAPxYqo0g96pP92LE
- > 来了就搬到我小区住，一下班没人看到就抱着我胳膊不放这是不小心吗

## PKoIuwOzIkE

中华酷联，只剩下华为了，巨大中华，也只剩下华为了。北朗摩爱华，只剩下爱立信和华为了，33年，一路走来，真不容易，无他，发个感慨而已。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYwODMyNTksImlhdCI6MTU4OTUyMTAyMH0.k-hgLpmY6QtJwE9k_rLxPRZh4yoMXSQFOGuALUrAjBM

# 脉脉搞笑

还要注意些什么？ https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY5ODc3NjYsImlhdCI6MTU5NzIxODUxNn0.fbsjztQ8qZSAOjGD_kL1brBeYN3s45jG1Y2pDPlPPJc
![](https://i9.taou.com/maimai/p/25017/7327_18_5I3kH2shBtpOwT-t480)
- > 紧急通道右侧也打通，两人分头走
- > 门口记得放监控，在双人床那边有人进总经理办公室或者秘书办公室都能看到
- > 隔音做得怎么样
- > 暗浴注意除湿
- > 紧急疏散通道一般设计不同方向两个门，如果只设计一个门，室内应单独有一个直接通向室外的安全出口。学习规范还是很重要的

有大佬给解释一下hr和hrbp是啥意思吗 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYzMjI3MTIsImlhdCI6MTU5MTI0NDY3M30.BC9-bL9lT_gK1e6U3zWPrPaZJ7i5TBstlqQue2jXH3E
- > 坏人，坏人帮派

最近想在感情上来点高并发，有没有什么保证线程安全的经验？大佬们指点一下，未婚。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5ODE0NzIsImlhdCI6MTU4ODMwOTg4MX0.f90ZDd3vSTR15OuNECQZAoCImjlGZ2K8ZyP4lXch8dI
- > 买多套房 容器化 互相隔离 统一调度

网易严选的朋友，帮解释下为什么这里icon要画个葫芦娃? ? ? https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5NTAzNzEsImlhdCI6MTU4Nzk2MTEzMH0.CAaFz1GMLkfwSyiSW6qPMKGuxiemQR2DWOaZNCAO4HI
- > 头上的葫芦可以放洗发水
- > 是指最近主打的葫芦娃联名美妆产品啦
- > 严选跟国漫葫芦娃合作这事我知道，但是为啥是二娃？难道是想表达“哪位小朋友的眼睛还没有看老师？”
