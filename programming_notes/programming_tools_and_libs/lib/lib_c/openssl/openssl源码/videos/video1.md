
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
# 无输出
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

第六集 demo测试过滤类型BIO和源目的类型BIO如何结合使用的。 https://www.bilibili.com/video/BV1gm411X7kK/

第七集 分析buffer类型的BIO的初始化函数 https://www.bilibili.com/video/BV17m411D7HZ/
```console
分析buffer类型的BIO和file类型的BIO的初始化函数
```
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + `static int buffer_new(BIO *bi)`
    + `#define DEFAULT_BUFFER_SIZE     4096`
    >> 【[ :star: ][`*`]】 //notes：这个文件（也就是 buffer 类型 BIO）里的 `buffer_free()` 函数，里面虽然是两个临时变量，但是变量名直接 a, b 是不是有点...- - PS：用 i, j 做变量名（尤其是 for 循环的时候）我觉得没啥问题，因为已经成为一种约定俗成了。
      ```c
       static int buffer_free(BIO *a)
       {
           BIO_F_BUFFER_CTX *b;

           if (a == NULL)
               return 0;
           b = (BIO_F_BUFFER_CTX *)a->ptr;
           OPENSSL_free(b->ibuf);
           OPENSSL_free(b->obuf);
           OPENSSL_free(a->ptr);
           a->ptr = NULL;
           a->init = 0;
           a->flags = 0;
           return 1;
       }
      ```
  * `crypto/bio/bss_file.c`:
    + `static int file_new(BIO *bi)`

第八集 分析openssl的buffer和file类型BIO的write函数的特别之处，为以后学习SSL/TLS通信打下基础。 https://www.bilibili.com/video/BV1SA4m1G7JA/
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + **`static int buffer_write(BIO *b, const char *in, int inl)`**
    + 查找某个定义在哪个头文件：
      ```sh
      root@83b34a21e2fc:/openssldir/openssl# find . -name "*.h" | xargs grep BIO_F_BUFFER_CTX
      ./crypto/bio/bio_local.h:} BIO_F_BUFFER_CTX;
      ```
  * `crypto/bio/bss_file.c`:
    + **`static int file_write(BIO *b, const char *in, int inl)`**
  * `crypto/bio/bio_local.h`:
    + **`typedef struct bio_f_buffer_ctx_struct {。。。} BIO_F_BUFFER_CTX;`**
      ```c
       typedef struct bio_f_buffer_ctx_struct {
           /*-
            * Buffers are setup like this:
            *
            * <---------------------- size ----------------------->
            * +---------------------------------------------------+
            * | consumed | remaining          | free space        |
            * +---------------------------------------------------+
            * <-- off --><------- len ------->
            */
           /*- BIO *bio; *//*
            * this is now in the BIO struct
            */
           int ibuf_size;              /* how big is the input buffer */
           int obuf_size;              /* how big is the output buffer */
           char *ibuf;                 /* the char array */
           int ibuf_len;               /* how many bytes are in it */
           int ibuf_off;               /* write/read offset */
           char *obuf;                 /* the char array */
           int obuf_len;               /* how many bytes are in it */
           int obuf_off;               /* write/read offset */
       } BIO_F_BUFFER_CTX;
      ```

第九集 通过openssl的buffer类型的BIO，学习内存的惯用管理方法。 https://www.bilibili.com/video/BV1oy421h7t5/
>> 【[ :star: ][`*`]】 //notes：这一集以及后面的第10、11集，都是讲 **`buffer_write()`** 函数的。讲得一般（最主要讲得也不全，没有涵盖该函数的所有内容），自己看下 **`static int buffer_write(BIO *b, const char *in, int inl)`** 源码就好。
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + `static int buffer_write(BIO *b, const char *in, int inl)`

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

