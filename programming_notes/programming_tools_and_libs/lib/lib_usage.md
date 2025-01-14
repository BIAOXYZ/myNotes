
# general

List of numerical libraries https://en.wikipedia.org/wiki/List_of_numerical_libraries
- Math Kernel Library https://en.wikipedia.org/wiki/Math_Kernel_Library
  * > Intel oneAPI Math Kernel Library, formerly just Intel Math Kernel Library (Intel MKL), is a library of optimized math routines for science, engineering, and financial applications. Core math functions include BLAS, LAPACK, ScaLAPACK, sparse solvers, fast Fourier transforms, and vector math.

Eigen 矩阵运算库在实际项目中的使用情况如何？ - 知乎 https://www.zhihu.com/question/21289223
- Eigen 矩阵运算库在实际项目中的使用情况如何？ - 少先队员的回答 - 知乎 https://www.zhihu.com/question/21289223/answer/55527330
  * > 如果代码基本一样，eigen比arm快，看看底层是具体用的哪个库做运算，还有编译选项也很重要，template在-o2和-o0上会完全是两个速度

# Assembly Libs

CRYPTOGAMS distribution repository https://github.com/dot-asm/cryptogams

# C Libs

### glibc

glibc源码分析（一）系统调用 - pk2017的文章 - 知乎 https://zhuanlan.zhihu.com/p/28984642

libc、glibc和glib的关系 https://blog.csdn.net/yasi_xi/article/details/9899599

### Libevent
<<libevent源码深度剖析一>>
http://blog.csdn.net/sparkliang/article/details/4957667

### GnuTLS

The GnuTLS Transport Layer Security Library https://www.gnutls.org/
- Git Repository: https://gitlab.com/gnutls/gnutls
- How can I help? https://www.gnutls.org/help.html
  * > https://gitlab.com/gnutls/gnutls/blob/master/doc/TODO
    >> https://gitlab.com/gnutls/gnutls/issues
- Document: https://www.gnutls.org/documentation.html
  * > PDF file. https://www.gnutls.org/manual/gnutls.pdf
  * > HTML - with one web page per node. https://www.gnutls.org/manual/html_node/index.html


TLS完全指南（零） - 王益的文章 - 知乎 https://zhuanlan.zhihu.com/p/26684020
- TLS和安全通信 https://github.com/k8sp/tls/blob/master/tls.md
  > "现实中，很多操作系统（Windows、Mac OS X）和浏览器（Chrome、 Firefox、IE）会内置一些靠谱的 CA 的身份证。但是有没有 CA 冒天下之大不韪说谎呢？据传说有一个自称 CNNIC 的机构说过谎。"
  * CNNIC 证书的危害及各种清除方法 https://program-think.blogspot.com/2010/02/remove-cnnic-cert.html


### OpenSSL [https://git.openssl.org/gitweb/?p=openssl.git;a=tree]

#### OpenSSL官方

OpenSSL -- Cryptography and SSL/TLS Toolkit https://www.openssl.org/ || https://github.com/openssl/openssl
- https://www.openssl.org/community/
  * https://www.openssl.org/community/getting-started.html
  * List of Committers https://www.openssl.org/community/committers.html
    + Paul Yang https://github.com/InfoHunter
      > https://paulyang.cn/
- https://www.openssl.org/docs/
  * Frequently Asked Questions https://www.openssl.org/docs/faq.html
  * Standards https://www.openssl.org/docs/standards.html
    - RFC 5246: The Transport Layer Security (TLS) Protocol Version 1.2 https://tools.ietf.org/html/rfc5246
  * Manpages https://www.openssl.org/docs/manpages.html
  * OpenSSL Cookbook https://www.feistyduck.com/books/openssl-cookbook/

  
 OpenSSL wiki https://wiki.openssl.org/
  - https://wiki.openssl.org/index.php/Compilation_and_Installation#Windows
  - https://wiki.openssl.org/index.php/Contributions
    > "With OpenSSL there is usually a preferred general high-level API (EVP) and then many lower level function calls that can be used to achieve similar outcomes."
  - EVP https://wiki.openssl.org/index.php/EVP
  - https://wiki.openssl.org/index.php/Developing_For_OpenSSL
    > "We are always looking for good people to help us build up the information held within this wiki. Documentation is one area where we are keen to improve things, and this wiki is an important location for people to come to. Information on how to get an account is available on the Welcome page."
    * https://wiki.openssl.org/index.php/Welcome
  - Command Line Utilities https://wiki.openssl.org/index.php/Command_Line_Utilities  

