
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
```console
以file为例分析openssl封装BIO的原理。
```
- > `00:25`: `BIO_s_file` https://docs.openssl.org/master/man3/BIO_s_file/
- > `05:30`: `BIO_f_buffer` https://docs.openssl.org/master/man3/BIO_f_buffer/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

第五集 demo程序演示如何使用file和buffer类型的BIO https://www.bilibili.com/video/BV1SH4y1Y7Bh/
```console
编写demo测试程序，演示如何使用file类型的BIO和buffer类型的BIO
```
- > `00:10`: file 类型的 BIO 是以 `BIO_s` 开头的；buffer 类型的 BIO 是以 `BIO_f` 为前缀的。
- > `00:30`: f 它的英文单词是 filter......就是过滤类型的 BIO；s 它的英文单词是 source，就是源目的类型的 BIO。这两种 BIO 的使用是完全不同的。

**`bio5_1.c`**
```c
#include <stdio.h>
#include <string.h>
#include <openssl/bio.h>

void main() {
    bioFile();
}

void bioFile() {
    BIO *bio = BIO_new_fp(stdout, BIO_NOCLOSE);
    if (bio == NULL) {
        printf("BIO_new_fp failed\n");
        return;
    }
    
    const char *pCh = "hello, world\n";
    BIO_write(bio, pCh, strlen(pCh));
    BIO_free(bio);
    return;
}
```
```sh
touch bio5_1.c
gcc -g -o bio5_1 bio5_1.c -I/opt/newssl/include -L/opt/newssl/lib64 -lssl -lcrypto
./bio5_1
```
```console
hello, world
```

**`bio5_2.c`**
```c
#include <stdio.h>
#include <string.h>
#include <openssl/bio.h>

void main() {
    bioFile();
}

void bioFile() {
    BIO *bio = BIO_new_fp(stdout, BIO_NOCLOSE);
    if (bio == NULL) {
        printf("BIO_new_fp failed\n");
        return;
    }
    
    BIO* buf = BIO_new(BIO_f_buffer());
    buf = BIO_push(buf, bio);
    
    const char *pCh = "hello, world\n";
    BIO_write(buf, pCh, strlen(pCh));
    BIO_free_all(buf);
    return;
}
```
```sh
touch bio5_2.c
gcc -g -o bio5_2 bio5_2.c -I/opt/newssl/include -L/opt/newssl/lib64 -lssl -lcrypto
./bio5_2
```
```console

```

**`bio5_3.c`**
```c
#include <stdio.h>
#include <string.h>
#include <openssl/bio.h>

void main() {
    bioFile();
}

void bioFile() {
    BIO *bio = BIO_new_fp(stdout, BIO_NOCLOSE);
    if (bio == NULL) {
        printf("BIO_new_fp failed\n");
        return;
    }
    
    BIO* buf = BIO_new(BIO_f_buffer());
    buf = BIO_push(buf, bio);
    
    const char *pCh = "hello, world\n";
    BIO_write(buf, pCh, strlen(pCh));
    // 只有 BIO_write，数据可能还在缓冲区，而没有写入到目标，
    // （这里的目标当然就是标准输出 stdout），因此需要 flush 一下。
    BIO_flush(buf);
    BIO_free_all(buf);
    return;
}
```
```sh
touch bio5_3.c
gcc -g -o bio5_3 bio5_3.c -I/opt/newssl/include -L/opt/newssl/lib64 -lssl -lcrypto
./bio5_3
```
```console
hello, world
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 2

Getting Started with OpenSSL - JuniorDevSG Code and Tell https://www.youtube.com/watch?v=K4iJ6iK4xPE

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
