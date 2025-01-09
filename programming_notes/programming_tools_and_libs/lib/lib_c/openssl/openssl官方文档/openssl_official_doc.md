
OpenSSL overviews https://docs.openssl.org/master/man7/
- ossl-guide-introduction https://docs.openssl.org/master/man7/ossl-guide-introduction/
- ossl-guide-libraries-introduction https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/
- ossl-guide-libssl-introduction https://docs.openssl.org/master/man7/ossl-guide-libssl-introduction/

OpenSSL libraries https://docs.openssl.org/master/man3/
- > This is the OpenSSL API for the SSL and Crypto libraries. The ssl and crypto manpages are general overviews of those libraries.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 笔记

## ossl-guide-libraries-introduction

ossl-guide-libraries-introduction https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/
- > **INTRODUCTION**
  * > OpenSSL supplies two libraries that can be used by applications known as `libcrypto` and `libssl`. OpenSSL 提供了两个可供应用程序使用的库：`libcrypto` 和 `libssl`。
- > **PROVIDERS**
  * > If you don't load a provider explicitly (either in program code or via config) then the OpenSSL built-in "default" provider will be automatically loaded. 如果您没有显式加载提供程序（无论是在程序代码中还是通过配置），那么 OpenSSL 内置的“默认”提供程序将自动加载。
  * > Loading and unloading providers is quite an expensive operation. It is normally done once, early on in the application lifecycle and those providers are kept loaded for the duration of the application execution. ***加载和卸载提供程序是一项相当昂贵的操作。它通常在应用程序生命周期的早期完成一次，并且这些提供程序在应用程序执行期间保持加载状态***。
- > **LIBRARY CONTEXTS**
  * > Many OpenSSL API functions make use of a `library context`. A library context can be thought of as a "scope" within which configuration options take effect. When a provider is loaded, it is only loaded within the scope of a given library context. In this way it is possible for different components of a complex application to each use a different library context and have different providers loaded with different configuration settings. 许多 OpenSSL API 函数都使用`库上下文`。库上下文可以被认为是配置选项生效的“范围”。当加载提供程序时，它仅在给定库上下文的范围内加载。通过这种方式，复杂应用程序的不同组件可以各自使用不同的库上下文，并让不同的提供程序加载不同的配置设置。
  * > If an application does not explicitly create a library context then the "default" library context will be used. 如果应用程序没有显式创建库上下文，则将使用“默认”库上下文。
  * > Library contexts are represented by the **`OSSL_LIB_CTX`** type. Many OpenSSL API functions take a library context as a parameter. Applications can always pass **`NULL`** for this parameter to just use the default library context. 库上下文由 **`OSSL_LIB_CTX`** 类型表示。***许多 OpenSSL API 函数将库上下文作为参数。应用程序始终可以为此参数传递 `NULL`，以仅使用默认库上下文***。
  * > The default library context is automatically created the first time it is needed. This will automatically load any available configuration file and will initialise OpenSSL for use. Unlike in earlier versions of OpenSSL (prior to 1.1.0) no explicit initialisation steps need to be taken. 默认库上下文会在第一次需要时自动创建。这将自动加载任何可用的配置文件并初始化 OpenSSL 以供使用。***与 OpenSSL 的早期版本（1.1.0 之前）不同，不需要执行显式的初始化步骤***。
  * > Similarly when the application exits, the default library context is automatically destroyed. No explicit de-initialisation steps need to be taken. 同样，当应用程序退出时，默认库上下文将自动销毁。不需要采取明确的反初始化步骤。
