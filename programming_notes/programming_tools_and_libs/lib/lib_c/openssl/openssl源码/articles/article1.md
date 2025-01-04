
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
  * > Reading and writing to the BIO object, regardless of whether it is a socket or file, will always be performed using two functions: `BIO_read` and `BIO_write`. Simple, right? And the good part is that it stays that way. || 对 BIO 对象的读取和写入，无论它是套接字还是文件，都将始终使用两个函数执行：`BIO_read` 和 `BIO_write` 。很简单，对吧？好的部分是它保持这种状态。
  * > `BIO_read` will attempt to read a certain number of bytes from the server. It returns the number of bytes read, or 0 or -1. On a blocking connection, a return of 0 means that the connection was closed, while -1 indicates that an error occurred. On a non-blocking connection, a return of 0 means no data was available, and -1 indicates an error. To determine if the error is recoverable, call `BIO_should_retry`. || `BIO_read` 将尝试从服务器读取一定数量的字节。***它返回读取的字节数，或者 0 或 -1。<ins>在阻塞连接上，返回 0 表示连接已关闭，而 -1 表示发生错误。在非阻塞连接上，返回 0 表示没有可用数据，-1 表示有错误</ins>***。要确定错误是否可恢复，请调用 `BIO_should_retry` 。
  * > Listing 4. Reading from the connection || 清单 4. 从连接读取
    ```c
    int x = BIO_read(bio, buf, len);
    if(x == 0)
    {
        / Handle closed connection /
    }
    else if(x < 0)
    {
       if(! BIO_should_retry(bio))
        {
            / Handle failed read here /
        }

        / Do something to handle the retry /
    }
    ```
  * > `BIO_write` will attempt to write bytes to the socket. It returns the number of bytes actually written, or 0 or -1. As with `BIO_read`, 0 or -1 does not necessarily indicate an error. `BIO_should_retry` is the way to find out. If the write operation is to be retried, it must be with the exact same parameters as before. || `BIO_write` 将尝试将字节写入套接字。***它返回实际写入的字节数，或者 0 或 -1。与 `BIO_read` 一样，0 或 -1 不一定表示错误***。`BIO_should_retry` 就是找出答案的方法。如果要重试写入操作，则必须使用与之前完全相同的参数。
  * > Listing 5. Writing to the connection ||清单 5. 写入连接
    ```c
    if(BIO_write(bio, buf, len) <= 0)
    {
        if(! BIO_should_retry(bio))
        {
            / Handle failed write here /
        }

        / Do something to handle the retry /
    }
    ```
- > **Closing the connection 关闭连接**
  * > Closing the connection is simple as well. You can close the connection in one of two fashions: `BIO_reset`, or `BIO_free_all`. If you're going to reuse the object, use the first. If you won't be reusing it, use the second. || 关闭连接也很简单。您可以通过以下两种方式之一关闭连接：`BIO_reset` 或 `BIO_free_all` 。***如果要重用该对象，请使用第一个。如果您不想重复使用它，请使用第二个***。
  * > `BIO_reset` closes the connection and resets the internal state of the BIO object so that the connection can be reused. This is good if you're going to be using the same object throughout the application, such as with a secure chat client. It does not return a value. || `BIO_reset` 关闭连接并重置 BIO 对象的内部状态，以便可以重用该连接。***如果您要在整个应用程序中使用相同的对象（例如安全聊天客户端），那么这很好。它不返回值***。
  * > `BIO_free_all` does just what it says: it frees the internal structure and releases all associated memory, including closing the associated socket. If the BIO is embedded in a class, this would be used in the class' destructor. || ***`BIO_free_all` 正如它所说的那样：它释放内部结构并释放所有关联的内存，包括关闭关联的套接字***。如果 BIO 嵌入到类中，则它将在类的析构函数中使用。
  * > Listing 6. Closing the connection || 清单 6. 关闭连接
    ```c
    / To reuse the connection, use this line /
    BIO_reset(bio);

    / To free it from memory, use this line /
    BIO_free_all(bio);
    ```
