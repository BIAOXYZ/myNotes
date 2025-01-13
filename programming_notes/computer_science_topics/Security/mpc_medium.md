
# from wechat

## 中国密码学会

中国密码学会将举办“密码大讲堂”系列公益讲座 https://mp.weixin.qq.com/s/vWtNk6jn4ZV7rnwlnUfMzA

## 隐私计算联盟（注：不是机密计算）

官宣丨中国信通院公布第五批可信隐私计算评测结果，46 款产品通过评测 https://mp.weixin.qq.com/s/syrO1F2Vsc4gwjznxSEBCg
- > 2021年12月1日，中国信通院第五批“可信隐私计算评测”评审会圆满结束。
- > 评审环节包括产品资料审核、测试报告审核、质询与答疑、集中评议，共计 46 款产品通过了本批 57 个评测。其中，9 款产品通过了本批评测首次推出的“多方安全计算 安全专项评测”、“联邦学习 安全专项评测”。

视野|安全多方计算详解：背景、技术与协议 https://mp.weixin.qq.com/s/90PP-T7gDiz7HYtVhO3Ofg

更新|隐私计算在金融领域的合规性分析 https://mp.weixin.qq.com/s/ekXWew2PNteNKFBKLOft2g

视野|安全多方计算简介及隐私保护应用实践 https://mp.weixin.qq.com/s/mYt1zvJ8JAN_gBP1sfISKA

重磅发布|“隐私计算联盟”正式成立 https://mp.weixin.qq.com/s/2ZKl17YOMS3FPuczXxkeUA

## 虎符智库

刘哲理：实现全密文计算的主流技术与现实挑战 https://mp.weixin.qq.com/s/SeqBcPExVSNA_0pJtsVHDA
- > **2.3 实用密文计算**
  * > 很多应用不需要通用的密文计算方案，而是需要满足应用需求的特定密文计算。举例来说，游戏设备厂商希望精准的投放广告，考虑到腾讯有用户玩游戏的记录、京东有用户买游戏设备的记录，厂商希望把广告投放给既玩某一款游戏、又买某一款设备的用户，这样广告的转化率才更高，广告主才愿意花更多的钱。这实际就要求腾讯和京东将同时满足条件的用户选出来，是两个用户集合进行交集计算的问题。
  * > 在未来一段时间里，面向应用的密文计算会很流行。因为一方数据在特定维度下可以抽象为一个数据集合，密文集合运算作为特定的安全多方计算问题，包括并集、交集、基数大小、交集的势等，在很多领域得到了越来越多的应用。比如说，社交网络两个用户的共同好友，是一个集合求交的问题；保密投票中计算多少人投了某个特定人选，是一个交集求势的问题；多家不同银行联合计算储户的数量，是一个基数大小计算的问题。

## 金融电子化

顾颜：MPC助力金融数据要素价值释放 https://mp.weixin.qq.com/s/2f6IBc85arrGYTbeKh_eug
- > 2020年11月24日，中国人民银行正式发布《多方安全计算金融应用技术规范》金融行业标准，为发展数据安全融合技术、使多方数据在相互保密的前提下进行高效数据融合计算提供了统一标准。

MPC 与金融应用场景 https://mp.weixin.qq.com/s/GbYLANgvb5ifa-iFSGPc-Q
- > 从MPC协议上看，华控清交采用了一种半诚实安全模型下的安全协议—PrivPy。该协议安全性具备严格的密码学证明，相关成果已公开发表于国际知名会议（KDD2019）。PrivPy在参与计算节点为半诚实的安全假设下，满足《技术规范》中要求的数据隐私安全和计算结果的正确性。
- > 从计算平台上看，华控清交PrivPy多方计算平台具有通用性、可扩展性，与《技术规范》中的要求相呼应，具体包括如下方面。

## 开放隐私计算

### 2025.01

全同态加密：现状与未来 https://mp.weixin.qq.com/s/ZPWLGXLVikGyYIxujlBZIA

### 2022.03

终于有人讲明白隐私计算是什么了 https://mp.weixin.qq.com/s/yB1XJxO5v7UUjP-kM2Zllg || 隐私计算发展浅析 https://mp.weixin.qq.com/s/9btDgLCxMtyJ855n4c7aig
- > **隐私计算发展痛点**
  * > 根据中国信通院测试，`40万行样本x900列特征`的纵向联邦学习建模比明文慢数十倍甚至百倍，并且随着规模增加，这个倍数还会放大。