- > **PROPERTY QUERY STRINGS**
  * > In some cases the available providers may mean that more than one implementation of any given algorithm might be available. For example the OpenSSL FIPS provider supplies alternative implementations of many of the same algorithms that are available in the OpenSSL default provider. 在某些情况下，可用的提供者可能意味着任何给定算法的不止一种实现可能是可用的。例如，OpenSSL FIPS 提供程序提供了 OpenSSL 默认提供程序中可用的许多相同算法的替代实现。
  * > The process of selecting an algorithm implementation is known as "fetching". When OpenSSL fetches an algorithm to use it is possible to specify a "property query string" to guide the selection process. For example a property query string of `"provider=default"` could be used to force the selection to only consider algorithm implementations in the default provider. 选择算法实现的过程称为“获取”。当 OpenSSL 获取要使用的算法时，可以指定“属性查询字符串”来指导选择过程。例如，属性查询字符串 `“provider=default”` 可用于强制选择仅考虑默认提供程序中的算法实现。
  * > Property query strings can be specified explicitly as an argument to a function. It is also possible to specify a default property query string for the whole library context using the `EVP_set_default_properties`(3) or `EVP_default_properties_enable_fips`(3) functions. Where both default properties and function specific properties are specified then they are combined. Function specific properties will override default properties where there is a conflict. 属性查询字符串可以显式指定为函数的参数。还可以使用 `EVP_set_default_properties`(3) 或 `EVP_default_properties_enable_fips`(3) 函数为整个库上下文指定默认属性查询字符串。如果指定了默认属性和特定于功能的属性，则将它们组合起来。如果存在冲突，函数特定属性将覆盖默认属性。
- > **MULTI-THREADED APPLICATIONS**
  * > As long as OpenSSL has been built with support for threads (the default case on most platforms) then most OpenSSL functions are thread-safe in the sense that it is safe to call the same function from multiple threads at the same time. However most OpenSSL data structures are not thread-safe. For example the BIO_write(3) and BIO_read(3) functions are thread safe. However it would not be thread safe to call BIO_write() from one thread while calling BIO_read() in another where both functions are passed the same BIO object since both of them may attempt to make changes to the same BIO object. ***只要 OpenSSL 构建时支持线程（大多数平台上的默认情况），那么大多数 OpenSSL函数都是线程安全的，因为同时从多个线程调用同一函数是安全的。然而，大多数 OpenSSL数据结构都不是线程安全的***。例如，`BIO_write`(3) 和 `BIO_read`(3) 函数是线程安全的。然而，从一个线程调用 `BIO_write()` 而在另一个线程中调用 `BIO_read()` 则不是线程安全的，其中两个函数都传递同一个 BIO 对象，因为它们都可能尝试对同一个 BIO 对象进行更改。
  * > There are exceptions to these rules. A small number of functions are not thread safe at all. Where this is the case this restriction should be noted in the documentation for the function. Similarly some data structures may be partially or fully thread safe. For example it is always safe to use an `OSSL_LIB_CTX` in multiple threads. ***这些规则也有例外。少数函数根本不是线程安全的***。在这种情况下，应在该函数的文档中注明此限制。类似地，***某些数据结构可能是部分或完全线程安全的。例如，在多个线程中使用 `OSSL_LIB_CTX` 始终是安全的***。