https://github.com/openssl/openssl
- HOW TO CONTRIBUTE TO OpenSSL https://github.com/openssl/openssl/blob/2d840893e78253bcce428603fdbcda159bdebe08/CONTRIBUTING.md

#### OpenSSL其他

- 使用 OpenSSL API 进行安全编程 - 1.创建基本的安全连接和非安全连接
https://www.ibm.com/developerworks/cn/linux/l-openssl.html
- 使用 OpenSSL API 进行安全编程 - 2.安全握手
https://www.ibm.com/developerworks/cn/linux/l-openssl2.html
- 使用 OpenSSL API 进行安全编程 - 3.提供安全服务
https://www.ibm.com/developerworks/cn/linux/l-openssl3.html

OpenSSL 简单思路和函数笔记 https://segmentfault.com/a/1190000005933931

HTTPS科普扫盲帖
http://www.cnblogs.com/chyingp/p/https-introduction.html

抓包分析SSL/TLS连接建立过程【总结】 https://www.cnblogs.com/Anker/p/6082966.html
> 图解SSL/TLS协议 http://www.ruanyifeng.com/blog/2014/09/illustration-ssl.html

SSL连接建立过程分析(1) https://blog.csdn.net/jinhill/article/details/3615626

#### 证书

##### X.509

https://en.wikipedia.org/wiki/X.509
```
Sample X.509 certificates
--------------------------------------------------
This is an example of a decoded X.509 certificate that was used by wikipedia.org and several other Wikipedia websites. 
It was issued by GlobalSign, as stated in the Issuer field. Its Subject field describes Wikipedia as an organization, and its 
Subject Alternative Name field describes the hostnames for which it could be used. The Subject Public Key Info field contains 
an ECDSA public key, while the signature at the bottom was generated by GlobalSign's RSA private key.
```

- 那些证书相关的玩意儿(SSL,X.509,PEM,DER,CRT,CER,KEY,CSR,P12等) https://www.cnblogs.com/guogangj/p/4118605.html
- X.509 数字证书结构和实例 http://www.cnblogs.com/chnking/archive/2007/08/28/872104.html


##### ASN.1

Openssl ASN.1 说明一 分享 https://blog.csdn.net/jasenwan88/article/details/7718851

##### csr

【转】linux下使用openssl生成 csr crt CA证书 https://my.oschina.net/jsan/blog/517765 -- by 山哥

#### OpenSSL命令与使用

- Openssl及加密解密（二）openssl https://yq.aliyun.com/articles/546160
- 加密、解密详解及CA的实现 https://yq.aliyun.com/articles/475842

OpenSSL命令使用指南 https://www.jianshu.com/p/115dac580bad
- OpenSSL命令详解（一）——标准命令 - CSDN博客 https://blog.csdn.net/scuyxi/article/details/54884976

https://crypto.stackexchange.com/questions/8776/what-is-u2fsdgvkx1
> 用openssl的 aes-128-cbc (别的算法不知道是不是这情况，估计差不多) 加密文件，密文开头总是 "U2FsdGVkX1" 。原来是base64编码的"Salted__"

- OPENSSL编程入门学习 http://www.cnblogs.com/LittleHann/p/3741907.html
- openssl编程.pdf http://vdisk.weibo.com/s/uwUzBqyZXMBm_
- OpenSSL编程初探1 --- 使用OpenSSL API建立SSL通信的一般流程简介 https://blog.csdn.net/howeverpf/article/details/18993945