- > **Setting up a secure connection 设置安全连接**
  * > Now it's time to throw on what is needed to set up a secure connection. The only part that changes is setting up and making the connection. Everything else is the same. || 现在是时候添加建立安全连接所需的内容了。***唯一改变的部分是<ins>设置和建立连接</ins>。其他一切都一样***。
  * > Secure connections require a handshake after the connection is established. During the handshake, the server sends a certificate to the client, which the client then verifies against a set of trust certificates. It also checks the certificate to make sure that it has not expired. Verifying that the certificate is trusted requires that a trust certificate store be loaded prior to establishing the connection. || ***安全连接需要在建立连接后进行握手***。在握手期间，服务器将证书发送给客户端，然后客户端根据一组信任证书验证该证书。它还检查证书以确保其尚未过期。***验证证书是否受信任需要在建立连接之前加载信任证书存储***。
  * > The client will send a certificate to the server only if the server requests one. This is known as client authentication. Using the certificate(s), cipher parameters are passed between the client and server to set up the secure connection. Even though the handshake is performed after the connection is established, the client or server can request a new handshake at any point in time. || ***仅当服务器请求证书时，客户端才会向服务器发送证书。这称为客户端身份验证***。使用证书，在客户端和服务器之间传递密码参数以建立安全连接。即使握手是在连接建立后执行的，客户端或服务器也可以在任何时间点请求新的握手。
  * > Handshakes and other aspects of setting up a secure connection are discussed in detail in the Netscape articles and `RFC 2246`. || Netscape 文章和 `RFC 2246` 详细讨论了握手和建立安全连接的其他方面。
- > **Setting up for a secure connection 设置安全连接**  【//notes：这里不是复制错了，注意多了一个 for】
  * > Setting up for a secure connection requires a couple more lines of code. Another pointer is required of the type `SSL_CTX`. This is a structure to hold the SSL information. It is also used to set up the SSL connection through the BIO library. This structure is created by calling `SSL_CTX_new` with an SSL method function, typically `SSLv23_client_method`. || 设置安全连接需要多行代码。***需要另一个 `SSL_CTX` 类型的指针。这是保存 SSL 信息的结构***。它还用于通过 BIO 库设置 SSL 连接。该结构是通过调用 `SSL_CTX_new` 创建的，还需要使用 SSL 方法函数，通常是 `SSLv23_client_method`。
  * > Another pointer of type `SSL` is also needed to hold the SSL connection structure (this is required for something that will be done shortly). This SSL pointer can also be used later to examine the connection information or to set up additional SSL parameters. || ***还需要另一个 `SSL` 类型的指针来保存 SSL 连接结构***（这是很快要做的事情所必需的）。稍后还可以使用此 SSL 指针来检查连接信息或设置其他 SSL 参数。
  * > Listing 7. Setting up the SSL pointers || 清单 7. 设置 SSL 指针
    ```c
    SSL_CTX  ctx = SSL_CTX_new(SSLv23_client_method());
    SSL  ssl;
    ```
- > **Loading the trust certificate store 加载信任证书存储**
  * > After the context structure is created, a trust certificate store must be loaded. This is absolutely necessary for verification of the peer certificate to succeed. If the certificate cannot be verified for trust, OpenSSL flags the certificate as invalid (but the connection can still continue). || 创建上下文结构后，必须加载信任证书存储。这对于成功验证对等证书是绝对必要的。如果无法验证证书的信任度，OpenSSL 会将证书标记为无效（***但连接仍可以继续***）。
  * > OpenSSL comes with a set of trust certificates. They are in the `certs` directory of the source tree. Each certificate is a separate file, though -- meaning that each one must be loaded separately. There is also a subfolder under certs with expired certificates. Attempting to load these will cause errors. || OpenSSL 附带一组信任证书。它们位于源树的 `certs` 目录中。不过，每个证书都是一个单独的文件——这意味着每个证书都必须单独加载。certs下还有一个包含过期证书的子文件夹。尝试加载这些将导致错误。
  * > You can load each file individually if you like, but for the sake of simplicity, the trust certificates from the latest OpenSSL distribution are included in the source code archive in a single file called `"TrustStore.pem."` If you already have a trust store file that will be used for your particular project, simply replace "TrustStore.pem" in Listing 8 with your file (***or load both of them with separate function calls***). || 如果您愿意，可以单独加载每个文件，但为了简单起见，最新 OpenSSL 发行版的信任证书包含在名为 `“TrustStore.pem”` 的单个文件的源代码存档中。如果您已经有一个将用于您的特定项目的信任存储文件，只需将 清单 8 中的“TrustStore.pem”替换为您的文件（或者使用单独的函数调用加载它们）。
