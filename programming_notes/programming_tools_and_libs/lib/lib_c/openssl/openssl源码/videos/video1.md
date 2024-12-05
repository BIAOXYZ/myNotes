
# 1

合集·Linux C/C++程序员进阶之路，openssl源码介绍 https://space.bilibili.com/3546591447222658/channel/collectiondetail?sid=2392281

第二集 分析openssl的bio和bio_method的结构体定义。 马弓手C/C++编程 https://www.bilibili.com/video/BV1ZZ421U7iw/
- 涉及文件：
  * `crypto/bio/bio_local.h`: `struct bio_st`
  * `include/internal/bio.h`: `struct bio_method_st`

第三集 以file为例分析openssl的BIO的源码 https://www.bilibili.com/video/BV1QK421C7hJ/
- 涉及文件：
  * `crypto/bio/bss_file.c`: `static const BIO_METHOD methods_filep`、`BIO *BIO_new_file()`
  * `crypto/bio/bio_lib.c`: `BIO_read()`、`bio_read_intern()`、`BIO_write()`、`bio_write_intern()`

第四集 openssl为什么要封装file或者其他类型的BIO？ https://www.bilibili.com/video/BV1u2421A7iF/
- > `00:25`: `BIO_s_file` https://docs.openssl.org/master/man3/BIO_s_file/