OpenSSL Essentials: Working with SSL Certificates, Private Keys and CSRs https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs

openssl 证书请求和自签名命令req详解 https://www.cnblogs.com/gordon0918/p/5409286.html
```
What you are about to enter is what is called a Distinguished Name or a DN.
```

What books will help me learn everything I can about SSL/PKI? https://stackoverflow.com/questions/3938824/what-books-will-help-me-learn-everything-i-can-about-ssl-pki

#### OpenSSL源码

Linux安全体系学习笔记 OpenSSL源代码分析(1) https://www.linuxidc.com/Linux/2012-02/53190p2.htm

高级加密标准AES的工作模式（ECB、CBC、CFB、OFB） https://blog.poxiao.me/p/advanced-encryption-standard-and-block-cipher-mode/

测试蝈蝈 -- openssl https://www.cnblogs.com/testlife007/category/953160.html
- Openssl源代码整理学习 https://www.cnblogs.com/testlife007/p/6699566.html
- ~~Openssl编程--源码分析 https://www.cnblogs.com/testlife007/p/6738506.html~~  【//已转移】

艾-小小雨 -- openssl https://blog.csdn.net/aixiaoxiaoyu/article/category/7346344
- 13.openssl编程——ASN1库 https://blog.csdn.net/aixiaoxiaoyu/article/details/79175837
- 20.openssl编程——椭圆曲线 https://blog.csdn.net/aixiaoxiaoyu/article/details/79175848

openssl中ASN.1源码解读 https://blog.csdn.net/u010129119/article/details/53940865

https://blog.csdn.net/yyfzy/article/category/5570231   by yyfzy
- 通过OpenSSL解析X509证书基本项 https://blog.csdn.net/yyfzy/article/details/46798965

#### OpenSSL新闻

OpenSSL 1.1.1 LTS 版本发布 支持TLS v1.3 - Open Source 开源 - cnBeta.COM https://www.cnbeta.com/articles/tech/766921.htm

--------------------------------------------------

### [BoringSSL](https://github.com/google/boringssl)

Google 宣布创建 OpenSSL 分支：BoringSSL https://www.oschina.net/news/53040/google-create-openssl-patch-boringssl

使用 BoringSSL 优化 HTTPS 加密算法选择 http://blog.jobbole.com/94319/

--------------------------------------------------

### [GmSSL](https://github.com/guanzhi/GmSSL)

The GmSSL Project - 支持国密SM2/SM3/SM4/SM9的密码工具箱 http://gmssl.org/ || https://github.com/guanzhi
- > "GmSSL项目由北京大学关志副研究员的密码学研究组开发维护" 

GmSSL的命令行接口和SDK接口使用方式是怎样的？ - 李安然的回答 - 知乎 https://www.zhihu.com/question/43567665/answer/101573864

有人把国密算法集成到 OpenSSL 里的么？ - 自由无用的蔬菜的回答 - 知乎 https://www.zhihu.com/question/26236094/answer/377505665

--------------------------------------------------

BabaSSL: A Brisk and Better Assured Cryptographic Toolkit https://github.com/mosn/BabaSSL || www.babassl.org

### 其他OpenSSL实现

TASSL https://github.com/jntass/TASSL

### PBC

https://crypto.stanford.edu/pbc/manual/

CP-ABE环境配置
http://www.cnblogs.com/rockorange/p/3757805.html


### miracl

MIRACL Cryptographic SDK: Multiprecision Integer and Rational Arithmetic Cryptographic Library is a C software library that is widely regarded by developers as the gold standard open source SDK for elliptic curve cryptography (ECC). http://miracl.com 

https://github.com/miracl/MIRACL

#### acml

