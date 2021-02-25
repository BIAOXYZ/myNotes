
Auditing Applied Cryptography https://github.com/mimoo/cryptobible
> 这个里面有一些我感觉算是偏密码工程的东西，比如RSA-OAEP是否安全等：https://github.com/mimoo/cryptobible/blob/master/www/primitives/asymmetric_encryption.md

Awesome Cryptography -- A curated list of cryptography resources and links. https://github.com/sobolevn/awesome-cryptography
- > Awesome crypto-papers – A curated list of cryptography papers, articles, tutorials and howtos. https://github.com/pFarb/awesome-crypto-papers
- > Awesome HE – A curated list of homomorphic encryption libraries, software and resources. https://github.com/jonaschn/awesome-he
- > Cryptography Playground - A simple web tool to play and learn basic concepts of cryptography like, hashing, symmetric, asymmetric, zkp etc. https://vishwas1.github.io/crypto/index.html#/crypto

CTF Wiki https://github.com/ctf-wiki/ctf-wiki/ || https://ctf-wiki.github.io/ctf-wiki/
- 格概述 https://wiki.x10sec.org/crypto/asymmetric/lattice/overview/ || https://ctf-wiki.github.io/ctf-wiki/crypto/asymmetric/lattice/overview-zh/
- 整数域上的离散对数 https://wiki.x10sec.org/crypto/asymmetric/discrete-log/integer_field/

# Library

Advanced Crypto Software Collection (ACSC) http://hms.isi.jhu.edu/acsc/
- > OpenABE Library
  >> OpenABE https://github.com/zeutro/openabe
  
cryptoTools https://github.com/ladnir/cryptoTools   -->  //注意：别和这个搞混了，这个名字准确来说叫`CryptoTools.net`【 ~~https://cryptotools.net/~~ 】，是个网页版密码学算法工具。
- > CryptoTools is a portable c++14 library containing a collection of tools for building cryptographic protocols. This include asynchronous networking (Boost Asio), several fast primitives such as AES (AES-NI), Blake2, SHA1 (assembly), and eliptic curve crypto (miracl, Relic-Toolkit). There are also several other utilities tailered for implementing protocols.
- > Thirdparty networking is also supported. See frontend_cryptoTools/tutorial/Network.cpp for an example.

The Apache Milagro Cryptographic Library (AMCL) https://github.com/miracl/amcl || https://milagro.apache.org/docs/amcl-overview.html

# SSL or TLS attack

TLS 1.2协议现漏洞 近3000网站或受影响 - 安全 - cnBeta.COM https://www.cnbeta.com/articles/tech/817339.htm

Lessons Learned From Previous SSL/TLS Attacks: A Brief Chronology Of Attacks And Weaknesses https://eprint.iacr.org/2013/049.pdf

Summarizing Known Attacks on Transport Layer Security (TLS) and Datagram TLS (DTLS) https://tools.ietf.org/html/rfc7457

# ECC

椭圆曲线密码学的简单介绍 https://www.jianshu.com/p/dfebdf6a2400
> 包括最近新闻也提到的一点就是双椭圆曲线确定性随机比特生成器（Dual_EC_DRBG）问题。这是一个由美国国家标准协会（NIST）制定并被美国国家安全局（NSA）大力提倡的随机数发生器。Dual_EC_DRBG利用椭圆曲线算法的机制生成随机数。

Secp256k1 https://en.bitcoin.it/wiki/Secp256k1
- Standards for Efficient Cryptography (SEC) http://www.secg.org/sec2-v2.pdf

详解椭圆曲线加密（Elliptic Curves Cryptography，ECC）与ECDSA http://blog.chinaaet.com/justlxy/p/5100052864

ECC加密算法 https://blog.csdn.net/u010129119/article/details/62887707

# MPC

安全多方计算（MPC）从入门到精通 https://blog.csdn.net/juzhenyuan/article/category/7777533
- 安全多方计算（MPC）从入门到精通：经典案例 https://blog.csdn.net/juzhenyuan/article/details/80929900

# ZKP

zkpblog -- 零知识证明相关的一些总结 https://github.com/huyuguang/zkpblog

PrivateBin is a minimalist, open source online pastebin where the server has zero knowledge of pasted data. https://github.com/PrivateBin/PrivateBin || https://privatebin.info/
- > This is a fork of ZeroBin, originally developed by Sébastien Sauvage. ZeroBin was refactored to allow easier and cleaner extensions. PrivateBin has many more features than the original ZeroBin. It is, however, still fully compatible to the original ZeroBin 0.19 data storage scheme. Therefore, such installations can be upgraded to PrivateBin without losing any data.
  >> ZeroBin https://github.com/sebsauvage/ZeroBin

# others

- Java密码学 非对称加密以及使用secp256k1进行数字签名（ECDSA），也适合Android（上） https://www.jianshu.com/p/676a0eb33d31
- Java密码学 非对称加密以及使用secp256k1进行数字签名（ECDSA），也适合Android（下） https://www.jianshu.com/p/e6ac2c75e692

什么是信封加密？ https://www.alibabacloud.com/help/zh/doc-detail/42339.htm
- > 信封加密是类似数字信封技术的一种加密手段。这种技术将加密数据的数据密钥封入信封中存储、传递、和使用，不再使用主密钥直接加解密数据。

HLS标准加密 https://www.alibabacloud.com/help/zh/doc-detail/68612.htm

## practical/applied cryptography relevant books

The CryptoParty Handbook https://github.com/cryptoparty/handbook
> https://www.cryptoparty.in/learn/handbook

awesome-cryptography -- A curated list of cryptography resources and links. https://github.com/sobolevn/awesome-cryptography
- Books
  * Practical Cryptography for Developers - Developer-friendly book on modern cryptography (hashes, MAC codes, symmetric and asymmetric ciphers, key exchange, elliptic curves, digital signatures) with lots of code examples. https://cryptobook.nakov.com/ || https://github.com/nakov/practical-cryptography-for-developers-book

Crypto 101, the introductory book on cryptography. https://github.com/crypto101/book
> CRYPTO101 https://www.crypto101.io/

# performance related

Speedtest and Comparsion of Open-Source Cryptography Libraries and Compiler Flags https://panthema.net/2008/0714-cryptography-speedtest-comparison/

# from wechat

## 隐私计算联盟（注：不是机密计算）

视野|安全多方计算详解：背景、技术与协议 https://mp.weixin.qq.com/s/90PP-T7gDiz7HYtVhO3Ofg

隐私计算在金融领域的合规性分析 https://mp.weixin.qq.com/s/lMy7Ak389i19ECaUjVapVQ

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

## 其他

从顶级会议看网络空间安全领域应用基础研究 https://mp.weixin.qq.com/s/0DcEwP1regJNJQs4akg56g
