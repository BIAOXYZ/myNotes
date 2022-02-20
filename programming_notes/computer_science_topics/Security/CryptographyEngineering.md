
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

## Ed25519

https://github.com/floodyberry/supercop/blob/3b8d1d3985c8b1549b86c48cfdefd75248bba933/crypto_sign/ed25519/amd64-64-24k/ge25519.h

ge25519 1.0.0 https://pypi.org/project/ge25519/
- > This library provides a native Python implementation of [Ed25519](https://ed25519.cr.yp.to/) group elements and a number of operations over them. The library makes it possible to fill gaps in application prototypes that may have specific limitations with respect to their operating environment or their ability to rely on non-Python dependencies.

Ed25519: high-speed high-security signatures https://ed25519.cr.yp.to/
- Papers https://ed25519.cr.yp.to/papers.html

ge25519 https://pkg.go.dev/github.com/oasisprotocol/ed25519/internal/ge25519

# MPC

安全多方计算（MPC）从入门到精通 https://blog.csdn.net/juzhenyuan/article/category/7777533
- 安全多方计算（MPC）从入门到精通：经典案例 https://blog.csdn.net/juzhenyuan/article/details/80929900

# ZKP

zkpblog -- 零知识证明相关的一些总结 https://github.com/huyuguang/zkpblog

PrivateBin is a minimalist, open source online pastebin where the server has zero knowledge of pasted data. https://github.com/PrivateBin/PrivateBin || https://privatebin.info/
- > This is a fork of ZeroBin, originally developed by Sébastien Sauvage. ZeroBin was refactored to allow easier and cleaner extensions. PrivateBin has many more features than the original ZeroBin. It is, however, still fully compatible to the original ZeroBin 0.19 data storage scheme. Therefore, such installations can be upgraded to PrivateBin without losing any data.
  >> ZeroBin https://github.com/sebsauvage/ZeroBin

# Hash

Sha256 Algorithm Explained https://github.com/dmarman/sha256algorithm
- > Sha256 algorithm explained online step by step visually https://sha256algorithm.com/ This website will help you understand how a sha256 hash is calculated from start to finish.

# others

- Java密码学 非对称加密以及使用secp256k1进行数字签名（ECDSA），也适合Android（上） https://www.jianshu.com/p/676a0eb33d31
- Java密码学 非对称加密以及使用secp256k1进行数字签名（ECDSA），也适合Android（下） https://www.jianshu.com/p/e6ac2c75e692

什么是信封加密？ https://www.alibabacloud.com/help/zh/doc-detail/42339.htm
- > 信封加密是类似数字信封技术的一种加密手段。这种技术将加密数据的数据密钥封入信封中存储、传递、和使用，不再使用主密钥直接加解密数据。

HLS标准加密 https://www.alibabacloud.com/help/zh/doc-detail/68612.htm

Cryptocoding https://github.com/veorq/cryptocoding
- > This page lists "coding rules" for implementations of cryptographic operations, and more generally for operations involving secret or sensitive values.

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

# attack

crypto-attacks -- Python implementations of cryptographic attacks and utilities. https://github.com/jvdsn/crypto-attacks