- > （本文转自公众号【一个数据玩家的自我修养】，作者银行从业十一年，程序员出身，转行业务，创业咨询，乐于助人，善于助人。）
>> //notes：此外，在另一个学术相关仓库里还有一些其他笔记：https://github.com/BIAOXYZ/paperRelatedRepository/blob/bec8d60f8d4adc370e04e936bde0e1555e4883c2/notes/essay/MPC/millionaires_problem/catalog.md

### 2022.01

隐私计算研究进展、现状及趋势 https://mp.weixin.qq.com/s/ygdP2VUZj5uKINTEd5s8DA
- > **12.3.1.1.隐私计算理论的提出**
  * > 2015 年 12 月初，在北京首农香山国际会议中心讨论隐私保护相关技术时，中国科学院信息工程研究所李凤华研究员在国内外首次提出将隐私保护相关研究上升到理论体系，强调隐私保护是一种应用需求，而隐私计算才能代表一个理论体系，为了进一步明确隐私计算的内涵，李凤华给出了 2.2.1 节所述的隐私计算定义，并于 2016 年 4 月，联合李晖、贾焰、俞能海、翁健教授[2]在《通信学报》发表“隐私计算研究范畴及发展趋势”，正式发布了隐私计算的概念、学术内涵和研究范畴。同年，该论文被列入由中国密码学会组编的《中国密码学发展报告(2016-2017)》的 4 项年度成果之一。

### 2021.07

两方计算的复杂度分析 - 兼信通院性能测评补充说明 https://mp.weixin.qq.com/s/Cb_yyeoF3yIwEgxkMeLxmQ

### 2020.03

安全多方计算学习路线 https://mp.weixin.qq.com/s/o9RGW8KHnK5g1oTDge2Biw || 安全多方计算学习路线 - 六三的文章 - 知乎 https://zhuanlan.zhihu.com/p/351492646

隐私计算企业列表-国内篇 https://mp.weixin.qq.com/s/jyeNSvUPdiYbekXgiOjNlw

## 其他

【浙江大学张秉晟分享】RAM模型下的多方隐私函数评估 https://mp.weixin.qq.com/s/wyT2zCf2h3HkCTOVdi9I5g || https://mp.weixin.qq.com/s/h3GCoApggBSX02CYYUdMMA || https://www.leiphone.com/category/industrynews/Lw965LWvOUHo3Mnj.html
- > 大家好，我是浙江大学的张秉晟。今天跟大家分享一个我们组和蚂蚁摩斯最新的合作研究成果《RAM模型下的多方隐私函数评估》。什么是RAM模型，什么是隐私函数评估？在这个Talk中我会慢慢跟大家介绍。
- > **目的与场景**
  * > 我们这次想要做的一个工作是在RAM模型下去实现一个Private Function Evaluation。也就是说我们这个安全多方计算系统再也不用被编译成电路就能支持RAM的计算结构。如果你有一个死循环，你有一个While Loop，甚至你的While Loop里面的Condition是一个不确定的Condition。比如说一个死循环里面，你有一个基于私密数据的隐私保护数据的条件，那么我们这个模型也能够去支持，并且我们这个模型会保护你的算法。我们的做法大致讲来是把一些高级语言(比如C++语言或者Java等)用编译器(比如用LLVM的编译器)编译成TinyRAM的指令集，为什么是TinyRAM呢？因为我们需要一个精简指令集，如果指令集太复杂了我们整个系统的开销就会非常的大。所以我们就选了一个精简指令集，TinyRAM。当然RISC-V也是可以的，我们对程序和输入都进行隐私保护。具体来说我们都进行秘密分享，我后面会一一和大家解释具体操作。
- > **MPC分布式ORAM**
- Multi-party Private Function Evaluation for RAM https://eprint.iacr.org/2022/939.pdf