- > **ERROR HANDLING**
  * > Most OpenSSL functions will provide a return value indicating whether the function has been successful or not. It is considered best practice to always check the return value from OpenSSL functions (where one is available). 大多数 OpenSSL 函数都会提供一个返回值，指示该函数是否成功。***始终检查 OpenSSL 函数（如果有）的返回值被认为是最佳实践***。
  * > Most functions that return a pointer value will return `NULL` in the event of a failure. ***大多数返回指针值的函数在失败时将返回 `NULL`***。
  * > Most functions that return an integer value will return a positive integer for success. Some of these functions will return 0 to indicate failure. Others may return 0 or a negative value for failure. ***大多数返回整数值的函数将返回正整数表示成功。其中一些函数将返回 0 来指示失败。其他的可能会返回 0 或负值表示失败***。
  * > Some functions cannot fail and have a void return type. There are also a small number of functions that do not conform to the above conventions (e.g. they may return 0 to indicate success). 有些函数不会失败并且具有void返回类型。***还有少数函数不符合上述约定（例如，它们可能返回 0 表示成功）***。
  * > It is sometimes necessary to get further information about the cause of a failure (e.g. for debugging or logging purposes). Many (but not all) functions will add further information about a failure to the OpenSSL error stack. By using the error stack you can find out information such as a reason code/string for the error as well as the exact file and source line within OpenSSL that emitted the error. 有时需要获取有关故障原因的更多信息（例如出于调试或日志记录目的）。许多（但不是全部）函数会将有关失败的更多信息添加到 OpenSSL 错误堆栈中。通过使用错误堆栈，您可以找到错误的原因代码/字符串等信息，以及 OpenSSL 中发出错误的确切文件和源代码行。
  * > OpenSSL supplies a set of error handling functions to query the error stack. See ERR_get_error(3) for information about the functions available for querying error data. Also see `ERR_print_errors`(3) for information on some simple helper functions for printing error data. Finally look at `ERR_clear_error`(3) for how to clear old errors from the error stack. OpenSSL 提供了一组错误处理函数来查询错误堆栈。有关可用于查询错误数据的函数的信息，请参阅 `ERR_get_error`(3) 。另请参阅 `ERR_print_errors`(3) 以获取有关打印错误数据的一些简单辅助函数的信息。最后查看 `ERR_clear_error`(3) 以了解如何从错误堆栈中清除旧错误。
- > **OPENSSL PROVIDERS**
  * > The algorithms available in each of these providers may vary due to build time configuration options. The `openssl-list`(1) command can be used to list the currently available algorithms. 每个提供程序中可用的算法可能因构建时配置选项而异。`openssl-list`(1) 命令可用于列出当前可用的算法。
    >> //notes：实际上准确的命令是（此外，可以用 ***`openssl help list`*** 来查看具体用法和有哪些参数。）：
      ```sh
      $ openssl list -mac-algorithms
      Provided MACs:
        POLY1305 @ default
        { 1.3.6.1.4.1.1722.12.2.2, BLAKE2SMAC } @ default
        CMAC @ default
        { 1.0.9797.3.4, GMAC } @ default
        HMAC @ default
        { 2.16.840.1.101.3.4.2.19, KMAC-128, KMAC128 } @ default
        { 2.16.840.1.101.3.4.2.20, KMAC-256, KMAC256 } @ default
        SIPHASH @ default
        { 1.3.6.1.4.1.1722.12.2.1, BLAKE2BMAC } @ default
      ```  
  * > **Default provider**
  * > **Base provider**
  * > **FIPS provider**
  * > **Legacy provider**
  * > **Null provider**
- > **CONFIGURATION**
  * > By default OpenSSL will load a configuration file when it is first used. This will set up various configuration settings within the default library context. Applications that create their own library contexts may optionally configure them with a config file using the `OSSL_LIB_CTX_load_config`(3) function. 默认情况下，OpenSSL 在首次使用时会加载配置文件。这将在默认库上下文中设置各种配置设置。创建自己的库上下文的应用程序可以选择使用 `OSSL_LIB_CTX_load_config`(3) 函数使用配置文件来配置它们。
  * > The configuration file can be used to automatically load providers and set up default property query strings. ***配置文件可用于自动加载提供程序并设置默认属性查询字符串***。
