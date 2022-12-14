
Auditing Applied Cryptography https://github.com/mimoo/cryptobible
> 这个里面有一些我感觉算是偏密码工程的东西，比如RSA-OAEP是否安全等：https://github.com/mimoo/cryptobible/blob/master/www/primitives/asymmetric_encryption.md

Awesome Cryptography -- A curated list of cryptography resources and links. https://github.com/sobolevn/awesome-cryptography
- > Awesome crypto-papers – A curated list of cryptography papers, articles, tutorials and howtos. https://github.com/pFarb/awesome-crypto-papers
- > Awesome HE – A curated list of homomorphic encryption libraries, software and resources. https://github.com/jonaschn/awesome-he
- > Cryptography Playground - A simple web tool to play and learn basic concepts of cryptography like, hashing, symmetric, asymmetric, zkp etc. https://vishwas1.github.io/crypto/index.html#/crypto

CTF Wiki https://github.com/ctf-wiki/ctf-wiki/ || https://ctf-wiki.github.io/ctf-wiki/
- 格概述 https://wiki.x10sec.org/crypto/asymmetric/lattice/overview/ || https://ctf-wiki.github.io/ctf-wiki/crypto/asymmetric/lattice/overview-zh/
- 整数域上的离散对数 https://wiki.x10sec.org/crypto/asymmetric/discrete-log/integer_field/

Block cipher mode of operation https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation

# PKCS

PKCS https://en.wikipedia.org/wiki/PKCS || 公钥密码学标准 https://zh.wikipedia.org/wiki/%E5%85%AC%E9%92%A5%E5%AF%86%E7%A0%81%E5%AD%A6%E6%A0%87%E5%87%86
- > PKCS #5 Password-based Encryption Standard See RFC 8018 and [`PBKDF2`](https://en.wikipedia.org/wiki/PBKDF2).
- PKCS 11 https://en.wikipedia.org/wiki/PKCS_11
  * > The correct title of this article is `PKCS #11`. The omission of the `#` is due to technical restrictions.

PBKDF2 https://cryptobook.nakov.com/mac-and-key-derivation/pbkdf2
- > PBKDF2 is a simple cryptographic key derivation function, which is resistant to dictionary attacks and rainbow table attacks. It is based on iteratively deriving HMAC many times with some padding. The PBKDF2 algorithm is described in the Internet standard RFC 2898 (PKCS #5).
- > PBKDF2 takes several input parameters and produces the derived key as output:
  ```console
  key = pbkdf2(password, salt, iterations-count, hash-function, derived-key-len)
  ```
  >> 【[:star:][`*`]】 //notes：其实 PBKDF 的核心就是把 password 和一个 salt 放到哈希函数里，迭代制定的轮数，然后从最后结果截取一定位数作为输出的密钥。

# Library

Advanced Crypto Software Collection (ACSC) http://hms.isi.jhu.edu/acsc/
- > OpenABE Library
  >> OpenABE https://github.com/zeutro/openabe
  
cryptoTools https://github.com/ladnir/cryptoTools   -->  //注意：别和这个搞混了，这个名字准确来说叫`CryptoTools.net`【 ~~https://cryptotools.net/~~ 】，是个网页版密码学算法工具。
- > CryptoTools is a portable c++14 library containing a collection of tools for building cryptographic protocols. This include asynchronous networking (Boost Asio), several fast primitives such as AES (AES-NI), Blake2, SHA1 (assembly), and eliptic curve crypto (miracl, Relic-Toolkit). There are also several other utilities tailered for implementing protocols.
- > Thirdparty networking is also supported. See frontend_cryptoTools/tutorial/Network.cpp for an example.

The Apache Milagro Cryptographic Library (AMCL) https://github.com/miracl/amcl || https://milagro.apache.org/docs/amcl-overview.html

libsodium -- A modern, portable, easy to use crypto library. https://github.com/jedisct1/libsodium || https://doc.libsodium.org/
- > Sodium is a modern, easy-to-use software library for encryption, decryption, signatures, password hashing, and more.
- > It is a portable, cross-compilable, installable, and packageable fork of [NaCl](http://nacl.cr.yp.to/), with a compatible but extended API to improve usability even further.

# 国密/商密相关

Linux 6.2 fscrypt 文件系统加密框架新增支持我国的 SM4 分组密码标准 https://www.ithome.com/0/660/730.htm
- > SMS4 是我国无线局域网标准 WAPI 中所采用的分组密码标准，随后被我国商用密码标准采用，又名 SM4（***SM 是“商密”的缩写***，目前公布的其它商密标准包括 SM2 椭圆曲线公钥密码、SM3 密码杂凑算法）。
- > SMS4 的密钥长度和分组长度均为 128 比特，其设计安全性等同于 AES-128，***但是近年来的一些密码分析表明 SMS4 的安全性略弱于 AES-128***。由于 SMS4 的密钥长度固定为 128 比特，并未提供更长的可选密钥长度，因此 SMS4 不适用于保护需长期保密的数据，如需 50 年才能解密的保密文档。
- > IT之家了解到，负责支持 FSCRYPT SM4 的是阿里巴巴。在问及在 FSCRYPT 中加入 SM4 的好处时，阿里巴巴解释道：`我们希望为用户提供使用 SM4-XTS 加密磁盘和文件的能力，签署 SM2/3 的能力，以及使用 TLS 的 SM4-GCM / CCM 的能力（当然这属于其它部分），相当多的用户需要这些功能。`

## SM4

国密SM4/SMS4分组密码 http://gmssl.org/docs/sm4.html

SM4 国密算法入门介绍 https://houbb.github.io/2020/06/17/althgorim-cryptograph-04-sm4

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

# Quantum Cryptography

## XMSS

英飞凌推出采用后量子加密技术进行固件更新的 TPM 安全芯片 https://www.ithome.com/0/606/193.htm
- > 据介绍，该 TPM 芯片采用基于后量子加密技术（也就是基于哈希的签名算法 XMSS）的固件更新机制，是一款具有前瞻性的安全解决方案。该机制能够抵御黑客利用量子计算机发起的攻击，保护固件免受损坏，同时它的抗量子计算的固件升级方式，可确保设备长期可用。

XMSS reference code https://github.com/XMSS/xmss-reference

(PQCrypto 2011) XMSS - A Practical Forward Secure Signature Scheme Based on Minimal Security Assumptions https://link.springer.com/chapter/10.1007/978-3-642-25405-5_8 || https://eprint.iacr.org/2011/484.pdf

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

AES256 CBC vs AES256 GCM performance? https://stackoverflow.com/questions/73067225/aes256-cbc-vs-aes256-gcm-performance

# attack

crypto-attacks -- Python implementations of cryptographic attacks and utilities. https://github.com/jvdsn/crypto-attacks