第12集 分析openssl的BIO封装的control函数的亮点和特别之处。 https://www.bilibili.com/video/BV19u4m1w7RX/
```console
分析openssl为什么封装BIO的ctrl函数，从整体上查看file和buffer类型的ctrl函数。
```
- > `00:25`: "首先为什么会封装 control 这个函数？比如 `file_ctrl()` 这个函数。因为 method 这个结构体，它里边的函数数量是有限的，每一种类型的 BIO 都有一些自己独特的函数，是其他类型的 BIO 不存在的。为了解决这个问题，BIO 就封装了一个 control 函数。"
- 涉及文件：
  * `crypto/bio/bss_file.c`:
    + **`static long file_ctrl(BIO *b, int cmd, long num, void *ptr)`**
  * `crypto/bio/bf_buff.c`:
    + **`static long buffer_ctrl(BIO *b, int cmd, long num, void *ptr)`**
- 涉及文档：  
  * BIO_s_file https://docs.openssl.org/master/man3/BIO_s_file/
    + > **SYNOPSIS**
      ```c
      #include <openssl/bio.h>

      const BIO_METHOD *BIO_s_file(void);
      BIO *BIO_new_file(const char *filename, const char *mode);
      BIO *BIO_new_fp(FILE *stream, int flags);

      BIO_set_fp(BIO *b, FILE *fp, int flags);
      BIO_get_fp(BIO *b, FILE **fpp);

      int BIO_read_filename(BIO *b, char *name);
      int BIO_write_filename(BIO *b, char *name);
      int BIO_append_filename(BIO *b, char *name);
      int BIO_rw_filename(BIO *b, char *name);
      ```
      >> //notes：根据这个文档自己找到的代码：
      - `include/openssl/bio.h.in`
        ```c
        /* BIO_s_file() */
        # define BIO_set_fp(b,fp,c)      BIO_ctrl(b,BIO_C_SET_FILE_PTR,c,(char *)(fp))
        # define BIO_get_fp(b,fpp)       BIO_ctrl(b,BIO_C_GET_FILE_PTR,0,(char *)(fpp))
        ```

第13集 分析openssl的buffer过滤类型的BIO如何执行constrl函数的。 https://www.bilibili.com/video/BV1qA4m137Fh/
```console
buffer过滤类型的BIO通过cmd执行维护的BIO链表。
```
- > `02:25`: "这个就是 buffer 类型（过滤类型）的 BIO 的一个共性：每一个执行的命令都会运行它下级的 BIO 的 ctrl 函数。只要是在链表里的 BIO，ctrl 函数都会执行。"
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + `static long buffer_ctrl(BIO *b, int cmd, long num, void *ptr)`

第14集 学习如何设定buffer BIO的维护内存的大小。 https://www.bilibili.com/video/BV1d4421F78f/
```console
通过调用buffer size函数设定buffer维护内存的大小。
```
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + `static long buffer_ctrl(BIO *b, int cmd, long num, void *ptr)`
      - `case BIO_C_SET_BUFF_SIZE:`
        >> //notes：也就只讲了 `buffer_ctrl()` 函数里这一个分支的实现，并且也不全......回头把 `buffer_ctrl()` 和 `file_ctrl()` 的源码都细看一下。
  * `include/openssl/bio.h.in`
    + `# define BIO_set_buffer_size(b,size)     BIO_ctrl(b,BIO_C_SET_BUFF_SIZE,size,NULL)`
  * `include/openssl/bio.h`
    + `# define BIO_set_buffer_size(b,size)     BIO_ctrl(b,BIO_C_SET_BUFF_SIZE,size,NULL)`

第15集 分析openssl源码学习buffer read函数如何读取数据 https://www.bilibili.com/video/BV1LC411x7FC/
```console
分析openssl源码，学习buffer read函数如何从链表BIO中读取数据。
```
- 涉及文件：
  * `crypto/bio/bf_buff.c`:
    + **`static int buffer_read(BIO *b, char *out, int outl)`**

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 2

Getting Started with OpenSSL - JuniorDevSG Code and Tell https://www.youtube.com/watch?v=K4iJ6iK4xPE

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 3

基于openssl的C++实战加密与解密 https://www.bilibili.com/video/BV1N84y1A7Gt/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