- > **LIBRARY CONVENTIONS**
  * > Many OpenSSL functions that "get" or "set" a value follow a naming convention using the numbers 0 and 1, i.e. "get0", "get1", "set0" and "set1". This can also apply to some functions that "add" a value to an existing set, i.e. "add0" and "add1". 许多“获取”或“设置”值的 OpenSSL 函数都遵循使用数字0和1 的命名约定，即“get0”、“get1”、“set0”和“set1”。这也适用于一些将值“添加”到现有集合的函数，即“add0”和“add1”。
  * > For example the functions: 例如函数：
    ```c
    int X509_CRL_add0_revoked(X509_CRL *crl, X509_REVOKED *rev);
    int X509_add1_trust_object(X509 *x, const ASN1_OBJECT *obj);
    ```
  * > In the `0 version` the ownership of the object is passed to (for an add or set) or retained by (for a get) the parent object. For example after calling the `X509_CRL_add0_revoked()` function above, ownership of the rev object is passed to the crl object. Therefore, after calling this function rev should not be freed directly. It will be freed implicitly when crl is freed. ***在 0 版本中，对象的所有权被传递给（对于添加或设置）或由（对于获取）父对象保留***。例如，***在调用上面的 `X509_CRL_add0_revoked()` 函数之后，rev 对象的所有权将传递给 crl 对象。因此，调用该函数后不应直接释放 rev。当 crl 被释放时，它将被隐式释放***。
  * > In the `1 version` the ownership of the object is not passed to or retained by the parent object. Instead a copy or "up ref" of the object is performed. So after calling the `X509_add1_trust_object()` function above the application will still be responsible for freeing the obj value where appropriate. ***在 1 版本中，对象的所有权不会传递给父对象，也不会由父对象保留***。相反，执行对象的复制或“向上引用”。因此，***在调用上面的 `X509_add1_trust_object()` 函数之后，应用程序仍将负责在适当的情况下释放 obj 值***。
  * > Many OpenSSL functions conform to a naming convention of the form **`CLASSNAME_func_name()`**. In this naming convention the **`CLASSNAME`** is the name of an OpenSSL data structure (given in capital letters) that the function is primarily operating on. The **`func_name`** portion of the name is usually in lowercase letters and indicates the purpose of the function. 许多 OpenSSL 函数都遵循 **`CLASSNAME_func_name()`** 形式的命名约定。在此命名约定中，**`CLASSNAME`** 是函数主要操作的 OpenSSL 数据结构的名称（以大写字母给出）。名称的 **`func_name`** 部分通常为小写字母，表示函数的用途。
- > **DEMO APPLICATIONS**
  * > OpenSSL is distributed with a set of demo applications which provide some examples of how to use the various API functions. To look at them download the OpenSSL source code from the OpenSSL website ( https://www.openssl.org/source/ ). Extract the downloaded `.tar.gz` file for the version of OpenSSL that you are using and ***look at the various files in the `demos` sub-directory***. OpenSSL 随一组演示应用程序一起分发，这些应用程序提供了一些如何使用各种 API 函数的示例。要查看它们，请从 OpenSSL 网站 ( https://www.openssl.org/source/ ) 下载 OpenSSL 源代码。解压下载的 `.tar.gz` 文件以获取您正在使用的 OpenSSL 版本，***并查看 `demos` 子目录中的各个文件***。
  * > The `Makefiles` in the subdirectories give instructions on how to build and run the demo applications. 子目录中的 `Makefile` 提供了有关如何构建和运行演示应用程序的说明。

## ossl-guide-libcrypto-introduction

ossl-guide-libcrypto-introduction https://docs.openssl.org/master/man7/ossl-guide-libcrypto-introduction/
- > **INTRODUCTION**
  * > The OpenSSL cryptography library ( `libcrypto` ) enables access to a wide range of cryptographic algorithms used in various Internet standards. The services provided by this library are used by the OpenSSL implementations of `TLS` and `CMS`, and they have also been used to implement many other third party products and protocols. OpenSSL 加密库 ( `libcrypto` ) 允许访问各种 Internet 标准中使用的各种加密算法。该库提供的服务由 `TLS` 和 `CMS` 的 OpenSSL 实现使用，并且还用于实现许多其他第三方产品和协议。
  * > The functionality includes symmetric encryption, public key cryptography, key agreement, certificate handling, cryptographic hash functions, cryptographic pseudo-random number generators, message authentication codes (MACs), key derivation functions (KDFs), and various utilities. 其功能包括对称加密、公钥加密、密钥协商、证书处理、加密散列函数、加密伪随机数生成器、消息认证码 (MAC)、密钥派生函数 (KDF) 和各种实用程序。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
