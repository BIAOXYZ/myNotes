
# 1

Easy introduction to cryptography concept with practical examples in Linux (openssl) https://x.com/0xor0ne/status/1874002642474577998
```console
Part 1: https://sergioprado.blog/introduction-to-encryption-for-embedded-linux-developers/
Part 2: https://sergioprado.blog/a-hands-on-approach-to-symmetric-key-encryption/
Part 3: https://sergioprado.blog/asymmetric-key-encryption-and-digital-signatures-in-practice/
Part 4: https://sergioprado.blog/what-are-random-numbers-and-how-they-are-managed-on-linux/
```

# 2

使用 OpenSSL 命令行进行 ECC 签名及验签 https://blog.csdn.net/henter/article/details/103759090
- > 需要说明的是：尽管在 OpenSSL 1.1.1 系列中增加了对 SM2 非对称算法、SM3 杂凑算法的支持，但是截止到 1.1.1d 版本，还不能使用类似于上面介绍的命令行方式来计算 SM2 签名。如果尝试执行以下一系列命令：
  ```sh
  openssl ecparam -name SM2 -genkey -out sm2.key
  openssl ec -in sm2.key -pubout -out sm2.pubkey
  openssl dgst -sm3 -sign sm2.key -out sm2.sig readme.txt
  ```
- > 前两步没有问题，到第三步做签名时，就会报错了，错误信息如下：`Error setting context 249572:error:100C508A:elliptic curve routines:pkey_ec_ctrl:invalid digest type:..\OpenSSL\openssl-1.1.1d\crypto\ec\ec_pmeth.c:331:`
- > 如果去查看 OpenSSL 1.1.1d 的源码，在 `\crypto\ec\ec_pmeth.c` 文件的第 331 行附近，可以看到以下内容：
- > 从这段代码可以看出，采用命令行方式计算签名，当前能够与签名算法配合使用的杂凑算法仅有 SHA-1、SHA-224、SHA-256、SHA-384、SHA-512 这几种。由于 SM2 签名算法需要与 SM3 杂凑算法配合使用，所以目前还不能采用命令行方式计算 SM2 签名。
