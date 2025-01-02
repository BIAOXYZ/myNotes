
# 1

Secure programming with the OpenSSL API https://developer.ibm.com/tutorials/l-openssl/
- > **Headers and initialization 标头和初始化**
  * > There are only three headers that will be used by this tutorial: `ssl.h, bio.h, and err.h`. All are in the openssl subdirectory, and all three will be required for developing your project. There are also only three lines necessary to initialize the OpenSSL library. All are listed in Listing 1. Other headers and/or initialization functions may be required for other features. || 本教程仅使用三个标头：`ssl.h、bio.h 和 err.h`。所有这些都位于 openssl 子目录中，开发项目时需要所有三个。初始化 OpenSSL 库也只需要三行。清单 1 中列出了所有内容。其他功能可能需要其他标头和/或初始化函数。
  * > Listing 1. Required headers || 清单 1. 必需的标头
    ```c
    /* OpenSSL headers */
    # include  "openssl/bio.h"
    # include  "openssl/ssl.h"
    # include  "openssl/err.h"

    /* Initializing OpenSSL */
    SSL_load_error_strings();
    ERR_load_BIO_strings();
    OpenSSL_add_all_algorithms();
    ```
- > **Setting up an unsecured connection 设置不安全的连接**
  * > OpenSSL uses an abstraction library called `BIO` to handle communication of various kinds, including files and sockets, both secure and not. It can also be set up as a filter, such for UU or Base64 coding. || OpenSSL 使用名为 `BIO` 的抽象库来处理各种类型的通信，包括文件和套接字（安全和非安全）。它还可以设置为过滤器，例如 UU 或 Base64 编码。
  * > The BIO library is a little complicated to fully explain here, so I will introduce bits and pieces of it as it becomes necessary. First, I will show you how to set up a standard socket connection. It takes fewer lines than using the BSD socket library. || BIO 库有点复杂，无法在这里全面解释，因此我将在必要时介绍它的一些片段。首先，我将向您展示如何建立标准套接字连接。与使用 BSD 套接字库相比，它需要更少的行数。
  * > Prior to setting up a connection, whether secure or not, a pointer for a BIO object needs to be created. This is similar to the `FILE pointer` for a file stream in standard C. || ***在建立连接之前，无论是否安全，都需要创建 BIO 对象的指针。这类似于标准 C 中文件流的 `FILE 指针`***。
  * > Listing 2. Pointer || 清单 2. 指针
    ```c
    BIO * bio;
    ```
- > **Opening a connection 打开连接**
  * > Creating a new connection requires a call to `BIO_new_connect`. You can specify both the hostname and port in the same call, as shown in Listing 3, which will also attempt to open the connection for you. You can also separate this into two separate calls: one to `BIO_new_connect` to create the connection and set the hostname, and one to `BIO_set_conn_port` (or `BIO_set_conn_int_port`) to set the port number. || 创建新连接需要调用 `BIO_new_connect` 。您可以在同一个调用中指定主机名和端口，如清单 3 所示，这也将尝试为您打开连接。您还可以将其分为两个单独的调用：一个调用 `BIO_new_connect` 来创建连接并设置主机名，另一个调用`BIO_set_conn_port` （或 `BIO_set_conn_int_port`）来设置端口号。
  * > Regardless, once both the hostname and port number are specified to the BIO, it will attempt to open the connection. There isn't any way around this. If there was a problem creating the BIO object, the pointer will be `NULL`. A call to `BIO_do_connect` must be made to verify that the connection was successful. || 无论如何，一旦为 BIO 指定了主机名和端口号，它将尝试打开连接。没有任何办法可以解决这个问题。***如果创建 BIO 对象时出现问题，则指针将为 `NULL`***。必须调用 `BIO_do_connect` 来验证连接是否成功。
  * > Listing 3. Creating and opening a connection || 清单 3. 创建并打开连接
    ```c
    bio = BIO_new_connect("hostname:port");
    if(bio == NULL)
    {
        / Handle the failure /
    }

    if(BIO_do_connect(bio) <= 0)
    {
        / Handle failed connection /
    }
    ```
  * > Here, the first line creates a new BIO object with the specified hostname and port, formatted in the fashion shown. For example, if you were going to connect to port 80 at www.ibm.com, the string would be www.ibm.com:80. The call to `BIO_do_connect` checks to see if the connection succeeded. It returns 0 or -1 on error. || 在这里，第一行创建一个具有指定主机名和端口的新 BIO 对象，其格式如图所示。例如，如果您要连接到 www.ibm.com 上的端口 80，则字符串将为 www.ibm.com:80 。对 `BIO_do_connect` 调用检查连接是否成功。***出错时返回 0 或 -1***。
- > **Communicating with the server 与服务器通信**