> 这个过去是从miracl代码fork出来的，但是后来不知道为啥独立了。而且miracl的go包装版本【[Golang wrapper for Milagro Crypto](https://github.com/miracl/gomiracl)】写着“Milagro”。难道这俩其实是一个组织？Milagro不过是MIRACL的下属分部之类的？

amcl - The Apache Milagro Cryptographic Library https://github.com/milagro-crypto/amcl


--------------------------------------------------


### libhydrogen

A lightweight, secure, easy-to-use crypto library suitable for constrained environments.  https://github.com/jedisct1/libhydrogen 

--------------------------------------------------

### fishhook

动态修改 C 语言函数的实现 https://draveness.me/fishhook

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# C++ Libs

### Crypto++

<<Crypto++编译使用>>
https://www.cnblogs.com/findumars/p/6009249.html

### Botan

Botan (programming library) https://en.wikipedia.org/wiki/Botan_(programming_library)

Crypto and TLS for Modern C++ https://github.com/randombit/botan
> Botan: Crypto and TLS for Modern C++ https://botan.randombit.net/

### libsnark

C++ library for zkSNARKs https://github.com/scipr-lab/libsnark

A system for verifying outsourced computations, and applying SNARKs. Simplified release of the main Pepper codebase. https://github.com/pepper-project/pequin
> The Pepper Project - toward practical verifiable computation https://github.com/pepper-project

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# PYTHON Libs

--------------------------------------------------
## other python libs
--------------------------------------------------

### ansible
http://www.ansible.com.cn/

### pdb

<零基础学习PDB命令行调试Python代码> http://python.jobbole.com/81184/

### getopt

python getopt http://www.cnblogs.com/lovemo1314/archive/2012/10/16/2725589.html

### ~~requests~~ //已单独拆分

### 2to3

- 2to3 - Automated Python 2 to 3 code translation https://docs.python.org/2/library/2to3.html
- 2to3 - 自动将 Python 2 代码转为 Python 3 代码 https://docs.python.org/zh-cn/3.7/library/2to3.html

### NetworkX

NetworkX https://www.osgeo.cn/networkx/

--------------------------------------------------
## python security related libs
--------------------------------------------------

### Charm

Charm: A Framework for Rapidly Prototyping Cryptosystems http://charm-crypto.io https://github.com/JHUISI/charm

### pwd
- http://blog.sina.com.cn/s/blog_a04184c101010kt6.html
- https://docs.python.org/2/library/pwd.html

### pycrypto 【已经停滞很久了，可以废弃了】

官方：
- https://www.dlitz.net/software/pycrypto/ || https://github.com/pycrypto/pycrypto

其他：
- https://pypi.python.org/pypi/pycrypto
- http://python.jobbole.com/84094/

### pycrypt 【这个名字也不错，可惜好名字都让。。。这项目也停滞了，并且完善度好像是最差的】 --> 【我又搜了下pycipher，果然是一样的。。。】

Pycrypt is a python suite for solving ciphers at (mostly Czech) cryptography games. https://github.com/mathead/pycrypt

Welcome to pycrypt’s documentation! https://pycrypt.readthedocs.io/en/latest/

### pycryptodome 【活跃开发中】
- https://github.com/Legrandin/pycryptodome
- https://www.pycryptodome.org/en/latest/ || https://pycryptodome.readthedocs.io/en/latest/

### pyca/cryptography 【活跃开发中，且pyca是一个组织，还有不少别的项目】
- https://github.com/pyca/cryptography
- https://cryptography.io/en/latest/
- https://cryptography.io/en/latest/development/

https://github.com/pyca/pyopenssl

### hmac
https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/0015108777177966ef0f4f8510a41b3b8c48cdcf7047b2d000

### Paramiko

Welcome to Paramiko!¶ http://www.paramiko.org/

--------------------------------------------------
## python bitcoin related libs
--------------------------------------------------

https://pypi.python.org/pypi?%3Aaction=search&term=bitcoin

- https://pypi.python.org/pypi/bitcoin
- https://pypi.python.org/pypi/python-bitcoinlib

--------------------------------------------------
## python machine learning related libs
--------------------------------------------------

A library for encrypted, privacy preserving deep learning https://github.com/OpenMined/PySyft

A Framework for Machine Learning on Encrypted Data https://github.com/tf-encrypted/tf-encrypted

### [TensorFlow](https://github.com/tensorflow/tensorflow) (https://tensorflow.org/)

TensorFlow Tutorials with YouTube Videos https://github.com/Hvass-Labs/TensorFlow-Tutorials

开源书：TensorFlow 内核剖析(中文) https://mp.weixin.qq.com/s/CBgqPDxRLe5asL0rLS4dqQ
> https://github.com/horance-liu/tensorflow-internals

Library for training machine learning models with privacy for training data https://github.com/tensorflow/privacy

TensorFlow 2.0 version's Tutorials and Examples, CNN, RNN, GAN tutorials, etc. TF 2.0版入门实例代码，实战教程。 https://github.com/dragen1860/TensorFlow2.0Tutorials

谷歌TensorFlow 2.1.0正式发布，最后支持Python 2 https://www.ithome.com/0/468/108.htm

基于Tensorflow2的深度学习开源书籍 https://github.com/Qinbf/Deep-Learning-Tensorflow2
- > 本书介绍视频： https://www.bilibili.com/video/BV19A411n7Fn
- > AI MOOC是我自己创办的一个免费的人工智能慕课平台，网站地址为 https://mooc.ai-xlab.com/ 。以后我会在上面不断更新最新的人工智能课程。
  >> 机器学习算法基础-覃秉丰 https://www.bilibili.com/video/BV1Rt411q7WJ

### [pytorch](https://github.com/pytorch/pytorch) (http://pytorch.org/)

PyTorch tutorials and fun projects including neural talk, neural style, poem writing, anime generation https://github.com/chenyuntc/pytorch-book

Simple examples to introduce PyTorch https://github.com/jcjohnson/pytorch-examples

pytorch handbook是一本开源的书籍，目标是帮助那些希望和使用PyTorch进行深度学习开发和研究的朋友快速入门，其中包含的Pytorch教程全部通过测试保证可以成功运行 https://github.com/zergtant/pytorch-handbook

A set of examples around pytorch in Vision, Text, Reinforcement Learning, etc. https://github.com/pytorch/examples

PyTorch Tutorial for Deep Learning Researchers https://github.com/yunjey/pytorch-tutorial

《Natural Language Processing with PyTorch》中文翻译 https://github.com/apachecn/NLP-with-PyTorch
> Natural Language Processing with PyTorch 中文版 https://nlp-pt.apachecn.org/

### ~~numpy~~ //已单独拆分
### ~~[Pandas](https://github.com/pandas-dev/pandas)~~ //已单独拆分
### ~~matplotlib~~ //已单独拆分

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Go Libs

### crypto
https://github.com/golang/crypto

### gomiracl

Golang wrapper for Milagro Crypto https://github.com/miracl/gomiracl

### gorgonia

Gorgonia is a library that helps facilitate machine learning in Go https://github.com/gorgonia/gorgonia

### cfssl

CFSSL: Cloudflare's PKI and TLS toolkit https://cfssl.org/ || https://github.com/cloudflare/cfssl

### cobra

golang命令行库Cobra的使用 https://www.jianshu.com/p/7abe7cff5384

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# Java Libs

Google的Tink库让你丢掉手中成百上千页的密码学书籍 - Google 谷歌 - cnBeta.COM https://www.cnbeta.com/articles/tech/763999.htm
- https://github.com/google/tink
- https://github.com/google/wycheproof

### [Bouncy Castle](http://www.bouncycastle.org/)

每次New一个BouncyCastleProvider导致的内存泄漏 https://blog.csdn.net/shenhaiwen/article/details/78400525

### jsnark & xjsnark

- A high-level framework for developing efficient zk-SNARK circuits https://github.com/akosba/xjsnark
- A Java library for writing circuits/constraints for zk-SNARKs. https://github.com/akosba/jsnark