2022年隐私计算6个蛮有意思的话题 https://mp.weixin.qq.com/s/hMx3n3sFhdQKc4KBMKxTPQ
- > 2）市场到底多大，谁在瓜分这块蛋糕
  * > 按卖给客户软件来的角度来看几类愿意采购软件的客户。银行总行级别：软件基础设施费用按200W估算；* 30家；银行分行级别：软件基础设施费用按50W估算；* 100家；保险：软件基础设施费用按100W估算；* 20家；券商：软件基础设施费用按100W估算；* 20家；政务大数据、大数据交易中心：级别软件基础设施费用按500W估算；* 10个；三大运营商：软件基础设施费用按1000W估算；3个；医疗机构：按100W估算；10个。（说明：价格是一个甲乙方的当前心里磋商价位区间、数量不是满打满算，是当前可能出得起钱的这部分数量）软件费用容量估算一下约：34000万（按年度去看软件市场）。
  * > 事实上，按这两年隐私计算厂商卖软件的情况下来，靠软件费用，这个蛋糕不是那么大，加上一些蠢蠢欲动可能出钱的客户，10亿的隐私计算软件规模？公开资料显示的几家头部厂商融资情况可以看到，华控+富数+数牍+洞见+蓝象+星云+……的累计估值差不多100个亿以内。

收藏 | 隐私计算厂商超级链接 https://mp.weixin.qq.com/s/z9QJFDcJtJphZ6ttBw1CfQ

隐私计算｜实现数据安全的必要技术手段！ https://mp.weixin.qq.com/s/W9hgeUSWul-wDFYPC8IDvQ
- > 1.陈小军 中国科学院信息工程研究所 正高级工程师
- > 2.刘洋 清华大学 智能产业研究院 副研究员/副教授

多方安全计算乱弹琴 https://mp.weixin.qq.com/s/zm_8EcjPBBrRE9dgdVtgdg
- > OT通过利用RSA，通过引入3个随机数 (x0, x1, k) 然后通过加密后实现对选择序号的保密，以及对原始2个带选择数的保密。 同时通过两次对同一个序号进行反向处理，实现只有对应，序号的数能够被恢复。 
- > 对于GMW，或者BGW，要实现Active模式， 可以使用Reed-Solomon Encoding，对错误的部分进行校验并恢复。
  * > **李德所罗门编码 Reed-Solomon encoding**
  * > 如果支持Malicious状态， 那么就可以称为是Verifiable Secret Sharing VSS了。

阿里联邦学习新方式：全同态密码 https://mp.weixin.qq.com/s/Zn_uOUEjQ00l1tEeBetZzg
- > **1.同态密码**
  * > 目前的联邦学习框架大多采用加法HE；如 FATE 用 Paillier 方案。它的优点是加密方案本身易于实现和易于封装成高级语言。缺点是大规模计算的性能瓶颈明显，如加密 10k 整数可能需要数分钟；它不支持密文乘法；对非线性计算如sigmoid无能为力。
- > **2.全同态密码**
  * > 下面介绍一下全同态密码 (Fully Homomorphic Encryption)，这里特指基于多项式格的 FHE；如 BFV 和 CKKS 方案。HE 和 FHE 的最大区别有两点：功能上FHE支持密文的加法和乘法，HE支持加法；FHE支持高延迟和高吞吐，而HE是低延迟和低吞吐。***通过设计算法，FHE 可以获得远优于HE 的性能***。
  * > 如果使用基于 HE 的矩阵向量乘性能比较堪忧，如矩阵为4096行*4096列, FATE 需要耗时 `1.5hr` 计算单次矩阵-向量乘。如果使用同步计算，需要等上一个 DO 计算完，总耗时接近 `1.5hr * #Dos`。而Yang et al. 用 FPGA 实现 HE，但比 FATE’s HE 只快了 10x。与FHE 的矩阵-向量乘对比，我们的算法能在 不到2 秒处理 4096x4096 的乘积 (1/10^3 of FATE’s HE)。

“隐私计算”四大技术路径解析 https://mp.weixin.qq.com/s/r4p0BWZxmfM79Z0dZbnitw
- > 路径一：数据流出、集中计算。代表技术：数据脱敏、差分隐私、同态加密
- > 路径二：数据流出、协同计算。代表技术：安全多方计算平台
- > 路径三：数据不流出、协同计算。代表技术：联邦学习平台
- > 路径四：数据不流出、集中计算。代表技术：可信计算平台

隐私计算简析、前瞻及实践 ——附工、农、建、交、微众等5家行应用实践 https://mp.weixin.qq.com/s/AYQAHGf00D-jg8keTIvMPQ

打造数据安全流通与融合应用新标杆——光大银行上线首个企业级多方安全计算平台 https://mp.weixin.qq.com/s/t06-x1qesqTwJW2XaNWLXA

从顶级会议看网络空间安全领域应用基础研究 https://mp.weixin.qq.com/s/0DcEwP1regJNJQs4akg56g

《腾讯隐私计算白皮书2021》重磅发布｜附下载 https://mp.weixin.qq.com/s/4-ey1BTuSghhmHr7Xk8V5Q  【`腾讯研究院`】
- > 腾讯研究院与腾讯数据平台部、腾讯安全、腾讯云区块链 、腾讯数据隐私保护部、腾讯安全平台部、腾讯广告联合发布《腾讯隐私计算白皮书2021》，旨在与业界共同探讨、推动隐私计算技术产业的发展，寻求在数字治理中发展和安全的平衡点。

《中国隐私计算产业发展报告（2020~2021）》全文 https://mp.weixin.qq.com/s/R3uA3KlH5Qs7I7WnsV44jQ

# ZKP

ZK｜零知识证明研究综述 https://mp.weixin.qq.com/s/HZdYyFTTv4CtgV-R5ytdBQ || 零知识证明研究综述及其在区块链领域应用生态整理 https://mp.weixin.qq.com/s/2570UHJ3K91ZF8awsIpxkA

What Is a Zero-Knowledge Proof? https://chain.link/education/zero-knowledge-proof-zkp
- > **Types of Zero-Knowledge Proofs**
  * > There are various implementations of ZKPs, with each having its own trade-offs of proof size, prover time, verification time, and more. They include:
  * > **zk-SNARKs**
    + > SNARKs, which stands for “succinct non-interactive argument of knowledge”, are small in size and easy to verify. They generate a cryptographic proof using elliptical curves, which is more gas-efficient than the hashing function method used by STARKS.
  * > **zk-STARKs**
    + > STARK stands for “scalable transparent argument of knowledge”. STARK-based proofs require minimal interaction between the prover and the verifier, making them much faster than SNARKs.
  * > **PLONK**
    + > Standing for “permutations over Lagrange-bases for oecumenical noninteractive arguments of knowledge,” PLONKs use a universal trusted setup that can be used with any program and can include a large number of participants.
  * > **Bulletproofs**
    + > Bulletproofs are short non-interactive zero-knowledge proofs that require no trusted setup. They are designed to enable private transactions for cryptocurrencies.
  * > There are already a number of zero-knowledge projects using these technologies, including StarkNet, zkSync, and Loopring.

万神殿 Patheon：零知识证明开发框架评测平台 https://mp.weixin.qq.com/s/1M8C2SokJl2A1xkKBfFmFg
- > **证明系统**
  * > 近年来，我们观察到零知识证明系统激增。跟上该领域所有激动人心的进步是具有挑战性的，我们根据成熟度和开发者采用情况精心挑选了以下证明系统作为测试对象。我们的目标是提供不同前端/后端组合的代表性样本。
    + > `Circom + snarkjs / rapidsnark`: Circom 是一种流行的 DSL，用于编写电路和生成 R1CS 约束，而 snarkjs 能够为 Circom 生成 Groth16 或 Plonk 证明。Rapidsnark 也是 Circom 的证明器，它生成 Groth16 证明，并且由于使用了 ADX 扩展，它通常比 snarkjs 快得多，并尽可能并行化证明生成。
    + > `gnark`: gnark 是来自 Consensys 的综合 Golang 框架，支持 Groth16、Plonk 和许多更高级的功能。
    + > `Arkworks`: Arkworks 是一个用于 zk-SNARKs 的综合 Rust 框架。
    + > `Halo2 (KZG)`: Halo2 是 Zcash 与 Plonk 的 zk-SNARK 实现。它配备了高度灵活的 Plonkish 算术，支持许多有用的原语，例如自定义网关和查找表。我们使用具有以太坊基金会和 Scroll 支持的 KZG 的 Halo2 分叉。
    + > `Plonky2`: Plonky2 是基于来自 Polygon Zero 的 PLONK 和 FRI 技术的 SNARK 实现。Plonky2 使用小的 Goldilocks 字段并支持高效的递归。在我们的性能测试中，我们以 100 位推测的安全性为目标，并使用为性能测试工作产生最佳证明时间的参数。具体来说，我们使用了 28 Merkle 查询、8 的放大系数和 16 位工作量证明挑战。此外，我们设置 num_of_wires = 60 和 num_routed_wires = 60。
    + > `Starky`: Starky 是 Polygon Zero 的高性能 STARK 框架。在我们的性能测试中，我们以 100 位推测的安全性为目标，并使用产生最佳证明时间的参数。具体来说，我们使用了 90 Merkle 查询、2 倍放大系数和 10 位工作量证明挑战。
