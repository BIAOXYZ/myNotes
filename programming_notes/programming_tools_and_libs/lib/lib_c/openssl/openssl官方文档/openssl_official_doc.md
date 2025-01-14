
OpenSSL overviews https://docs.openssl.org/master/man7/
- ossl-guide-introduction https://docs.openssl.org/master/man7/ossl-guide-introduction/
  * ossl-guide-libraries-introduction https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/
  * ossl-guide-libcrypto-introduction https://docs.openssl.org/master/man7/ossl-guide-libcrypto-introduction/
  * ossl-guide-libssl-introduction https://docs.openssl.org/master/man7/ossl-guide-libssl-introduction/
  * ossl-guide-tls-introduction https://docs.openssl.org/master/man7/ossl-guide-tls-introduction/
  * ossl-guide-tls-client-block https://docs.openssl.org/master/man7/ossl-guide-tls-client-block/
  * ossl-guide-tls-client-non-block https://docs.openssl.org/master/man7/ossl-guide-tls-client-non-block/
  * ossl-guide-tls-server-block https://docs.openssl.org/master/man7/ossl-guide-tls-server-block/
  * ossl-guide-quic-introduction https://docs.openssl.org/master/man7/ossl-guide-quic-introduction/
  * ossl-guide-quic-client-block https://docs.openssl.org/master/man7/ossl-guide-quic-client-block/
  * ossl-guide-quic-multi-stream https://docs.openssl.org/master/man7/ossl-guide-quic-multi-stream/

OpenSSL libraries https://docs.openssl.org/master/man3/
- > This is the OpenSSL API for the SSL and Crypto libraries. The ssl and crypto manpages are general overviews of those libraries.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 笔记

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

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
  * > The process of selecting an algorithm implementation is known as "fetching". When OpenSSL fetches an algorithm to use it is possible to specify a `"property query string"` to guide the selection process. For example a property query string of `"provider=default"` could be used to force the selection to only consider algorithm implementations in the default provider. 选择算法实现的过程称为“获取”。***当 OpenSSL 获取要使用的算法时，可以指定`“属性查询字符串”`来指导选择过程***。例如，属性查询字符串 `“provider=default”` 可用于强制选择仅考虑默认提供程序中的算法实现。
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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-libcrypto-introduction

ossl-guide-libcrypto-introduction https://docs.openssl.org/master/man7/ossl-guide-libcrypto-introduction/
- > **INTRODUCTION**
  * > The OpenSSL cryptography library ( `libcrypto` ) enables access to a wide range of cryptographic algorithms used in various Internet standards. The services provided by this library are used by the OpenSSL implementations of `TLS` and `CMS`, and they have also been used to implement many other third party products and protocols. OpenSSL 加密库 ( `libcrypto` ) 允许访问各种 Internet 标准中使用的各种加密算法。该库提供的服务由 `TLS` 和 `CMS` 的 OpenSSL 实现使用，并且还用于实现许多其他第三方产品和协议。
  * > The functionality includes symmetric encryption, public key cryptography, key agreement, certificate handling, cryptographic hash functions, cryptographic pseudo-random number generators, message authentication codes (MACs), key derivation functions (KDFs), and various utilities. 其功能包括对称加密、公钥加密、密钥协商、证书处理、加密散列函数、加密伪随机数生成器、消息认证码 (MAC)、密钥派生函数 (KDF) 和各种实用程序。
  * > **Algorithms**
    + > Cryptographic primitives such as the SHA256 digest, or AES encryption are referred to in OpenSSL as "algorithms". Each algorithm may have multiple implementations available for use. For example the RSA algorithm is available as a "default" implementation suitable for general use, and a "fips" implementation which has been validated to FIPS 140 standards for situations where that is important. It is also possible that a third party could add additional implementations such as in a hardware security module (HSM). ***SHA256 摘要或 AES 加密等加密原语在 OpenSSL 中称为“算法”***。每个算法可能有多种可供使用的实现。例如，RSA 算法可作为适合一般用途的“默认”实现，以及已根据 FIPS 140 标准进行验证的“fips”实现，适用于重要的情况。第三方也有可能添加额外的实现，例如在硬件安全模块 (HSM) 中。
    + > ***Algorithms are implemented in `providers`***. See [`ossl-guide-libraries-introduction(7)`](https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/) for information about providers. ***算法在提供者中实现***。有关提供程序的信息，请参阅 [`ossl-guide-libraries-introduction(7)`](https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/)。
  * > **Operations**
    + > Different algorithms can be grouped together by their purpose. For example there are algorithms for encryption, and different algorithms for digesting data. ***These different groups are known as "operations" in OpenSSL***. Each operation has a different set of functions associated with it. For example to perform an encryption operation using AES (or any other encryption algorithm) you would use the encryption functions detailed on the [EVP_EncryptInit(3)]() page. Or to perform a digest operation using SHA256 then you would use the digesting functions on the [EVP_DigestInit(3)]() page. ***不同的算法可以按其目的分组在一起***。例如，有用于加密的算法，以及用于消化数据的不同算法。***这些不同的组在 OpenSSL 中称为“操作”***。每个操作都有一组不同的与其关联的功能。例如，要使用 AES（或任何其他加密算法）执行加密操作，您可以使用 [EVP_EncryptInit(3)]() 页上详细介绍的加密函数。或者要使用 SHA256 执行摘要操作，则可以使用 [EVP_DigestInit(3)]() 页面上的摘要函数。
- > **ALGORITHM FETCHING**
  * > In order to use an algorithm an implementation for it must first be "fetched". Fetching is the process of looking through the available implementations, applying selection criteria (via a property query string), and finally choosing the implementation that will be used. ***为了使用算法，必须首先“获取”算法的实现***。获取是查看可用实现、应用选择标准（通过属性查询字符串）并最终选择将使用的实现的过程。
  * > Two types of fetching are supported by OpenSSL - "Explicit fetching" and "Implicit fetching". ***OpenSSL 支持两种类型的获取 - “显式获取”和“隐式获取”***。
  * > **Explicit fetching**
    + > Explicit fetching involves directly calling a specific API to fetch an algorithm implementation from a provider. This fetched object can then be passed to other APIs. These explicit fetching functions usually have the name `APINAME_fetch`, where `APINAME` is the name of the operation. For example `EVP_MD_fetch(3)` can be used to explicitly fetch a digest algorithm implementation. The user is responsible for freeing the object returned from the `APINAME_fetch` function using `APINAME_free` when it is no longer needed. 显式获取涉及直接调用特定 API 以从提供者获取算法实现。然后可以将此获取的对象传递给其他 API。***这些显式获取函数通常具有名称 `APINAME_fetch`，其中 `APINAME` 是操作的名称***。例如，***`EVP_MD_fetch(3)` 可用于显式获取摘要算法实现***。用户负责在不再需要时使用 `APINAME_free` 释放从 `APINAME_fetch` 函数返回的对象。
    + > These fetching functions follow a fairly common pattern, where three arguments are passed: ***这些获取函数遵循相当常见的模式，<ins>其中传递三个参数</ins>***：
      - > The `library context`
      - > An identifier
      - > A `property query string`
    + > The algorithm implementation that is fetched can then be used with other diverse functions that use them. For example the `EVP_DigestInit_ex(3)` function takes as a parameter an `EVP_MD` object which may have been returned from an earlier call to `EVP_MD_fetch(3)`. 然后，获取的算法实现可以与使用它们的其他不同函数一起使用。例如，***`EVP_DigestInit_ex(3)` 函数将 `EVP_MD` 对象作为参数，该对象可能是从先前调用 `EVP_MD_fetch(3)` 返回的***。
  * > **Implicit fetching**
    + > OpenSSL has a number of functions that return an algorithm object with no associated implementation, such as `EVP_sha256(3)`, `EVP_aes_128_cbc(3)`, `EVP_get_cipherbyname(3)` or `EVP_get_digestbyname(3)`. These are present for compatibility with OpenSSL before version 3.0 where explicit fetching was not available. ***OpenSSL 有许多函数返回没有关联实现的算法对象***，例如 `EVP_sha256(3) `、 `EVP_aes_128_cbc(3)` 、 `EVP_get_cipherbyname(3)` 或 `EVP_get_digestbyname(3)` 。***这些是为了与 3.0 版本之前的 OpenSSL 兼容而存在，其中`显式获取`不可用***。
    + > When they are used with functions like `EVP_DigestInit_ex(3)` or `EVP_CipherInit_ex(3)`, the actual implementation to be used is fetched implicitly using default search criteria (which uses `NULL` for the library context and property query string). 当它们与 `EVP_DigestInit_ex(3)` 或 `EVP_CipherInit_ex(3)` 等函数一起使用时，将使用默认搜索条件（对库上下文和属性查询字符串使用 `NULL`）隐式获取要使用的实际实现。
    + > In some cases implicit fetching can also occur when a `NULL` algorithm parameter is supplied. In this case an algorithm implementation is implicitly fetched using default search criteria and an algorithm name that is consistent with the context in which it is being used. ***在某些情况下，当提供 `NULL` 算法参数时，也可能会发生隐式获取***。在这种情况下，使用默认搜索条件和与其使用上下文一致的算法名称隐式获取算法实现。
    + > Functions that use an **`EVP_PKEY_CTX`** or an `EVP_PKEY(3)`, such as `EVP_DigestSignInit(3)`, all fetch the implementations implicitly. Usually the algorithm to fetch is determined based on the type of key that is being used and the function that has been called. 使用 **`EVP_PKEY_CTX`** 或 `EVP_PKEY(3)` 的函数（例如 `EVP_DigestSignInit(3)` ）都会`隐式获取`实现。通常，获取的算法是根据正在使用的密钥类型和已调用的函数来确定的。
  * > **Performance**
    + > If you perform the same operation many times with the same algorithm then it is recommended to use a single explicit fetch of the algorithm and then reuse the explicitly fetched algorithm each subsequent time. This will typically be faster than implicitly fetching the algorithm every time you use it. See an example of Explicit fetching in "USING ALGORITHMS IN APPLICATIONS". ***如果您使用相同的算法多次执行相同的操作，则建议使用该算法的单次显式获取，然后每次后续重复使用显式获取的算法。这通常比每次使用算法时隐式获取算法要快***。请参阅“在应用程序中使用算法”中的显式获取示例。
    + > If an explicitly fetched object is not passed to an operation, then any implicit fetch will use an internally cached prefetched object, but it will still be slower than passing the explicitly fetched object directly. ***如果未将`显式获取`的对象传递给操作，则任何`隐式获取`都将使用内部缓存的预取对象，但它仍然比直接传递显式获取的对象慢***。
    + > The following functions can be used for explicit fetching: 以下函数可用于显式获取：
- > **FETCHING EXAMPLES**
  * > The following section provides a series of examples of fetching algorithm implementations. 以下部分提供了一系列获取算法实现的示例。
  * > Fetch any available implementation of `SHA2-256` in the default context. Note that some algorithms have aliases. So `"SHA256"` and `"SHA2-256"` are synonymous: 在默认上下文中获取 `SHA2-256` 的任何可用实现。***请注意，某些算法有别名。所以 `“SHA256”` 和 `“SHA2-256”` 是同义词***：
    ```c
    EVP_MD *md = EVP_MD_fetch(NULL, "SHA2-256", NULL);
    ...
    EVP_MD_free(md);
    ```
  * > Fetch any available implementation of `AES-128-CBC` in the default context: 在默认上下文中获取 `AES-128-CBC` 的任何可用实现：
    ```c
    EVP_CIPHER *cipher = EVP_CIPHER_fetch(NULL, "AES-128-CBC", NULL);
    ...
    EVP_CIPHER_free(cipher);
    ```
  * > Fetch an implementation of `SHA2-256` from the default provider in the default context: 从默认上下文中的默认提供程序获取 `SHA2-256` 的实现：
    ```c
    EVP_MD *md = EVP_MD_fetch(NULL, "SHA2-256", "provider=default");
    ...
    EVP_MD_free(md);
    ```
  * > Fetch an implementation of `SHA2-256` that is not from the default provider in the default context: 获取不是来自默认上下文中的默认提供程序的 `SHA2-256` 实现：
    ```c
    EVP_MD *md = EVP_MD_fetch(NULL, "SHA2-256", "provider!=default");
    ...
    EVP_MD_free(md);
    ```
  * > Fetch an implementation of `SHA2-256` that is preferably from the FIPS provider in the default context: 获取 `SHA2-256` 的实现，该实现最好来自默认上下文中的 FIPS 提供程序：
    ```c
    EVP_MD *md = EVP_MD_fetch(NULL, "SHA2-256", "provider=?fips");
    ...
    EVP_MD_free(md);
    ```
  * > Fetch an implementation of `SHA2-256` from the default provider in the specified library context: 从指定库上下文中的默认提供程序获取 `SHA2-256` 的实现：
    ```c
    EVP_MD *md = EVP_MD_fetch(libctx, "SHA2-256", "provider=default");
    ...
    EVP_MD_free(md);
    ```
- > **USING ALGORITHMS IN APPLICATIONS**
  * > Cryptographic algorithms are made available to applications through use of the `"EVP"` APIs. Each of the various operations such as encryption, digesting, message authentication codes, etc., have a set of `EVP` function calls that can be invoked to use them. See the `evp(7)` page for further details. ***<ins>通过使用 `“EVP”`API，应用程序可以使用加密算法</ins>。加密、摘要、消息认证码等各种操作中的每一个都有一组可以调用的 `EVP` 函数调用来使用它们***。有关更多详细信息，请参阅 `evp(7)` 页面。
  * > Most of these follow a common pattern. A "context" object is first created. For example for a digest operation you would use an **`EVP_MD_CTX`**, and for an encryption/decryption operation you would use an **`EVP_CIPHER_CTX`**. The operation is then initialised ready for use via an "init" function - optionally passing in a set of parameters (using the [`OSSL_PARAM(3)`]() type) to configure how the operation should behave. Next data is fed into the operation in a series of "update" calls. The operation is finalised using a "final" call which will typically provide some kind of output. Finally the context is cleaned up and freed. ***其中大多数都遵循共同的模式。首先创建“上下文”对象***。例如，对于摘要操作，您将使用 **`EVP_MD_CTX`**，对于加密/解密操作，您将使用 **`EVP_CIPHER_CTX`**。***然后，该操作通过“init”函数进行初始化，可供使用*** - 可以选择传入一组参数（使用 [`OSSL_PARAM(3)`]() 类型）来配置操作的行为方式。***接下来的数据通过一系列“更新”调用输入到操作中***。该操作是使用“最终”调用来完成的，该调用通常会提供某种输出。***最后，上下文被清理并释放***。
  * > The following shows a complete example for doing this process for digesting data using `SHA256`. The process is similar for other operations such as encryption/decryption, signatures, message authentication codes, etc. Additional examples can be found in the OpenSSL demos (see "DEMO APPLICATIONS" in [ossl-guide-libraries-introduction(7)]()). ***下面显示了使用 `SHA256` 执行此过程以摘要数据的完整示例。该过程与其他操作类似，例如加密/解密、签名、消息身份验证代码等***。其他示例可以在 OpenSSL 演示中找到（请参阅 [ossl-guide-libraries-introduction(7)]() 中的“演示应用程序” ）。
    ```c
    #include <stdio.h>
    #include <openssl/evp.h>
    #include <openssl/bio.h>
    #include <openssl/err.h>

    int main(void)
    {
        EVP_MD_CTX *ctx = NULL;
        EVP_MD *sha256 = NULL;
        const unsigned char msg[] = {
            0x00, 0x01, 0x02, 0x03
        };
        unsigned int len = 0;
        unsigned char *outdigest = NULL;
        int ret = 1;

        /* Create a context for the digest operation */
        ctx = EVP_MD_CTX_new();
        if (ctx == NULL)
            goto err;

        /*
         * Fetch the SHA256 algorithm implementation for doing the digest. We're
         * using the "default" library context here (first NULL parameter), and
         * we're not supplying any particular search criteria for our SHA256
         * implementation (second NULL parameter). Any SHA256 implementation will
         * do.
         * In a larger application this fetch would just be done once, and could
         * be used for multiple calls to other operations such as EVP_DigestInit_ex().
         */
        sha256 = EVP_MD_fetch(NULL, "SHA256", NULL);
        if (sha256 == NULL)
            goto err;

       /* Initialise the digest operation */
       if (!EVP_DigestInit_ex(ctx, sha256, NULL))
           goto err;

        /*
         * Pass the message to be digested. This can be passed in over multiple
         * EVP_DigestUpdate calls if necessary
         */
        if (!EVP_DigestUpdate(ctx, msg, sizeof(msg)))
            goto err;

        /* Allocate the output buffer */
        outdigest = OPENSSL_malloc(EVP_MD_get_size(sha256));
        if (outdigest == NULL)
            goto err;

        /* Now calculate the digest itself */
        if (!EVP_DigestFinal_ex(ctx, outdigest, &len))
            goto err;

        /* Print out the digest result */
        BIO_dump_fp(stdout, outdigest, len);

        ret = 0;

     err:
        /* Clean up all the resources we allocated */
        OPENSSL_free(outdigest);
        EVP_MD_free(sha256);
        EVP_MD_CTX_free(ctx);
        if (ret != 0)
           ERR_print_errors_fp(stderr);
        return ret;
    }
    ```
- > **ENCODING AND DECODING KEYS 密钥编码和解码**
  * > Many algorithms require the use of a key. Keys can be generated dynamically using the `EVP APIs` (for example see `EVP_PKEY_Q_keygen(3)`). However it is often necessary to save or load keys (or their associated parameters) to or from some external format such as `PEM` or `DER` (see [openssl-glossary(7)]()). OpenSSL uses `encoders` and `decoders` to perform this task. ***许多算法需要使用密钥。可以使用 `EVP API` 动态生成密钥***（例如，请参阅 `EVP_PKEY_Q_keygen(3)` ）。然而，***通常需要在某些外部格式（例如 `PEM` 或 `DER`）之间保存或加载密钥（或其相关参数）***（请参阅 [openssl-glossary(7)]() ）。***OpenSSL 使用`编码器`和`解码器`来执行此任务***。
  * > Encoders and decoders are just algorithm implementations in the same way as any other algorithm implementation in OpenSSL. They are implemented by providers. The OpenSSL encoders and decoders are available in the default provider. They are also duplicated in the base provider. ***编码器和解码器只是算法实现，就像 OpenSSL 中任何其他算法实现一样。它们由提供商实施***。OpenSSL 编码器和解码器在默认提供程序中可用。它们也在基础提供者中重复。
  * > For information about encoders see `OSSL_ENCODER_CTX_new_for_pkey(3)`. For information about decoders see `OSSL_DECODER_CTX_new_for_pkey(3)`. 有关编码器的信息，请参阅 `OSSL_ENCODER_CTX_new_for_pkey(3)`。有关解码器的信息，请参阅`OSSL_DECODER_CTX_new_for_pkey(3)`。
  * > As well as using encoders/decoders directly there are also some helper functions that can be used for certain well known and commonly used formats. For example see `PEM_read_PrivateKey(3)` and `PEM_write_PrivateKey(3)` for information about reading and writing key data from `PEM` encoded files. ***除了直接使用编码器/解码器之外，还有一些辅助函数可用于某些众所周知和常用的格式***。例如，有关从 `PEM` 编码文件读取和写入密钥数据的信息，请参阅 `PEM_read_PrivateKey(3)` 和 `PEM_write_PrivateKey(3)`。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-libssl-introduction

ossl-guide-libssl-introduction https://docs.openssl.org/master/man7/ossl-guide-libssl-introduction/
- > **INTRODUCTION 介绍**
  * > The OpenSSL `libssl` library provides implementations of several secure network communications protocols. Specifically it provides `SSL/TLS` (SSLv3, TLSv1, TLSv1.1, TLSv1.2 and TLSv1.3), `DTLS` (DTLSv1 and DTLSv1.2) and `QUIC` (client side only). The library depends on `libcrypto` for its underlying cryptographic operations (see [ossl-guide-libcrypto-introduction(7)]()). ***OpenSSL `libssl` 库提供了多种安全网络通信协议的实现***。具体来说，它提供 `SSL/TLS`（SSLv3、TLSv1、TLSv1.1、TLSv1.2 和 TLSv1.3）、`DTLS`（DTLSv1 和 DTLSv1.2）和 `QUIC`（***仅限客户端***）。该库依赖于 `libcrypto` 进行底层加密操作（请参阅 [ossl-guide-libcrypto-introduction(7)]() ）。
  * > The set of APIs supplied by `libssl` is common across all of these different network protocols, so a developer familiar with writing applications using one of these protocols should be able to transition to using another with relative ease. ***`libssl` 提供的 API 集在所有这些不同的网络协议中都是通用的，因此熟悉使用其中一种协议编写应用程序的开发人员应该能够相对轻松地过渡到使用另一种协议***。
  * > An application written to use `libssl` will include the `<openssl/ssl.h>` header file and will typically use two main data structures, i.e. **`SSL`** and **`SSL_CTX`**. 编写使用 `libssl` 应用程序将包含 `<openssl/ssl.h>` 头文件，***并且通常会使用两个主要数据结构***，即 **`SSL`** 和 **`SSL_CTX`**。
  * > An `SSL object` is used to ***represent a connection to a remote peer***. Once a connection with a remote peer has been established data can be exchanged with that peer. `SSL对象` 用于表示与远程对等点的连接。一旦与远程对等点建立了连接，就可以与该对等点交换数据。
  * > When using `DTLS` any data that is exchanged uses `"datagram"` semantics, i.e. ***<ins>the packets of data can be delivered in any order, and they are not guaranteed to arrive at all</ins>***. In this case the `SSL object` used for the connection is also used for exchanging data with the peer. 当使用 `DTLS` 时，交换的任何数据都使用“数据报”语义，***<ins>即数据包可以以任何顺序传送，并且根本不保证它们到达</ins>***。在这种情况下，用于连接的 `SSL对象` 也用于与对等方交换数据。
  * > Both `TLS` and `QUIC` support the concept of a `"stream"` of data. Data sent via a stream is guaranteed to be delivered in order without any data loss. A stream can be uni- or bi-directional. ***`TLS` 和 `QUIC` 都支持数据“流”的概念。<ins>通过流发送的数据保证按顺序传送，不会丢失任何数据</ins>。流可以是单向的或双向的***。
  * > `SSL/TLS` only supports one stream of data per connection and it is always bi-directional. In this case the `SSL object` used for the connection also represents that stream. See [ossl-guide-tls-introduction(7)]() for more information. ***<ins>`SSL/TLS` 仅支持每个连接一个数据流，并且始终是双向的</ins>。在这种情况下，用于连接的 `SSL对象` 也代表该流***。请参阅 [ossl-guide-tls-introduction(7)]() 了解更多信息。
  * > The `QUIC` protocol can support multiple streams per connection and they can be uni- or bi-directional. In this case an `SSL object` can represent the underlying connection, or a stream, or both. Where multiple streams are in use a separate `SSL object` is used for each one. See [ossl-guide-quic-introduction(7)]() for more information. ***<ins>`QUIC` 协议可以支持每个连接多个流，并且它们可以是单向或双向的</ins>***。在这种情况下，***`SSL对象`可以代表底层连接或流，或两者。当使用多个流时，每个流都会使用一个单独的 `SSL对象`***。请参阅 [ossl-guide-quic-introduction(7)]() 了解更多信息。
  * > An **`SSL_CTX`** object is used to create the **`SSL`** object for the underlying connection. A single `SSL_CTX` object can be used to create many connections (each represented by a separate `SSL` object). Many API functions in `libssl` exist in two forms: one that takes an `SSL_CTX` and one that takes an `SSL`. Typically settings that you apply to the `SSL_CTX` will then be inherited by any `SSL` object that you create from it. Alternatively you can apply settings directly to the `SSL` object without affecting other `SSL` objects. Note that you should not normally make changes to an `SSL_CTX` after the first `SSL` object has been created from it. **`SSL_CTX`** 对象用于为底层连接创建 **`SSL`** 对象。***单个 `SSL_CTX` 对象可用于创建多个连接（每个连接由一个单独的 `SSL` 对象表示）。`libssl` 中的许多 API 函数以两种形式存在：一种采用 `SSL_CTX` ，另一种采用 `SSL`***。通常，***您应用于 `SSL_CTX` 的设置将被您从其创建的任何 `SSL` 对象继承。或者，您可以将设置直接应用于 `SSL` 对象，而不影响其他 `SSL` 对象***。请注意，***<ins>在创建第一个`SSL` 对象后，通常不应对其进行更改</ins>***。
- > **DATA STRUCTURES 数据结构**
  * > As well as **`SSL_CTX`** and **`SSL`** there are a number of other data structures that an application may need to use. They are summarised below. 除了 **`SSL_CTX`** 和 **`SSL`** 之外，应用程序还可能需要使用许多其他数据结构。它们总结如下。
  * > **`SSL_METHOD`** （`SSL 方法`）
    + > This structure is used to indicate the kind of connection you want to make, e.g. whether it is to represent the client or the server, and whether it is to use `SSL/TLS`, `DTLS` or `QUIC` (client only). It is passed as a parameter when creating the `SSL_CTX`. ***该结构用于指示您想要建立的连接类型，例如是代表客户端还是服务器，以及是否使用 `SSL/TLS`、`DTLS` 或 `QUIC`（仅限客户端）。<ins>创建 `SSL_CTX` 时它作为参数传递</ins>***。
  * > **`SSL_SESSION`** （`SSL 会话`）
    + > After establishing a connection with a peer the agreed cryptographic material can be reused to create future connections with the same peer more rapidly. The set of data used for such a future connection establishment attempt is collected together into an **`SSL_SESSION`** object. A single successful connection with a peer may generate zero or more such **`SSL_SESSION`** objects for use in future connection attempts. ***与对等点建立连接后，可以重复使用商定的加密材料，以便更快地与同一对等点创建未来的连接。用于此类未来连接建立尝试的数据集被收集到 `SSL_SESSION` 对象中***。与对等方的单个成功连接可能会生成零个或多个此类 `SSL_SESSION` 对象，以供将来的连接尝试使用。
  * > **`SSL_CIPHER`** （`SSL 密码`）
    + > During connection establishment the client and server agree upon cryptographic algorithms they are going to use for encryption and other uses. A single set of cryptographic algorithms that are to be used together is known as a `ciphersuite`. Such a set is represented by an **`SSL_CIPHER`** object. 在连接建立期间，客户端和服务器就它们将用于加密和其他用途的加密算法达成一致。一起使用的一组密码算法称为`密码套件`。这样的集合由 **`SSL_CIPHER`** 对象表示。
    + > The set of available `ciphersuites` that can be used are configured in the **`SSL_CTX`** or **`SSL`**. 可以使用的可用`密码套件集`在 **`SSL_CTX`** 或 **`SSL`** 中配置。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-tls-introduction

ossl-guide-tls-introduction https://docs.openssl.org/master/man7/ossl-guide-tls-introduction/
- > **WHAT IS TLS?**
  * > `TLS` stands for `Transport Layer Security`. TLS allows applications to securely communicate with each other across a network such that the `confidentiality` of the information exchanged is protected (i.e. it prevents eavesdroppers from listening in to the communication). Additionally it protects the `integrity` of the information exchanged to prevent an attacker from changing it. Finally it provides `authentication` so that one or both parties can be sure that they are talking to who they think they are talking to and not some imposter. ***`TLS` 代表`传输层安全`***。TLS 允许应用程序通过网络安全地相互通信，从而保护所交换信息的`机密性`（即防止窃听者监听通信）。此外，它还可以保护所交换信息的`完整性`，以防止攻击者更改它。最后，它提供`身份验证`，以便一方或双方可以确定他们正在与他们认为正在交谈的人而不是冒名顶替者交谈。
  * > Sometimes `TLS` is referred to by its predecessor's name `SSL` (`Secure Sockets Layer`). OpenSSL dates from a time when the SSL name was still in common use and hence many of the functions and names used by OpenSSL contain the "SSL" abbreviation. Nonetheless OpenSSL contains a fully fledged TLS implementation. ***有时，`TLS` 以其前身名称 `SSL`（`安全套接字层`）来引用。OpenSSL 的历史可以追溯到 SSL 名称仍然普遍使用的时期，因此 OpenSSL 使用的许多函数和名称都包含“SSL”缩写***。尽管如此，OpenSSL 包含一个成熟的 TLS 实现。
  * > TLS is based on a client/server model. The application that initiates a communication is known as the client. The application that responds to a remotely initiated communication is the server. The term `"endpoint"` refers to either of the client or the server in a communication. The term `"peer"` refers to the endpoint at the other side of the communication that we are currently referring to. So if we are currently talking about the client then the peer would be the server. TLS 基于客户端/服务器模型。发起通信的应用程序称为客户端。响应远程发起的通信的应用程序是服务器。术语`“端点”`是指通信中的客户端或服务器。术语`“对等点”`是指我们当前所指的通信另一端的端点。因此，如果我们当前谈论的是客户端，那么对等点就是服务器。
  * > TLS is a standardised protocol and there are numerous different implementations of it. Due to the standards an OpenSSL client or server is able to communicate seamlessly with an application using some different implementation of TLS. TLS (and its predecessor SSL) have been around for a significant period of time and the protocol has undergone various changes over the years. Consequently there are different versions of the protocol available. TLS includes the ability to perform version negotiation so that the highest protocol version that the client and server share in common is used. TLS 是一种标准化协议，有多种不同的实现。根据这些标准，OpenSSL 客户端或服务器能够使用某种不同的 TLS 实现与应用程序无缝通信。***TLS（及其前身 SSL）已经存在了很长一段时间，并且该协议多年来经历了各种变化。因此，有不同版本的协议可用。TLS 包括执行版本协商的功能，以便使用客户端和服务器共同共享的最高协议版本***。
  * > TLS acts as a security layer over some lower level transport protocol. Typically the transport layer will be TCP. ***`TLS` 充当某些较低级别传输协议之上的安全层。通常，传输层是 `TCP`***。
- > **SSL AND TLS VERSIONS SSL 和 TLS 版本**
  * > SSL was initially developed by Netscape Communications and its first publicly released version was SSLv2 in 1995. Note that SSLv1 was never publicly released. SSLv3 came along quickly afterwards in 1996. Subsequently development of the protocol moved to the IETF which released the first version of TLS (TLSv1.0) in 1999 as RFC2246. TLSv1.1 was released in 2006 as RFC4346 and TLSv1.2 came along in 2008 as RFC5246. The most recent version of the standard is TLSv1.3 which was released in 2018 as RFC8446. SSL 最初由 `Netscape Communications` 开发，其第一个公开发布的版本是 1995 年的 `SSLv2`。***请注意，<ins>`SSLv1` 从未公开发布</ins>***。`SSLv3` 随后在 1996 年迅速出现。随后该协议的开发转移到了 `IETF`，IETF 于 1999 年发布了 TLS 的第一个版本 (`TLSv1.0`)，即 `RFC2246`。`TLSv1.1` 于 2006 年作为 `RFC4346` 发布，`TLSv1.2` 于 2008 年作为 `RFC5246` 发布。***该标准的最新版本是 `TLSv1.3`，于 2018 年作为 `RFC8446` 发布***。
  * > Today TLSv1.3 and TLSv1.2 are the most commonly deployed versions of the protocol. The IETF have formally deprecated TLSv1.1 and TLSv1.0, so anything below TLSv1.2 should be avoided since the older protocol versions are susceptible to security problems. 如今，***`TLSv1.3` 和 `TLSv1.2` 是该协议最常部署的版本。IETF 已正式弃用 `TLSv1.1` 和 `TLSv1.0`，<ins>因此应避免使用低于 `TLSv1.2` 的任何协议</ins>***，因为较旧的协议版本容易出现安全问题。
  * > OpenSSL does not support SSLv2 (it was removed in OpenSSL 1.1.0). Support for SSLv3 is available as a compile time option - but it is not built by default. Support for TLSv1.0, TLSv1.1, TLSv1.2 and TLSv1.3 are all available by default in a standard build of OpenSSL. However special run-time configuration is required in order to make TLSv1.0 and TLSv1.1 work successfully. ***OpenSSL 不支持 `SSLv2`（在 `OpenSSL 1.1.0` 中已删除）***。对 `SSLv3` 的支持可作为编译时选项提供 - 但默认情况下不会构建。***OpenSSL 标准版本默认支持 `TLSv1.0`、`TLSv1.1`、`TLSv1.2` 和 `TLSv1.3`。但是，为了使 TLSv1.0 和 TLSv1.1 成功工作，需要特殊的运行时配置***。
  * > OpenSSL will always try to negotiate the highest protocol version that it has been configured to support. In most cases this will mean either TLSv1.3 or TLSv1.2 is chosen. ***OpenSSL 将始终尝试协商其配置支持的最高协议版本***。在大多数情况下，这意味着选择 TLSv1.3 或 TLSv1.2。
- > **CERTIFICATES 证书**
  * > In order for a client to establish a connection to a server it must authenticate the identify of that server, i.e. it needs to confirm that the server is really the server that it claims to be and not some imposter. In order to do this the server will send to the client a digital certificate (also commonly referred to as an `X.509` certificate). The certificate contains various information about the server including its full `DNS` hostname. Also within the certificate is the server's public key. The server operator will have a private key which is linked to the public key and must not be published. ***为了让客户端建立到服务器的连接，它必须验证该服务器的身份，即它需要确认该服务器确实是它声称的服务器***，而不是冒名顶替者。***为此，服务器将向客户端发送数字证书（通常也称为 `X.509` 证书）。该证书包含有关服务器的各种信息，包括其完整的 `DNS` 主机名。证书中还包含服务器的公钥***。服务器运营者将拥有一个与公钥链接的私钥，并且不得公开。
  * > Along with the certificate the server will also send to the client proof that it knows the private key associated with the public key in the certificate. It does this by digitally signing a message to the client using that private key. The client can verify the signature using the public key from the certificate. If the signature verifies successfully then the client knows that the server is in possession of the correct private key. ***除了证书之外，服务器还将向客户端发送证明，证明它知道与证书中的公钥关联的私钥。它通过使用该私钥对发送给客户端的消息进行数字签名来实现此目的***。客户端可以使用证书中的公钥来验证签名。如果签名验证成功，则客户端知道服务器拥有正确的私钥。
  * > The certificate that the server sends will also be signed by a `Certificate Authority`. The Certificate Authority (commonly known as a `CA`) is a third party organisation that is responsible for verifying the information in the server's certificate (including its `DNS hostname`). The CA should only sign the certificate if it has been able to confirm that the server operator does indeed have control of the server associated with its DNS hostname and that the server operator has control of the private key. 服务器发送的证书也将由`证书颁发机构`签名。证书颁发机构（通常称为 `CA`）是第三方组织，负责验证服务器证书中的信息（包括其 `DNS 主机名`）。仅当 CA 能够确认服务器运营商确实控制了与其 DNS 主机名关联的服务器并且服务器运营商控制了私钥时，才应签署证书。
  * > In this way, if the client trusts the CA that has signed the server's certificate and it can verify that the server has the right private key then it can trust that the server truly does represent the DNS hostname given in the certificate. The client must also verify that the hostname given in the certificate matches the hostname that it originally sent the request to. 这样，如果客户端信任已签署服务器证书的 CA，并且它可以验证服务器是否具有正确的私钥，那么它可以信任服务器确实代表了证书中给出的 DNS 主机名。***客户端还必须验证证书中给出的主机名是否与其最初向其发送请求的主机名相匹配***。
  * > Once all of these checks have been done the client has successfully verified the identify of the server. OpenSSL can perform all of these checks automatically but it must be provided with certain information in order to do so, i.e. the set of CAs that the client trusts as well as the DNS hostname for the server that this client is trying to connect to. 完成所有这些检查后，客户端已成功验证服务器的身份。***OpenSSL 可以自动执行所有这些检查，但必须为其提供某些信息才能执行此操作，即客户端信任的 CA 集以及该客户端尝试连接的服务器的 DNS 主机名***。
  * > Note that it is common for certificates to be built up into a chain. For example a server's certificate may be signed by a key owned by a an intermediate CA. That intermediate CA also has a certificate containing its public key which is in turn signed by a key owned by a root CA. The client may only trust the root CA, but if the server sends both its own certificate and the certificate for the intermediate CA then the client can still successfully verify the identity of the server. There is a chain of trust between the root CA and the server. 请注意，***将证书构建到链中是很常见的***。例如，服务器的证书可以由中间 CA 拥有的密钥进行签名。该中间 CA 还拥有一个包含其公钥的证书，该证书又由根 CA 拥有的密钥进行签名。***客户端可能只信任根 CA，但如果服务器同时发送自己的证书和中间 CA 的证书，则客户端仍然可以成功验证服务器的身份。根 CA 和服务器之间存在一条信任链​***​。
  * > By default it is only the client that authenticates the server using this method. However it is also possible to set things up such that the server additionally authenticates the client. This is known as `"client authentication"`. In this approach the client will still authenticate the server in the same way, but the server will request a certificate from the client. The client sends the server its certificate and the server authenticates it in the same way that the client does. ***默认情况下，只有客户端使用此方法对服务器进行身份验证。然而，也可以进行设置，以便服务器另外对客户端进行身份验证。这称为`“客户端身份验证”`***。在这种方法中，客户端仍将以相同的方式对服务器进行身份验证，但服务器将从客户端请求证书。客户端向服务器发送其证书，服务器以与客户端相同的方式对其进行身份验证。
- > **TRUSTED CERTIFICATE STORE 受信任的证书存储**
  * > The system described above only works if a chain of trust can be built between the set of CAs that the endpoint trusts and the certificate that the peer is using. The endpoint must therefore have a set of certificates for CAs that it trusts before any communication can take place. OpenSSL itself does not provide such a set of certificates. Therefore you will need to make sure you have them before you start if you are going to be verifying certificates (i.e. always if the endpoint is a client, and only if client authentication is in use for a server). 仅当可以在端点信任的 CA 组与对等方正在使用的证书之间建立信任链时，上述系统才能工作。***因此，在进行任何通信之前，端点必须拥有一组它信任的 CA 证书***。OpenSSL本身并不提供这样一组证书。因此，如果您要验证证书，则需要确保在开始之前拥有它们（即，如果端点是客户端，则始终如此，并且仅当服务器使用客户端身份验证时）。
  * > Fortunately other organisations do maintain such a set of certificates. If you have obtained your copy of OpenSSL from an Operating System (OS) vendor (e.g. a Linux distribution) then normally the set of CA certificates will also be distributed with that copy. ***幸运的是，其他组织确实维护着这样一组证书***。如果您从操作系统 (OS) 供应商（例如 Linux 发行版）获得了 OpenSSL 副本，那么通常 CA 证书集也会随该副本一起分发。
  * > You can check this by running the OpenSSL command line application like this: 您可以通过运行 OpenSSL 命令行应用程序来检查这一点，如下所示：
    ```sh
    openssl version -d
    ```
    ```sh
    $ openssl version -d
    OPENSSLDIR: "/opt/homebrew/etc/openssl@3"
    $ 
    $ ls /opt/homebrew/etc/openssl@3 
    cert.pem		certs			ct_log_list.cnf		ct_log_list.cnf.dist	misc			openssl.cnf		openssl.cnf.dist	private
    ```
  * > This will display a value for OPENSSLDIR. Look in the certs sub directory of OPENSSLDIR and check its contents. For example if OPENSSLDIR is "/usr/local/ssl", then check the contents of the "/usr/local/ssl/certs" directory. 这将显示 **`OPENSSSLDIR`** 的值。查看 **`OPENSSLDIR`** 的 **`certs`** 子目录并检查其内容。例如，如果 **`OPENSSLDIR`** 是 `“/usr/local/ssl”`，则检查 `“/usr/local/ssl/certs”` 目录的内容。
  * > You are expecting to see a list of files, typically with the suffix ".pem" or ".0". If they exist then you already have a suitable trusted certificate store. 您期望看到文件列表，**通常带有后缀 `“.pem”` 或 `“.0”`**。如果它们存在，那么您已经拥有合适的受信任证书存储。
  * > If you are running your version of OpenSSL on Windows then OpenSSL (from version 3.2 onwards) will use the default Windows set of trusted CAs. 如果您在 Windows 上运行 OpenSSL 版本，则 OpenSSL（从版本 `3.2` 开始）将使用默认的 Windows 受信任 CA 集。
  * > If you have built your version of OpenSSL from source, or obtained it from some other location and it does not have a set of trusted CA certificates then you will have to obtain them yourself. One such source is the Curl project. See the page https://curl.se/docs/caextract.html where you can download trusted certificates in a single file. Rename the file to "cert.pem" and store it directly in OPENSSLDIR. For example if OPENSSLDIR is "/usr/local/ssl", then save it as "/usr/local/ssl/cert.pem". ***如果您从源代码构建了 OpenSSL 版本，或者从其他位置获取了它，并且它没有一组受信任的 CA 证书，那么您必须自己获取它们***。Curl 项目就是这样的来源之一。请参阅页面 https://curl.se/docs/caextract.html ，您可以在其中下载单个文件中的受信任证书。将文件重命名为 `“cert.pem”` 并将其直接存储在 **`OPENSSLDIR`** 中。例如，如果 **`OPENSSLDIR`** 是 `“/usr/local/ssl”`，则将其保存为 `“/usr/local/ssl/cert.pem”`。
  * > You can also use `environment variables` to override the default location that OpenSSL will look for its trusted certificate store. Set the **`SSL_CERT_PATH`** environment variable to give the directory where OpenSSL should looks for its certificates or the **`SSL_CERT_FILE`** environment variable to give the name of a single file containing all of the certificates. See [openssl-env(7)]() for further details about OpenSSL environment variables. For example you could use this capability to have multiple versions of OpenSSL all installed on the same system using different values for OPENSSLDIR but all using the same trusted certificate store. 您还可以使用`环境变量`来覆盖 OpenSSL 将查找其受信任证书存储的默认位置。设置 **`SSL_CERT_PATH`** 环境变量以提供 OpenSSL 应在其中查找其证书的目录，或设置 **`SSL_CERT_FILE`** 环境变量以提供包含所有证书的单个文件的名称。有关 OpenSSL 环境变量的更多详细信息，请参阅 [openssl-env(7)]()。例如，***您可以使用此功能将 OpenSSL 的多个版本全部安装在同一系统上，使用不同的 `OPENSSSLDIR` 值，但全部使用相同的受信任证书存储***。
  * > You can test that your trusted certificate store is setup correctly by using it via the OpenSSL command line. Use the following command to connect to a TLS server: 您可以通过 OpenSSL 命令行使用受信任的证书存储来测试其设置是否正确。使用以下命令连接到 TLS 服务器：
    ```sh
    openssl s_client www.openssl.org:443
    ```
  * > Once the command has connected type the letter `"Q"` followed by `"<enter>"` to exit the session. This will print a lot of information on the screen about the connection. Look for a block of text like this: 命令连接后，键入字母 `“Q”`，后跟 `“<enter>”` 以退出会话。这将在屏幕上打印大量有关连接的信息。查找如下文本块：
    ```console
    SSL handshake has read 4584 bytes and written 403 bytes
    Verification: OK
    ```
  * > Hopefully if everything has worked then the "Verification" line will say "OK". If its not working as expected then you might see output like this instead: 希望如果一切正常，那么“验证”行会显示“确定”。如果它没有按预期工作，那么您可能会看到如下输出：
    ```console
    SSL handshake has read 4584 bytes and written 403 bytes
    Verification error: unable to get local issuer certificate
    ```
  * > The "unable to get local issuer certificate" error means that OpenSSL has been unable to find a trusted CA for the chain of certificates provided by the server in its trusted certificate store. Check your trusted certificate store configuration again. “无法获取本地颁发者证书”错误意味着 OpenSSL 无法在其受信任的证书存储中为服务器提供的证书链找到受信任的 CA。***再次检查您的受信任证书存储配置***。
  * > Note that s_client is a testing tool and will still allow you to connect to the TLS server regardless of the verification error. Most applications should not do this and should abort the connection in the event of a verification error. 请注意，***`s_client` 是一个测试工具，无论验证错误如何，仍然允许您连接到 TLS 服务器。<ins>大多数应用程序不应该这样做，并且应该在出现验证错误时中止连接</ins>***。
- > **IMPORTANT OBJECTS FOR AN OPENSSL TLS APPLICATION¶ OPENSSL TLS 应用程序的重要对象**
  * > A `TLS connection` is represented by the **`SSL object`** in an OpenSSL based application. Once a connection with a remote peer has been established an endpoint can "write" data to the SSL object to send data to the peer, or "read" data from it to receive data from the server. `TLS 连接`由基于 OpenSSL 的应用程序中的 **`SSL对象`** 表示。***一旦与远程对等点建立连接，端点就可以将数据“写入” SSL对象 以将数据发送到对等点，或从中“读取”数据以从服务器接收数据***。
  * > A new `SSL object` is created from an **`SSL_CTX`** object. Think of an **`SSL_CTX`** as a "factory" for creating `SSL objects`. You can create a single `SSL_CTX` object and then create multiple connections (i.e. `SSL objects`) from it. Typically you can set up common configuration options on the `SSL_CTX` so that all the `SSL object` created from it inherit the same configuration options. 从 **`SSL_CTX`** 对象创建一个新的 `SSL对象`。将 **`SSL_CTX`** 视为创建 `SSL对象` 的“工厂”。***您可以创建单个 `SSL_CTX` 对象，然后从中创建多个连接（即 `SSL对象`）***。通常，***您可以在 `SSL_CTX` 上设置通用配置选项，以便从它创建的所有 `SSL对象` 都继承相同的配置选项***。
  * > Note that internally to OpenSSL various items that are shared between multiple SSL objects are cached in the SSL_CTX for performance reasons. Therefore it is considered best practice to create one SSL_CTX for use by multiple SSL objects instead of having one SSL_CTX for each SSL object that you create. 请注意，***出于性能原因，在 OpenSSL 内部，多个 `SSL对象` 之间共享的各种项目都缓存在 `SSL_CTX` 中。因此，<ins>最好的做法是创建一个 `SSL_CTX` 以供多个 `SSL对象` 使用，而不是为您创建的每个 `SSL对象` 创建一个 `SSL_CTX`</ins>***。
  * > Each SSL object is also associated with two BIO objects. A BIO object is used for sending or receiving data from the underlying transport layer. For example you might create a BIO to represent a TCP socket. The SSL object uses one BIO for reading data and one BIO for writing data. In most cases you would use the same BIO for each direction but there could be some circumstances where you want them to be different. ***每个 `SSL对象` 还与 `两个BIO对象` 关联***。`BIO对象`用于从底层传输层发送或接收数据。例如，您可以创建一个`BIO`来表示 TCP 套接字。***`SSL对象`使用1个BIO来读取数据，使用1个BIO来写入数据。<ins>在大多数情况下，您会为每个方向使用相同的BIO，但在某些情况下您可能希望它们不同</ins>***。
  * > It is up to the application programmer to create the BIO objects that are needed and supply them to the SSL object. See [ossl-guide-tls-client-block(7)]() and [ossl-guide-tls-server-block(7)]() for usage examples. ***由应用程序程序员创建所需的 `BIO对象` 并将它们提供给 `SSL对象`***。有关使用示例，请参阅 [ossl-guide-tls-client-block(7)]() 和 [ossl-guide-tls-server-block(7)]()。
  * > Finally, an endpoint can establish a `"session"` with its peer. The session holds various TLS parameters about the connection between the client and the server. The session details can then be reused in a subsequent connection attempt to speed up the process of connecting. This is known as `"resumption"`. Sessions are represented in OpenSSL by the SSL_SESSION object. In TLSv1.2 there is always exactly one session per connection. In TLSv1.3 there can be any number per connection including none. 最后，***端点可以与其对等点建立`“会话”`。会话保存有关客户端和服务器之间连接的各种 TLS 参数。然后，可以在后续连接尝试中重用会话详细信息，以加快连接过程。这称为`“恢复”`***。会话在 OpenSSL 中由 **`SSL_SESSION`** 对象表示。***<ins>在 `TLSv1.2` 中，每个连接始终只有一个会话。在 `TLSv1.3` 中，每个连接可以有任意数量，包括没有</ins>***。
- > **PHASES OF A TLS CONNECTION¶ TLS 连接的阶段**
  * > A TLS connection starts with an initial "set up" phase. The endpoint creates the `SSL_CTX` (if one has not already been created) and configures it. ***TLS 连接从初始“设置”阶段开始。端点创建 `SSL_CTX`（如果尚未创建）并对其进行配置***。
  * > A client then creates an `SSL object` to represent the new `TLS connection`. Any connection specific configuration parameters are then applied and the underlying socket is created and associated with the SSL via `BIO objects`. ***然后，客户端创建一个`SSL对象`来表示新的 `TLS 连接`。然后应用任何连接特定的配置参数，并创建底层套接字并通过`BIO对象`与SSL关联***。
  * > A server will create a socket for listening for incoming connection attempts from clients. Once a connection attempt is made the server will create an `SSL object` in the same way as for a client and associate it with a `BIO` for the newly created incoming socket. ***服务器将创建一个套接字来侦听来自客户端的传入连接尝试。一旦尝试进行连接，服务器将以与客户端相同的方式创建`SSL对象`，并将其与新创建的传入套接字的`BIO`关联起来***。
  * > After set up is complete the `TLS "handshake" phase` begins. ***A TLS handshake consists of the client and server exchanging a series of TLS handshake messages to establish the connection***. The client starts by sending a `"ClientHello"` handshake message and the server responds with a `"ServerHello"`. The handshake is complete once an endpoint has sent its last message (known as the `"Finished"` message) and received a Finished message from its peer. ***Note that this might occur at slightly different times for each peer***. For example ***in `TLSv1.3` the server always sends its `Finished message` before the client***. The client later responds with its Finished message. ***<ins>At this point the client has completed the handshake because it has both sent and received a `Finished message`</ins>. The server has sent its Finished message but the Finished message from the client may still be in-flight, <ins>so the server is still in the handshake phase</ins>***. It is even possible that the server will fail to complete the handshake (if it considers there is some problem with the messages sent from the client), even though the client may have already progressed to sending application data. In `TLSv1.2` this can happen the other way around, i.e. the server finishes first and the client finishes second. 设置完成后，`TLS“握手”阶段`开始。***TLS 握手包括客户端和服务器交换一系列 TLS 握手消息以建立连接***。客户端首先发送`“ClientHello”`握手消息，服务器以`“ServerHello”`响应。一旦端点发送了最后一条消息（称为`“完成”`消息）并从其对等方收到完成消息，握手即完成。***请注意，每个对等点发生这种情况的时间可能略有不同***。例如，***在 `TLSv1.3` 中，服务器始终在客户端之前发送其 `Finished 消息`***。客户端随后用 Finished 消息进行响应。***<ins>此时客户端已完成握手，因为它已发送并接收了 `Finished 消息`</ins>。服务器已发送其 Finished 消息，但来自客户端的 Finished 消息可能仍在传输中，<ins>因此服务器仍处于握手阶段</ins>***。即使客户端可能已经开始发送应用程序数据，服务器甚至可能无法完成握手（如果它认为客户端发送的消息存在一些问题）。***在 `TLSv1.2` 中，这可能会以相反的方式发生，即服务器首先完成，客户端第二完成***。
  * > Once the handshake is complete the application data transfer phase begins. Strictly speaking there are some situations where the client can start sending application data even earlier (using the `TLSv1.3 "early data"` capability) - but we're going to skip over that for this basic introduction. ***握手完成后，应用程序数据传输阶段开始。<ins>严格来说，在某些情况下，客户端甚至可以更早地开始发送应用程序数据</ins>（使用 `TLSv1.3“早期数据”`功能） - 但我们将在基本介绍中跳过这一点***。
  * > During application data transfer the client and server can read and write data to the connection freely. The details of this are typically left to some higher level application protocol (for example `HTTP`). Not all information exchanged during this phase is application data. Some protocol level messages may still be exchanged - so it is not necessarily the case that, just because the underlying socket is "readable", that application data will be available to read. 在应用程序数据传输期间，客户端和服务器可以自由地向连接读取和写入数据。此细节通常留给某些更高级别的应用程序协议（例如 `HTTP`）。***并非在此阶段交换的所有信息都是应用程序数据***。某些协议级别的消息可能仍然会被交换 - 因此，***不一定是因为底层套接字是“可读的”，应用程序数据就可以读取***。
  * > When the connection is no longer required then it should be shutdown. A shutdown may be initiated by either the client or the server via a message known as a `"close_notify"` alert. The client or server that receives a `close_notify` may respond with `one` and then the connection is fully closed and application data can no longer be sent or received. ***当不再需要连接时，应将其关闭。关闭可以由客户端或服务器通过称为 `“close_notify”` 警报的消息发起。收到 `close_notify` 的客户端或服务器可能会响应 `1`，然后连接完全关闭，并且无法再发送或接收应用程序数据***。
  * > Once shutdown is complete a TLS application must clean up by freeing the `SSL object`. ***关闭完成后，TLS 应用程序必须通过释放 `SSL 对象`进行清理***。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-tls-client-block
>> 【[ :star: ][`*`]】 //notes：官方示例完整代码： https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-block.c

ossl-guide-tls-client-block https://docs.openssl.org/master/man7/ossl-guide-tls-client-block/
- > **SIMPLE BLOCKING TLS CLIENT EXAMPLE¶ 简单的阻止 TLS 客户端示例**
  * > This page will present various source code samples demonstrating how to write a simple `TLS client` application which connects to a server, sends an `HTTP/1.0 request` to it, and reads back the response. 本页将提供各种源代码示例，***演示如何编写一个简单的 `TLS 客户端`应用程序，该应用程序连接到服务器、向其发送 `HTTP/1.0 请求`并读回响应***。
  * > We use a `blocking socket` for the purposes of this example. This means that attempting to read data from a socket that has no data available on it to read will block (<ins>and the function will not return</ins>), until data becomes available. For example, this can happen if we have sent our request, but we are still waiting for the server's response. Similarly any attempts to write to a socket that is not able to write at the moment will block until writing is possible. 出于本示例的目的，我们使用`阻塞套接字`。***<ins>这意味着尝试从没有可用数据读取的套接字读取数据将被阻塞（并且该函数将不会返回），直到数据可用为止</ins>。例如，如果我们已经发送了请求，但仍在等待服务器的响应，则可能会发生这种情况。<ins>同样，任何对当前无法写入的套接字的写入尝试都将被阻塞，直到可以写入为止</ins>***。
  * > This blocking behaviour simplifies the implementation of a client because you do not have to worry about what happens if data is not yet available. The application will simply wait until it is available. ***这种阻塞行为简化了客户端的实现，因为您不必担心数据尚不可用时会发生什么***。该应用程序将简单地等待，直到它可用。
  * > The complete source code for this example blocking TLS client is available in the **`demos/guide`** directory of the OpenSSL source distribution in the file **`tls-client-block.c`**. It is also available online at https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-block.c . 此示例阻塞 TLS 客户端的完整源代码可在 OpenSSL 源代码分发的 **`demos/guide`** 目录中的 **`tls-client-block.c`** 文件中找到。也可在线获取 https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-block.c 。
  * > We assume that you already have OpenSSL installed on your system; that you already have some fundamental understanding of OpenSSL concepts and TLS (see [ossl-guide-libraries-introduction(7)]() and [ossl-guide-tls-introduction(7)]()); and that you know how to write and build C code and link it against the `libcrypto` and `libssl` libraries that are provided by OpenSSL. It also assumes that you have a basic understanding of `TCP/IP` and `sockets`. 我们假设您的系统上已经安装了 OpenSSL；您已经对 OpenSSL 概念和 TLS 有一些基本的了解（请参阅 [ossl-guide-libraries-introduction(7)]() 和 [ossl-guide-tls-introduction(7)]() ）；并且您知道如何编写和构建 C 代码并将其链接到 OpenSSL 提供的 `libcrypto` 和 `libssl` 库。它还假设您对 `TCP/IP` 和`套接字`有基本的了解。
  * > **Creating the `SSL_CTX` and `SSL objects`¶ 创建 `SSL_CTX` 和 `SSL 对象`**
    + > The first step is to create an `SSL_CTX` object for our client. We use the [`SSL_CTX_new`(3)]() function for this purpose. We could alternatively use SSL_CTX_new_ex(3) if we want to associate the SSL_CTX with a particular OSSL_LIB_CTX (see ossl-guide-libraries-introduction(7) to learn about OSSL_LIB_CTX). We pass as an argument the return value of the function TLS_client_method(3). You should use this method whenever you are writing a TLS client. This method will automatically use TLS version negotiation to select the highest version of the protocol that is mutually supported by both the client and the server. 第一步是为我们的客户端创建一个 **`SSL_CTX`** 对象。为此，我们使用 [`SSL_CTX_new`(3)]() 函数。***如果我们想将 `SSL_CTX` 与特定的 `OSSL_LIB_CTX` 关联起来，我们也可以使用 [`SSL_CTX_new_ex`(3)]()*** （请参阅 [ossl-guide-libraries-introduction(7)]() 了解 **`OSSL_LIB_CTX`** ）。***我们将函数 [`TLS_client_method`(3)]() 的返回值作为参数传递。每当您编写 `TLS 客户端`时都应该使用此方法。此方法将自动使用 TLS 版本协商来选择客户端和服务器相互支持的协议的最高版本***。
      ```c
      /*
       * Create an SSL_CTX which we can use to create SSL objects from. We
       * want an SSL_CTX for creating clients so we use TLS_client_method()
       * here.
       */
      ctx = SSL_CTX_new(TLS_client_method());
      if (ctx == NULL) {
          printf("Failed to create the SSL_CTX\n");
          goto end;
      }
      ```
    + > Since we are writing a client we must ensure that we verify the server's certificate. We do this by calling the SSL_CTX_set_verify(3) function and pass the SSL_VERIFY_PEER value to it. The final argument to this function is a callback that you can optionally supply to override the default handling for certificate verification. Most applications do not need to do this so this can safely be set to NULL to get the default handling. ***由于我们正在编写客户端，因此我们必须确保验证服务器的证书***。我们通过调用 [`SSL_CTX_set_verify`(3)]() 函数并将 **`SSL_VERIFY_PEER`** 值传递给它来完成此操作。***此函数的最后一个参数是一个回调，您可以选择提供该回调来覆盖证书验证的默认处理。大多数应用程序不需要这样做，因此可以安全地将其设置为 `NULL` 以获得默认处理***。
      ```c
      /*
       * Configure the client to abort the handshake if certificate
       * verification fails. Virtually all clients should do this unless you
       * really know what you are doing.
       */
      SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
      ```
    + > In order for certificate verification to be successful you must have configured where the trusted certificate store to be used is located (see ossl-guide-tls-introduction(7)). In most cases you just want to use the default store so we call SSL_CTX_set_default_verify_paths(3). ***为了使证书验证成功，您必须配置要使用的可信证书存储所在的位置***（请参阅 [ossl-guide-tls-introduction(7)]() ）。***在大多数情况下，您只想使用默认存储，因此我们调用 [`SSL_CTX_set_default_verify_paths`(3)]()***。
      ```c
      /* Use the default trusted certificate store */
      if (!SSL_CTX_set_default_verify_paths(ctx)) {
          printf("Failed to set the default trusted certificate store\n");
          goto end;
      }
      ```
    + > We would also like to restrict the TLS versions that we are willing to accept to TLSv1.2 or above. TLS protocol versions earlier than that are generally to be avoided where possible. We can do that using SSL_CTX_set_min_proto_version(3): ***我们还希望将愿意接受的 TLS 版本限制为 `TLSv1.2` 或更高版本。通常应尽可能避免使用早于该版本的 TLS 协议版本。我们可以使用 [`SSL_CTX_set_min_proto_version`(3)]() 来做到这一点***：
      ```c
      /*
       * TLSv1.1 or earlier are deprecated by IETF and are generally to be
       * avoided if possible. We require a minimum TLS version of TLSv1.2.
       */
      if (!SSL_CTX_set_min_proto_version(ctx, TLS1_2_VERSION)) {
          printf("Failed to set the minimum TLS protocol version\n");
          goto end;
      }
      ```
    + > That is all the setup that we need to do for the SSL_CTX, so next we need to create an SSL object to represent the TLS connection. In a real application we might expect to be creating more than one TLS connection over time. In that case we would expect to reuse the SSL_CTX that we already created each time. There is no need to repeat those steps. In fact it is best not to since certain internal resources are cached in the SSL_CTX. You will get better performance by reusing an existing SSL_CTX instead of creating a new one each time. ***这就是我们需要对 `SSL_CTX` 进行的所有设置，<ins>因此接下来我们需要创建一个 `SSL对象` 来表示 `TLS 连接`</ins>***。在实际应用程序中，***我们可能希望随着时间的推移创建多个 `TLS 连接`。在这种情况下，<ins>我们希望重用每次已经创建的 `SSL_CTX`</ins>***。无需重复这些步骤。事实上，最好不要这样做，***因为某些内部资源缓存在 `SSL_CTX` 中。通过重用现有的 `SSL_CTX` 而不是每次创建一个新的 `SSL_CTX`，您将获得更好的性能***。
    + > Creating the SSL object is a simple matter of calling the SSL_new(3) function and passing the SSL_CTX we created as an argument. ***创建`SSL对象`很简单，只需调用 [`SSL_new`(3)]() 函数并将我们创建的 `SSL_CTX` 作为参数传递即可***。
      ```c
      /* Create an SSL object to represent the TLS connection */
      ssl = SSL_new(ctx);
      if (ssl == NULL) {
          printf("Failed to create the SSL object\n");
          goto end;
      }
      ```
  * > **Creating the `socket` and `BIO`¶ 创建`套接字`和 `BIO`**
    + > Once the `socket` has been created and connected we need to associate it with a `BIO object`: ***创建并连接`套接字`后，我们需要将其与 `BIO 对象`关联***：
      ```c
      BIO *bio;

      /* Create a BIO to wrap the socket */
      bio = BIO_new(BIO_s_socket());
      if (bio == NULL) {
          BIO_closesocket(sock);
          return NULL;
      }

      /*
       * Associate the newly created BIO with the underlying socket. By
       * passing BIO_CLOSE here the socket will be automatically closed when
       * the BIO is freed. Alternatively you can use BIO_NOCLOSE, in which
       * case you must close the socket explicitly when it is no longer
       * needed.
       */
      BIO_set_fd(bio, sock, BIO_CLOSE);
      ```
    + > Finally we associate the SSL object we created earlier with the BIO using the SSL_set_bio(3) function. Note that this passes ownership of the BIO object to the SSL object. Once ownership is passed the SSL object is responsible for its management and will free it automatically when the SSL is freed. So, once SSL_set_bio(3) has been been called, you should not call BIO_free(3) on the BIO. 最后，***我们使用 [SSL_set_bio(3)]() 函数将之前创建的 `SSL对象` 与 `BIO` 关联起来***。请注意，***这会将 `BIO对象` 的所有权传递给 `SSL对象`。一旦所有权被传递，`SSL 对象`就负责对其管理，并在释放 `SSL` 时自动释放它。因此，<ins>一旦调用了 [SSL_set_bio(3)]() ，您就不应该在 `BIO` 上调用 [BIO_free(3)]()</ins>***。
      ```c
      SSL_set_bio(ssl, bio, bio);
      ```
  * > **Setting the server's hostname¶ 设置服务器的主机名**
    + > We have already connected our underlying socket to the server, but the client still needs to know the server's hostname. It uses this information for 2 key purposes and we need to set the hostname for each one. 我们已经将底层套接字连接到服务器，但客户端仍然需要知道服务器的主机名。它将此信息用于两个关键目的，我们需要为每个目的设置主机名。
    + > Firstly, the server's hostname is included in the initial `ClientHello` message sent by the client. This is known as the `Server Name Indication` (`SNI`). ***This is important because it is common for multiple hostnames to be fronted by a single server that handles requests for all of them. In other words a single server may have multiple hostnames associated with it and it is important to indicate which one we want to connect to***. Without this information we may get a handshake failure, or we may get connected to the "default" server which may not be the one we were expecting. 首先，服务器的主机名包含在客户端发送的初始 `ClientHello` 消息中。这称为`服务器名称指示` (`SNI`)。这很重要，***因为多个主机名通常由一个服务器处理所有主机名的请求。换句话说，<ins>一台服务器可能有多个与之关联的主机名</ins>，并且指示我们要连​​接到哪一个主机名非常重要***。如果没有这些信息，我们可能会出现握手失败，或者我们可能会连接到“默认”服务器，而该服务器可能不是我们期望的服务器。
    + > All of the above steps must happen before we attempt to perform the handshake otherwise they will have no effect. ***上述所有步骤都必须在我们尝试执行握手之前进行，否则它们将不起作用***。
  * > **Performing the handshake¶ 执行握手**
    + > Before we can start sending or receiving application data over a TLS connection the TLS handshake must be performed. We can do this explicitly via the [SSL_connect(3)]() function. ***在我们开始通过 TLS 连接发送或接收应用程序数据之前，必须执行 TLS 握手***。我们可以通过 [SSL_connect(3)]() 函数显式地执行此操作。
      ```c
      /* Do the handshake with the server */
      if (SSL_connect(ssl) < 1) {
          printf("Failed to connect to the server\n");
          /*
           * If the failure is due to a verification error we can get more
           * information about it from SSL_get_verify_result().
           */
          if (SSL_get_verify_result(ssl) != X509_V_OK)
              printf("Verify error: %s\n",
                  X509_verify_cert_error_string(SSL_get_verify_result(ssl)));
          goto end;
      }
      ```
    + > The SSL_connect(3) function can return 1, 0 or less than 0. Only a return value of 1 is considered a success. For a simple blocking client we only need to concern ourselves with whether the call was successful or not. Anything else indicates that we have failed to connect to the server. [SSL_connect(3)]() 函数可以返回 `1`、`0` 或`小于 0`。***只有返回值 `1` 才被视为成功。对于简单的阻塞客户端，我们只需要关心调用是否成功。其他任何情况都表明我们无法连接到服务器***。
    + > A common cause of failures at this stage is due to a problem verifying the server's certificate. For example if the certificate has expired, or it is not signed by a CA in our trusted certificate store. We can use the SSL_get_verify_result(3) function to find out more information about the verification failure. A return value of X509_V_OK indicates that the verification was successful (so the connection error must be due to some other cause). Otherwise we use the X509_verify_cert_error_string(3) function to get a human readable error message. ***此阶段失败的常见原因是验证服务器证书时出现问题***。例如，如果证书已过期，或者未由我们可信证书存储中的 CA 签名。我们可以使用 [SSL_get_verify_result(3)]() 函数来查找有关验证失败的更多信息。返回值 **`X509_V_OK`** 表明验证成功（***因此连接错误肯定是由于其他原因造成的***）。否则，我们使用 [X509_verify_cert_error_string(3)]() 函数来获取人类可读的错误消息。
  * > **Sending and receiving data¶ 发送和接收数据**
    + > To send data to the server we use the SSL_write_ex(3) function and to receive data from the server we use the SSL_read_ex(3) function. In HTTP 1.0 the client always writes data first. Our HTTP request will include the hostname that we are connecting to. For simplicity, we write the HTTP request in three chunks. First we write the start of the request. Secondly we write the hostname we are sending the request to. Finally we send the end of the request. ***要将数据发送到服务器，我们使用 [SSL_write_ex(3)]() 函数；要从服务器接收数据，我们使用 [SSL_read_ex(3)]() 函数。在 `HTTP 1.0` 中，客户端总是先写入数据***。我们的 HTTP 请求将包含我们要连接的主机名。为简单起见，我们将 HTTP 请求分为三个块。首先我们写下请求的开头。其次，我们写入要发送请求的主机名。最后我们发送请求结束。
      ```c
      size_t written;
      const char *request_start = "GET / HTTP/1.0\r\nConnection: close\r\nHost: ";
      const char *request_end = "\r\n\r\n";

      /* Write an HTTP GET request to the peer */
      if (!SSL_write_ex(ssl, request_start, strlen(request_start), &written)) {
          printf("Failed to write start of HTTP request\n");
          goto end;
      }
      if (!SSL_write_ex(ssl, hostname, strlen(hostname), &written)) {
          printf("Failed to write hostname in HTTP request\n");
          goto end;
      }
      if (!SSL_write_ex(ssl, request_end, strlen(request_end), &written)) {
          printf("Failed to write end of HTTP request\n");
          goto end;
      }
      ```
    + > The SSL_write_ex(3) function returns 0 if it fails and 1 if it is successful. If it is successful then we can proceed to waiting for a response from the server. ***如果失败，[SSL_write_ex(3)]() 函数返回 `0`；如果成功，则返回 `1`。如果成功，那么我们可以继续等待服务器的响应***。
      ```c
      size_t readbytes;
      char buf[160];

      /*
       * Get up to sizeof(buf) bytes of the response. We keep reading until the
       * server closes the connection.
       */
      while (SSL_read_ex(ssl, buf, sizeof(buf), &readbytes)) {
          /*
          * OpenSSL does not guarantee that the returned data is a string or
          * that it is NUL terminated so we use fwrite() to write the exact
          * number of bytes that we read. The data could be non-printable or
          * have NUL characters in the middle of it. For this simple example
          * we're going to print it to stdout anyway.
          */
          fwrite(buf, 1, readbytes, stdout);
      }
      /* In case the response didn't finish with a newline we add one now */
      printf("\n");
      ```
    + > We use the SSL_read_ex(3) function to read the response. We don't know exactly how much data we are going to receive back so we enter a loop reading blocks of data from the server and printing each block that we receive to the screen. The loop ends as soon as SSL_read_ex(3) returns 0 - meaning that it failed to read any data. 我们使用 [SSL_read_ex(3)]() 函数来读取响应。***我们不确切知道将接收回多少数据，因此我们进入一个循环***，从服务器读取数据块并将接收到的每个数据块打印到屏幕上。***一旦 [SSL_read_ex(3)]() 返回 `0`，循环就会结束 - 这意味着它无法读取任何数据***。
    + > A failure to read data could mean that there has been some error, or it could simply mean that server has sent all the data that it wants to send and has indicated that it has finished by sending a `"close_notify"` alert. This alert is a TLS protocol level message indicating that the endpoint has finished sending all of its data and it will not send any more. Both of these conditions result in a `0` return value from [SSL_read_ex(3)]() and we need to use the function [SSL_get_error(3)]() to determine the cause of the 0 return value. ***<ins>读取数据失败可能意味着出现了一些错误，或者可能只是意味着服务器已发送了它想要发送的所有数据，并通过发送 `“close_notify”` 警报表明它已完成</ins>。此警报是一条 TLS 协议级别消息，指示端点已完成发送所有数据，并且不会再发送。这两种情况都会导致 [SSL_read_ex(3)]() 返回 `0` 值，我们需要使用函数 [SSL_get_error(3]() 来确定返回值 `0` 的原因***。
  * > **Shutting down the connection¶ 关闭连接**
    + > Once we have finished reading data from the server then we are ready to close the connection down. We do this via the SSL_shutdown(3) function which has the effect of sending a TLS protocol level message (a `"close_notify" alert`) to the server saying that we have finished writing data: ***一旦我们完成从服务器读取数据，就准备关闭连接。我们通过 [SSL_shutdown(3)]() 函数执行此操作***，该函数的作用是向服务器发送一条 TLS 协议级消息（`“close_notify”警报`），表明我们已完成数据写入：
      ```c
      /*
       * The peer already shutdown gracefully (we know this because of the
       * SSL_ERROR_ZERO_RETURN above). We should do the same back.
       */
      ret = SSL_shutdown(ssl);
      if (ret < 1) {
          /*
           * ret < 0 indicates an error. ret == 0 would be unexpected here
           * because that means "we've sent a close_notify and we're waiting
           * for one back". But we already know we got one from the peer
           * because of the SSL_ERROR_ZERO_RETURN above.
           */
          printf("Error shutting down\n");
          goto end;
      }
      ```
    + > The SSL_shutdown(3) function will either return 1, 0, or less than 0. A return value of 1 is a success, and a return value less than 0 is an error. More precisely a return value of 1 means that we have sent a "close_notify" alert to the server, and that we have also received one back. A return value of 0 means that we have sent a "close_notify" alert to the server, but we have not yet received one back. Usually in this scenario you would call SSL_shutdown(3) again which (with a blocking socket) would block until the "close_notify" is received. However in this case we already know that the server has sent us a "close_notify" because of the SSL_ERROR_ZERO_RETURN that we received from the call to SSL_read_ex(3). So this scenario should never happen in practice. We just treat it as an error in this example. [SSL_shutdown(3)]() 函数将返回 `1`、`0` 或`小于 0`。返回值 `1` 表示成功，返回值小于 `0` 表示错误。***更准确地说，返回值 `1` 意味着我们已向服务器发送了`“close_notify”`警报，并且我们也收到了返回值。返回值 0 表示我们已向服务器发送了`“close_notify”`警报，但尚未收到回复***。通常在这种情况下，您会再次调用 [SSL_shutdown(3)]()，该调用（使用阻塞套接字）将阻塞，直到收到`“close_notify”`为止。然而，在这种情况下，我们已经知道服务器已向我们发送了`“close_notify”`，因为我们从 [SSL_read_ex(3)]() 调用中收到了 **`SSL_ERROR_ZERO_RETURN`**。所以这种情况在实践中绝对不应该发生。在本例中我们只是将其视为错误。
  * > **Final clean up¶ 最后清理**
    + > Before the application exits we have to clean up some memory that we allocated. If we are exiting due to an error we might also want to display further information about that error if it is available to the user: ***在应用程序退出之前，我们必须清理我们分配的一些内存***。如果我们由于错误而退出，我们可能还想显示有关该错误的更多信息（如果用户可以使用）：
      ```c
         /* Success! */
         res = EXIT_SUCCESS;
      end:
         /*
          * If something bad happened then we will dump the contents of the
          * OpenSSL error stack to stderr. There might be some useful diagnostic
          * information there.
          */
         if (res == EXIT_FAILURE)
             ERR_print_errors_fp(stderr);

         /*
          * Free the resources we allocated. We do not free the BIO object here
          * because ownership of it was immediately transferred to the SSL object
          * via SSL_set_bio(). The BIO will be freed when we free the SSL object.
          */
         SSL_free(ssl);
         SSL_CTX_free(ctx);
         return res;
      ```
    + > To display errors we make use of the ERR_print_errors_fp(3) function which simply dumps out the contents of any errors on the OpenSSL error stack to the specified location (in this case `stderr`). 为了显示错误，我们使用 [ERR_print_errors_fp(3)]() 函数，***该函数只需将 OpenSSL 错误堆栈上的任何错误内容转储到指定位置***（在本例中为`stderr`）。
    + > We need to free up the **`SSL`** object that we created for the connection via the [SSL_free(3)]() function. Also, since we are not going to be creating any more `TLS connections` we must also free up the **`SSL_CTX`** via a call to [SSL_CTX_free(3)](). 我们需要通过 [SSL_free(3)]() 函数释放为连接创建的 **`SSL对象`**。另外，由于我们不会再创建任何 `TLS 连接`，因此我们还必须通过调用 [SSL_CTX_free(3)]() 来释放 **`SSL_CTX`** 。
- > **TROUBLESHOOTING¶ 故障排除**
  * > **Failure to connect the underlying socket¶ 连接底层套接字失败**
  * > **Verification failure of the server certificate¶ 服务器证书验证失败**
    + > A server certificate verification failure could be caused for a number of reasons. For example 服务器证书验证失败可能由多种原因引起。例如
    + > Failure to correctly setup the trusted certificate store 无法正确设置受信任的证书存储
    + > Unrecognised CA 无法识别的 CA
    + > Missing intermediate CAs 缺少中间 CAs
    + > Mismatched hostname 主机名不匹配
    + > Expired certificate 证书过期

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-tls-client-non-block
>> 【[ :star: ][`*`]】 //notes：官方示例完整代码： https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-non-block.c

ossl-guide-tls-client-non-block https://docs.openssl.org/master/man7/ossl-guide-tls-client-non-block/
- > **SIMPLE NONBLOCKING TLS CLIENT EXAMPLE¶ 简单的非阻塞 TLS 客户端示例**
  * > This page will build on the example developed on the [ossl-guide-tls-client-block(7)]() page which demonstrates how to write a simple blocking TLS client. On this page we will amend that demo code so that it supports a `nonblocking socket`. 本页面将基于 [ossl-guide-tls-client-block(7)]() 页面上开发的示例构建，该示例演示了如何编写简单的阻塞 TLS 客户端。***在此页面上，我们将修改该演示代码，以便它支持`非阻塞套接字`***。
  * > The complete source code for this example nonblocking TLS client is available in the **`demos/guide`** directory of the OpenSSL source distribution in the file **`tls-client-non-block.c`**. It is also available online at https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-non-block.c . 此示例非阻塞 TLS 客户端的完整源代码可在 OpenSSL 源代码分发的 **`demos/guide`** 目录中的 **`tls-client-non-block.c`** 文件中找到。也可在线获取 https://github.com/openssl/openssl/blob/master/demos/guide/tls-client-non-block.c 。
  * > As we saw in the previous example a `blocking socket` is one which waits (blocks) until data is available to read if you attempt to read from it when there is no data yet. Similarly it waits when writing if the socket is currently unable to write at the moment. This can simplify the development of code because you do not have to worry about what to do in these cases. The execution of the code will simply stop until it is able to continue. However in many cases you do not want this behaviour. Rather than stopping and waiting your application may need to go and do other tasks whilst the socket is unable to read/write, for example updating a GUI or performing operations on some other socket. ***正如我们在上一个示例中看到的那样，如果您在还没有数据时尝试从中读取数据，则`阻塞套接字`会等待（阻塞）直到有数据可供读取。同样，如果套接字当前无法写入，则写入时会等待***。这可以简化代码的开发，因为您不必担心在这些情况下该怎么做。代码的执行将停止，直到能够继续。***然而，在许多情况下，您不希望出现这种行为。当套接字无法读/写时，您的应用程序可能需要去执行其他任务，例如更新 GUI 或在其他套接字上执行操作，而不是停止和等待***。
  * > With a `nonblocking socket` attempting to read or write to a socket that is currently unable to read or write will return immediately with a non-fatal error. Although OpenSSL does the reading/writing to the socket this nonblocking behaviour is propagated up to the application so that OpenSSL I/O functions such as [SSL_read_ex(3)]() or [SSL_write_ex(3)]() will not block. ***对于`非阻塞套接字`，尝试读取或写入当前无法读取或写入的套接字将立即返回，并出现非致命错误***。尽管 OpenSSL 对套接字进行读/写操作，***但这种非阻塞行为会传播到应用程序，以便 OpenSSL I/O 函数（例如 [SSL_read_ex(3)]() 或 [SSL_write_ex(3)]()）不会阻塞***。
  * > Since this page is building on the example developed on the [ossl-guide-tls-client-block(7)]() page we assume that you are familiar with it and we only explain how this example differs. 由于此页面是基于 [ossl-guide-tls-client-block(7)]()页面上开发的示例构建的，因此我们假设您熟悉它，我们仅解释此示例的不同之处。
  * > **Setting the socket to be nonblocking¶ 将套接字设置为非阻塞**
    + > The first step in writing an application that supports nonblocking is to set the socket into `nonblocking mode`. A socket will be default be `blocking`. The exact details on how to do this can differ from one platform to another. Fortunately OpenSSL offers a portable function that will do this for you: ***编写支持非阻塞的应用程序的第一步是将套接字设置为`非阻塞模式`。<ins>套接字默认是`阻塞的`</ins>***。不同平台的具体操作细节可能有所不同。幸运的是，OpenSSL 提供了一个可移植的函数，可以为您执行此操作：
      ```c
      /* Set to nonblocking mode */
      if (!BIO_socket_nbio(sock, 1)) {
          sock = -1;
          continue;
      }
      ```
  * > **Performing work while waiting for the socket¶ 等待套接字时执行工作**
    + > In a `nonblocking` application you will need work to perform in the event that we want to read or write to the socket, but we are currently unable to. In fact this is the whole point of using a `nonblocking socket`, i.e. to give the application the opportunity to do something else. Whatever it is that the application has to do, it must also be prepared to come back and retry the operation that it previously attempted periodically to see if it can now complete. Ideally it would only do this in the event that the state of the underlying socket has actually changed (e.g. become readable where it wasn't before), but this does not have to be the case. It can retry at any time. ***在`非阻塞`应用程序中，如果我们想要读取或写入套接字，但目前无法执行，则需要执行一些工作。事实上，这就是使用`非阻塞套接字`的全部意义，即为应用程序提供执行其他操作的机会***。无论应用程序必须做什么，它还必须准备好返回并定期重试之前尝试的操作，以查看现在是否可以完成。***理想情况下，它只会在底层套接字的状态实际上发生变化的情况下执行此操作（例如，以前不可读的地方变得可读），但情况并非必须如此。它可以随时重试***。
    + > ***Note that it is important that you retry exactly the same operation that you tried last time***. You cannot start something new. For example ***if you were attempting to write the text "Hello World" and the operation failed because the socket is currently unable to write, then you cannot then attempt to write some other text when you retry the operation***. 请注意，重试与上次尝试完全相同的操作非常重要。你无法开始新的事情。例如，***如果您尝试写入文本“Hello World”，但由于套接字当前无法写入而操作失败，那么当您重试该操作时，您将无法尝试写入其他文本***。
    + > In this demo application we will create a helper function which simulates doing other work. In fact, for the sake of simplicity, it will do nothing except wait for the state of the socket to change. 在此演示应用程序中，我们将创建一个模拟执行其他工作的辅助函数。事实上，为了简单起见，它除了等待套接字状态改变之外什么也不做。
    + > We call our function wait_for_activity() because all it does is wait until the underlying socket has become readable or writeable when it wasn't before. 我们将函数称为 `wait_for_activity()` 因为它所做的只是等待底层套接字变得可读或可写（而之前不是这样）。
      ```c
      static void wait_for_activity(SSL *ssl, int write)
      {
          fd_set fds;
          int width, sock;

          /* Get hold of the underlying file descriptor for the socket */
          sock = SSL_get_fd(ssl);

          FD_ZERO(&fds);
          FD_SET(sock, &fds);
          width = sock + 1;

          /*
           * Wait until the socket is writeable or readable. We use select here
           * for the sake of simplicity and portability, but you could equally use
           * poll/epoll or similar functions
           *
           * NOTE: For the purposes of this demonstration code this effectively
           * makes this demo block until it has something more useful to do. In a
           * real application you probably want to go and do other work here (e.g.
           * update a GUI, or service other connections).
           *
           * Let's say for example that you want to update the progress counter on
           * a GUI every 100ms. One way to do that would be to add a 100ms timeout
           * in the last parameter to "select" below. Then, when select returns,
           * you check if it did so because of activity on the file descriptors or
           * because of the timeout. If it is due to the timeout then update the
           * GUI and then restart the "select".
           */
          if (write)
              select(width, NULL, &fds, NULL, NULL);
          else
              select(width, &fds, NULL, NULL, NULL);
      }
      ```
    + > In this example we are using the `select` function because it is very simple to use and is available on most Operating Systems. However you could use any other similar function to do the same thing. `select` waits for the state of the underlying socket(s) to become readable/writeable before returning. It also supports a "timeout" (as do most other similar functions) so in your own applications you can make use of this to periodically wake up and perform work while waiting for the socket state to change. But we don't use that timeout capability in this example for the sake of simplicity. 在本例中，我们使用 `select` 函数，因为它使用起来非常简单，并且在大多数操作系统上都可用。但是，您可以使用任何其他类似的函数来执行相同的操作。`select` 在返回之前等待底层套接字的状态变为可读/可写。它还支持“超时”（与大多数其他类似功能一样），因此在您自己的应用程序中，您可以利用它来定期唤醒并在等待套接字状态更改时执行工作。但为了简单起见，我们在本示例中没有使用超时功能。
  * > **Handling errors from OpenSSL I/O functions¶ 处理来自 OpenSSL I/O 函数的错误**
    + > SSL_read_ex(3) and SSL_write_ex(3) will return 0 to indicate an error and SSL_read(3) and SSL_write(3) will return 0 or a negative value to indicate an error. SSL_shutdown(3) will return a negative value to incidate an error. [SSL_read_ex(3)]() 和 [SSL_write_ex(3)]() 将返回 `0` 来指示错误，[SSL_read(3)]() 和 [SSL_write(3)]() 将返回 `0` 或`负值`来指示错误。[SSL_shutdown(3)]() 将返回`负值`以指示错误。
  * > **Creating the SSL_CTX and SSL objects¶ 创建 SSL_CTX 和 SSL 对象**
    + > In order to connect to a server we must create SSL_CTX and SSL objects for this. The steps do this are the same as for a blocking client and are explained on the ossl-guide-tls-client-block(7) page. We won't repeat that information here. 为了连接到服务器，我们必须为此创建 `SSL_CTX` 和 `SSL对象`。***执行此操作的步骤与阻塞客户端相同，并在 [ossl-guide-tls-client-block(7)]() 页面上进行了说明。我们不会在这里重复该信息***。
  * > **Performing the handshake¶ 执行握手**
    + > As in the demo for a blocking TLS client we use the SSL_connect(3) function to perform the TLS handshake with the server. Since we are using a `nonblocking socket` it is very likely that calls to this function will fail with a non-fatal error while we are waiting for the server to respond to our handshake messages. In such a case we must retry the same SSL_connect(3) call at a later time. In this demo we this in a loop: 正如在阻塞 TLS 客户端的演示中一样，我们使用 [SSL_connect(3)]() 函数与服务器执行 TLS 握手。由于我们使用的是`非阻塞套接字`，因此在等待服务器响应握手消息时，对此函数的调用很可能会失败并出现非致命错误。在这种情况下，我们必须稍后重试相同的 [SSL_connect(3)]() 调用。在这个演示中，我们循环执行：
      ```c
      /* Do the handshake with the server */
      while ((ret = SSL_connect(ssl)) != 1) {
          if (handle_io_failure(ssl, ret) == 1)
              continue; /* Retry */
          printf("Failed to connect to server\n");
          goto end; /* Cannot retry: error */
      }
      ```
    + > We continually call SSL_connect(3) until it gives us a success response. Otherwise we use the handle_io_failure() function that we created earlier to work out what we should do next. Note that we do not expect an EOF to occur at this stage, so such a response is treated in the same way as a fatal error. 我们不断调用 [SSL_connect(3)]() 直到它给我们一个成功响应。否则，我们使用之前创建的 `handle_io_failure()` 函数来确定下一步应该做什么。请注意，我们不希望在此阶段发生 EOF，因此此类响应将被视为致命错误。
  * > **Sending and receiving data¶ 发送和接收数据**
    + > As with the blocking TLS client demo we use the SSL_write_ex(3) function to send data to the server. As with SSL_connect(3) above, because we are using a `nonblocking socket`, this call could fail with a non-fatal error. In that case we should retry exactly the same SSL_write_ex(3) call again. Note that the parameters must be exactly the same, i.e. the same pointer to the buffer to write with the same length. You must not attempt to send different data on a retry. An optional mode does exist (**`SSL_MODE_ACCEPT_MOVING_WRITE_BUFFER`**) which will configure OpenSSL to allow the buffer being written to change from one retry to the next. However, in this case, you must still retry exactly the same data - even though the buffer that contains that data may change location. See SSL_CTX_set_mode(3) for further details. As in the TLS client blocking tutorial (ossl-guide-tls-client-block(7)) we write the request in three chunks. 与阻塞 TLS 客户端演示一样，我们使用 [SSL_write_ex(3)]() 函数将数据发送到服务器。与上面的 [SSL_connect(3)]() 一样，***因为我们使用`非阻塞套接字`，所以此调用可能会失败并出现非致命错误***。在这种情况下，我们应该再次重试完全相同的 [SSL_write_ex(3)]() 调用。***注意，参数必须完全相同，即指向要写入的缓冲区的相同指针，具有相同的长度。您不得尝试在重试时发送不同的数据***。确实存在一种可选模式（ **`SSL_MODE_ACCEPT_MOVING_WRITE_BUFFER`** ），它将配置 OpenSSL 以允许写入的缓冲区从一次重试更改为下一次重试。但是，在这种情况下，您仍然必须重试完全相同的数据 - 即使包含该数据的缓冲区可能会更改位置。有关更多详细信息，请参阅 [SSL_CTX_set_mode(3)]()。正如 TLS 客户端阻止教程 ( [ossl-guide-tls-client-block(7)]() ) 中一样，我们将请求分为三个块。
  * > **Shutting down the connection¶ 关闭连接**
  * > **Final clean up¶ 最后清理**
    + > As with the blocking TLS client example, once our connection is finished with we must free it. The steps to do this for this example are the same as for the blocking example, so we won't repeat it here. 与阻塞 TLS 客户端示例一样，一旦连接完成，我们必须释放它。***此示例的执行步骤与阻塞示例相同，因此我们在此不再重复***。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-tls-server-block
>> 【[ :star: ][`*`]】 //notes：官方示例完整代码： https://github.com/openssl/openssl/blob/master/demos/guide/tls-server-block.c

ossl-guide-tls-server-block https://docs.openssl.org/master/man7/ossl-guide-tls-server-block/
- > **SIMPLE BLOCKING TLS SERVER EXAMPLE¶ 简单的阻止 TLS 服务器示例**
  * > This page will present various source code samples demonstrating how to write a simple, non-concurrent, TLS "echo" server application which accepts one client connection at a time, echoing input from the client back to the same client. Once the current client disconnects, the next client connection is accepted. ***本页将展示各种源代码示例，演示如何编写一个简单的、非并发的 TLS“回显”服务器应用程序，该应用程序一次接受一个客户端连接，将客户端的输入回显到同一客户端。一旦当前客户端断开连接，就会接受下一个客户端连接***。
  * > Both the `acceptor socket` and `client connections` are "blocking". A more typical server might use nonblocking sockets with an event loop and callbacks for I/O events. `接受器套接字`和`客户端连接`都是“阻塞”的。更典型的服务器可能会使用带有事件循环和 I/O 事件回调的非阻塞套接字。
  * > The complete source code for this example blocking TLS server is available in the **`demos/guide`** directory of the OpenSSL source distribution in the file **`tls-server-block.c`**. It is also available online at https://github.com/openssl/openssl/blob/master/demos/guide/tls-server-block.c . 此示例阻止 TLS 服务器的完整源代码可在 OpenSSL 源代码分发的 **`demos/guide`** 目录中的 **`tls-server-block.c`** 文件中找到。也可在线获取 https://github.com/openssl/openssl/blob/master/demos/guide/tls-server-block.c 。
  * > **Creating the SSL_CTX and SSL objects¶ 创建 SSL_CTX 和 SSL 对象**
    + > The first step is to create an SSL_CTX object for our server. We use the SSL_CTX_new(3) function for this purpose. We could alternatively use SSL_CTX_new_ex(3) if we want to associate the SSL_CTX with a particular OSSL_LIB_CTX (see ossl-guide-libraries-introduction(7) to learn about OSSL_LIB_CTX). We pass as an argument the return value of the function TLS_server_method(3). You should use this method whenever you are writing a TLS server. This method will automatically use TLS version negotiation to select the highest version of the protocol that is mutually supported by both the server and the client. 第一步是为我们的服务器创建一个 **`SSL_CTX`** 对象。为此，我们使用 [SSL_CTX_new(3)]() 函数。如果我们想将 **`SSL_CTX`** 与特定的 **`OSSL_LIB_CTX`** 关联起来，我们也可以使用 [SSL_CTX_new_ex(3)]() （请参阅 [ossl-guide-libraries-introduction(7)]() 了解 **`OSSL_LIB_CTX`** ）。我们将函数 [`TLS_server_method`(3)]() 的返回值作为参数传递。***每当您编写 TLS 服务器时都应该使用此方法。该方法会自动使用TLS版本协商来选择服务器和客户端相互支持的最高协议版本***。
      ```c
      /*
       * An SSL_CTX holds shared configuration information for multiple
       * subsequent per-client SSL connections.
       */
      ctx = SSL_CTX_new(TLS_server_method());
      if (ctx == NULL) {
          ERR_print_errors_fp(stderr);
          errx(res, "Failed to create server SSL_CTX");
      }
      ```
    + > We would also like to restrict the TLS versions that we are willing to accept to TLSv1.2 or above. TLS protocol versions earlier than that are generally to be avoided where possible. We can do that using SSL_CTX_set_min_proto_version(3): 我们还希望将愿意接受的 TLS 版本限制为 `TLSv1.2` 或更高版本。通常应尽可能避免使用早于该版本的 TLS 协议版本。我们可以使用 [SSL_CTX_set_min_proto_version(3)]() 来做到这一点：
      ```c
      /*
       * TLS versions older than TLS 1.2 are deprecated by IETF and SHOULD
       * be avoided if possible.
       */
      if (!SSL_CTX_set_min_proto_version(ctx, TLS1_2_VERSION)) {
          SSL_CTX_free(ctx);
          ERR_print_errors_fp(stderr);
          errx(res, "Failed to set the minimum TLS protocol version");
      }
      ```
    + > Next we configure some option flags, see SSL_CTX_set_options(3) for details: 接下来我们配置一些选项标志，详细信息请参见 [SSL_CTX_set_options(3)]()：
    + > Servers need a private key and certificate. Though `anonymous ciphers` (no server certificate) are possible in TLS 1.2, they are rarely applicable, and are not currently defined for TLS 1.3. Additional intermediate issuer CA certificates are often also required, and both the server (end-entity or EE) certificate and the issuer ("chain") certificates are most easily configured in a single "chain file". Below we load such a chain file (the EE certificate must appear first), and then load the corresponding private key, checking that it matches the server certificate. No checks are performed to check the integrity of the chain (CA signatures or certificate expiration dates, for example). ***服务器需要私钥和证书。尽管 `TLS 1.2` 中可以使用`匿名密码`（无服务器证书），但它们很少适用，并且当前未针对 `TLS 1.3` 进行定义***。通常还需要其他中间颁发者 CA 证书，并且服务器（终端实体或 EE）证书和颁发者（“链”）证书最容易在单个“链文件”中配置。下面我们加载这样一个链文件（EE证书必须首先出现），然后加载相应的私钥，检查它是否与服务器证书匹配。不执行任何检查来检查链的完整性（例如 CA 签名或证书到期日期）。
    + > Next we enable `session caching`, which makes it possible for clients to more efficiently make additional TLS connections after completing an initial full TLS handshake. With TLS 1.3, session resumption typically still performs a fresh key agreement, but the certificate exchange is avoided. ***接下来，我们启用会话缓存，这使得客户端可以在完成初始完整 TLS 握手后更有效地建立额外的 TLS 连接。<ins>使用 `TLS 1.3`，会话恢复通常仍执行新的密钥协商，但避免了证书交换</ins>***。
    + > Most servers, including this one, do not solicit client certificates. We therefore do not need a "trust store" and allow the handshake to complete even when the client does not present a certificate. Note: Even if a client did present a trusted ceritificate, for it to be useful, the server application would still need custom code to use the verified identity to grant nondefault access to that particular client. Some servers grant access to all clients with certificates from a private CA, this then requires processing of certificate revocation lists to deauthorise a client. It is often simpler and more secure to instead keep a list of authorised public keys. 大多数服务器（包括这台服务器）不请求客户端证书。因此，我们不需要“信任存储”，即使客户端没有提供证书也可以完成握手。注意：即使客户端确实提供了受信任的证书，为了使其有用，服务器应用程序仍然需要自定义代码来使用经过验证的身份来向该特定客户端授予非默认访问权限。某些服务器向具有私有 CA 的证书的所有客户端授予访问权限，然后需要处理证书吊销列表以取消对客户端的授权。保留授权公钥列表通常更简单、更安全。
    + > Though this is the default setting, we explicitly call the SSL_CTX_set_verify(3) function and pass the SSL_VERIFY_NONE value to it. The final argument to this function is a callback that you can optionally supply to override the default handling for certificate verification. Most applications do not need to do this so this can safely be set to NULL to get the default handling. 尽管这是默认设置，但我们显式调用 [SSL_CTX_set_verify(3)]() 函数并将 **`SSL_VERIFY_NONE`** 值传递给它。此函数的最后一个参数是一个回调，您可以选择提供该回调来覆盖证书验证的默认处理。大多数应用程序不需要这样做，因此可以安全地将其设置为 `NULL` 以获得默认处理。
      ```c
      /*
       * Clients rarely employ certificate-based authentication, and so we don't
       * require "mutual" TLS authentication (indeed there's no way to know
       * whether or how the client authenticated the server, so the term "mutual"
       * is potentially misleading).
       *
       * Since we're not soliciting or processing client certificates, we don't
       * need to configure a trusted-certificate store, so no call to
       * SSL_CTX_set_default_verify_paths() is needed.  The server's own
       * certificate chain is assumed valid.
       */
      SSL_CTX_set_verify(ctx, SSL_VERIFY_NONE, NULL);
      ```
    + > That is all the setup that we need to do for the SSL_CTX. Next we create an acceptor BIO on which to accept client connections. This just records the intended port (and optional "host:" prefix), without actually creating the socket. This delayed processing allows the programmer to specify additional behaviours before the listening socket is actually created. 这就是我们需要为 **`SSL_CTX`** 做的所有设置。接下来我们创建一个接受器 `BIO` 来接受客户端连接。这只是记录预期的端口（和可选的“host：”前缀），而不实际创建套接字。这种延迟处理允许程序员在实际创建侦听套接字之前指定其他行为。
      ```c
      /*
       * Create a listener socket wrapped in a BIO.
       * The first call to BIO_do_accept() initialises the socket
       */
      acceptor_bio = BIO_new_accept(hostport);
      if (acceptor_bio == NULL) {
          SSL_CTX_free(ctx);
          ERR_print_errors_fp(stderr);
          errx(res, "Error creating acceptor bio");
      }
      ```
    + > Servers almost always want to use the "SO_REUSEADDR" option to avoid startup failures if there are still lingering client connections, so we do that before making the first call to BIO_do_accept(3) which creates the listening socket, without accepting a client connection. Subsequent calls to the same function will accept new connections. 如果仍有延迟的客户端连接，服务器几乎总是希望使用 `“SO_REUSEADDR”` 选项来避免启动失败，因此我们在第一次调用 [BIO_do_accept(3)]() 之前执行此操作，该调用创建侦听套接字，而不接受客户端连接。对同一函数的后续调用将接受新连接。
      ```c
      BIO_set_bind_mode(acceptor_bio, BIO_BIND_REUSEADDR);
      if (BIO_do_accept(acceptor_bio) <= 0) {
          SSL_CTX_free(ctx);
          ERR_print_errors_fp(stderr);
          errx(res, "Error setting up acceptor socket");
      }
      ```
  * > **Server loop¶ 服务器循环**
    + > The server now enters a "forever" loop handling one client connection at a time. Before each connection we clear the OpenSSL error stack, so that any error reports are related to just the new connection. ***服务器现在进入“永远”循环，一次处理一个客户端连接。在每次连接之前，我们都会清除 OpenSSL 错误堆栈，以便任何错误报告都仅与新连接相关***。
      ```c
      /* Pristine error stack for each new connection */
      ERR_clear_error();
      ```
    + > At this point the server blocks to accept the next client: 此时服务器会阻止接受下一个客户端：
      ```c
      /* Wait for the next client to connect */
      if (BIO_do_accept(acceptor_bio) <= 0) {
          /* Client went away before we accepted the connection */
          continue;
      }
      ```
    + > On success the accepted client connection has been wrapped in a fresh `BIO` and pushed onto the end of the acceptor `BIO chain`. We pop it off returning the acceptor BIO to its initial state. ***成功后，接受的客户端连接将被包装在新的 `BIO` 中，并推送到接受者 `BIO 链`的末尾。我们将其弹出，将接受器 BIO 返回到其初始状态***。
      ```c
      /* Pop the client connection from the BIO chain */
      client_bio = BIO_pop(acceptor_bio);
      fprintf(stderr, "New client connection accepted\n");
      ```
    + > Next, we create an `SSL object` by calling the SSL_new(3) function and passing the SSL_CTX we created as an argument. The client connection BIO is configured as the I/O conduit for this SSL handle. SSL_set_bio transfers ownership of the BIO or BIOs involved (our client_bio) to the SSL handle. 接下来，我们通过调用 [SSL_new(3)]() 函数并将我们创建的 **`SSL_CTX`** 作为参数传递来创建 `SSL对象`。客户端连接 BIO 配置为该 SSL 句柄的 I/O 管道。 `SSL_set_bio` 将涉及的 BIO 或 BIO（我们的 client_bio ）的所有权转移到 SSL 句柄。
      ```c
      /* Associate a new SSL handle with the new connection */
      if ((ssl = SSL_new(ctx)) == NULL) {
          ERR_print_errors_fp(stderr);
          warnx("Error creating SSL handle for new connection");
          BIO_free(client_bio);
          continue;
      }
      SSL_set_bio(ssl, client_bio, client_bio);
      ```
    + > And now we're ready to attempt the SSL handshake. With a `blocking socket` OpenSSL will perform all the read and write operations required to complete the handshake (or detect and report a failure) before returning. 现在我们准备尝试 SSL 握手。对于`阻塞套接字`，OpenSSL 将在返回之前执行完成握手（或检测并报告故障）所需的所有读写操作。
      ```c
      /* Attempt an SSL handshake with the client */
      if (SSL_accept(ssl) <= 0) {
          ERR_print_errors_fp(stderr);
          warnx("Error performing SSL handshake with client");
          SSL_free(ssl);
          continue;
      }
      ```
    + > With the handshake complete, the server loops echoing client input back to the client: 握手完成后，服务器循环将客户端输入回显给客户端：
      ```c
      while (SSL_read_ex(ssl, buf, sizeof(buf), &nread) > 0) {
          if (SSL_write_ex(ssl, buf, nread, &nwritten) > 0 &&
              nwritten == nread) {
              total += nwritten;
              continue;
          }
          warnx("Error echoing client input");
          break;
      }
      ```
    + > Once the client closes its connection, we report the number of bytes sent to stderr and free the SSL handle, which also frees the client_bio and closes the underlying socket. 一旦客户端关闭其连接，我们就会报告发送到 `stderr` 的字节数并释放 SSL 句柄，这也会释放 client_bio 并关闭底层套接字。
      ```c
      fprintf(stderr, "Client connection closed, %zu bytes sent\n", total);
      SSL_free(ssl);
      ```
    + > The server is now ready to accept the next client connection. 服务器现在已准备好接受下一个客户端连接。
  * > **Final clean up¶ 最后清理**
    + > If the server could somehow manage to break out of the infinite loop, and be ready to exit, it would first deallocate the constructed SSL_CTX. 如果服务器能够以某种方式设法摆脱无限循环并准备退出，它将首先释放构造的 **`SSL_CTX`** 。
      ```c
      /*
       * Unreachable placeholder cleanup code, the above loop runs forever.
       */
      SSL_CTX_free(ctx);
      return EXIT_SUCCESS;
      ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-quic-introduction

ossl-guide-quic-introduction https://docs.openssl.org/master/man7/ossl-guide-quic-introduction/
- > **INTRODUCTION¶ 介绍¶**
  * > This page will provide an introduction to some basic `QUIC` concepts and background and how it is used within OpenSSL. It assumes that you have a basic understanding of `UDP/IP` and sockets. It also assumes that you are familiar with some OpenSSL and TLS fundamentals (see [ossl-guide-libraries-introduction(7)]() and [ossl-guide-tls-introduction(7)]()). 本页面将介绍一些基本的 `QUIC` 概念和背景以及如何在 OpenSSL 中使用它。它假设您对 `UDP/IP` 和`套接字`有基本的了解。它还假设您熟悉一些 OpenSSL 和 TLS 基础知识（请参阅 [ossl-guide-libraries-introduction(7)]() 和 [ossl-guide-tls-introduction(7)]() ）。
- > **WHAT IS QUIC?¶ 什么是 QUIC？¶**
  * > `QUIC` is a general purpose protocol for enabling applications to securely communicate over a network. It is defined in RFC9000 (see https://datatracker.ietf.org/doc/rfc9000/ ). `QUIC` integrates parts of the TLS protocol for connection establishment but independently protects packets. It provides similar security guarantees to TLS such as `confidentiality`, `integrity` and `authentication` (see [ossl-guide-tls-introduction(7)]() ). `QUIC` 是一种通用协议，使应用程序能够通过网络安全地进行通信。它在 `RFC9000` 中定义（请参阅 https://datatracker.ietf.org/doc/rfc9000/ ）。 `QUIC` 集成了部分 TLS 协议来建立连接，但独立保护数据包。它提供与 TLS 类似的安全保证，例如`机密性`、`完整性`和`身份验证`（请参阅 [ossl-guide-tls-introduction(7)]() ）。
  * > `QUIC` delivers a number of advantages: `QUIC` 具有许多优势：
    + > **Multiple streams 多个流**
      - > It supports multiple streams of communication (see `"QUIC STREAMS"` below), allowing application protocols built on `QUIC` to create arbitrarily many bytestreams for communication between a client and server. This allows an application protocol to avoid problems where one packet of data is held up waiting on another packet being delivered (commonly referred to as `"head-of-line blocking"`). It also enables an application to open additional logical streams without requiring a round-trip exchange of packets between the client and server as is required when opening an additional TLS/TCP connection. ***它支持多个通信流（请参阅下面的`“QUIC STREAMS”`），允许基于 `QUIC` 构建的应用程序协议为客户端和服务器之间的通信创建任意多个字节流***。这使得应用协议能够避免一个数据包因等待另一个数据包被传送而被搁置的问题（通常称为`“队头阻塞”`）。***它还使应用程序能够打开额外的逻辑流，而无需像打开额外的 TLS/TCP 连接时所需的那样在客户端和服务器之间进行数据包的往返交换***。 
    + > **`HTTP/3`**
      - > Since `QUIC` is the basis of `HTTP/3`, support for `QUIC` also enables applications to use `HTTP/3` using a suitable third-party library. 由于 `QUIC` 是 `HTTP/3` 的基础，因此对 `QUIC` 的支持还使应用程序能够通过合适的第三方库来使用 `HTTP/3`。 
    + > **Fast connection initiation 快速连接启动**
      - > Future versions of OpenSSL will offer support for 0-RTT connection initiation, allowing a connection to be initiated to a server and application data to be transmitted without any waiting time. This is similar to TLS 1.3's 0-RTT functionality but also avoids the round trip needed to open a TCP socket; thus, it is similar to a combination of TLS 1.3 0-RTT and TCP Fast Open. OpenSSL 的未来版本将支持 `0-RTT` 连接启动，允许启动到服务器的连接并传输应用程序数据，而无需任何等待时间。这类似于 `TLS 1.3` 的 `0-RTT` 功能，但也避免了打开 TCP 套接字所需的往返；因此，它类似于 `TLS 1.3 0-RTT` 和 `TCP Fast Open` 的组合。
    + > **Connection migration 连接迁移**
      - > Future versions of OpenSSL will offer support for connection migration, allowing connections to seamlessly survive IP address changes. OpenSSL 的未来版本将提供对连接迁移的支持，使连接能够无缝地适应 IP 地址的变化。 
    + > **Datagram based use cases 基于数据报的用例**
      - > Future versions of OpenSSL will offer support for the `QUIC datagram` extension, allowing support for both TLS and DTLS-style use cases on a single connection. OpenSSL 的未来版本将提供对 `QUIC 数据报`扩展的支持，***从而允许在单个连接上支持 `TLS` 和 `DTLS` 风格的用例***。
    + > **Implemented as application library 作为应用程序库实现**
      - > Because most QUIC implementations, including OpenSSL's implementation, are implemented as an application library rather than by an operating system, an application can gain the benefit of QUIC without needing to wait for an OS update to be deployed. Future evolutions and enhancements to the QUIC protocol can be delivered as quickly as an application can be updated without dependency on an OS update cadence. ***由于大多数 `QUIC` 实现（包括 OpenSSL 的实现）都是作为应用程序库而不是操作系统实现的，因此应用程序无需等待部署操作系统更新即可获得 `QUIC` 的优势***。`QUIC` 协议的未来演变和增强可以与应用程序更新一样快地交付，而不依赖于操作系统更新节奏。 
    + > **Multiplexing over a single `UDP socket` 通过单个 `UDP 套接字`进行多路复用**
      - > Because QUIC is UDP-based, it is possible to multiplex a `QUIC connection` on the same `UDP socket` as some other UDP-based protocols, such as RTP. 由于 `QUIC` 基于 `UDP`，因此可以与其他一些基于 `UDP` 的协议（例如 `RTP`）在同一 `UDP 套接字`上复用 `QUIC 连接`。 
- > **QUIC TIME BASED EVENTS¶ 基于快速时间的事件**
  * > A key difference between the TLS implementation and the QUIC implementation in OpenSSL is how time is handled. The `QUIC protocol` requires various actions to be performed on a regular basis regardless of whether application data is being transmitted or received. ***OpenSSL 中 `TLS 实现`和 `QUIC 实现`之间的主要区别在于时间的处理方式。`QUIC 协议`要求定期执行各种操作，无论应用程序数据是否正在传输或接收***。
  * > OpenSSL introduces a new function SSL_handle_events(3) that will automatically process any outstanding time based events that must be handled. Alternatively calling any I/O function such as SSL_read_ex(3) or SSL_write_ex(3) will also process these events. There is also SSL_get_event_timeout(3) which tells an application the amount of time that remains until SSL_handle_events(3) (or any I/O function) must be called. ***OpenSSL 引入了一个新函数 [SSL_handle_events(3)]()，它将自动处理任何必须处理的未完成的基于时间的事件***。或者，调用任何 I/O 函数（例如 [SSL_read_ex(3)]() 或 [SSL_write_ex(3)]()）也将处理这些事件。还有 [SSL_get_event_timeout(3)]()，它告诉应用程序在必须调用 [SSL_handle_events(3)]() （或任何 I/O 函数）之前剩余的时间量。
  * > Fortunately a `blocking application` that does not leave the `QUIC connection` idle, and is regularly calling I/O functions does not typically need to worry about this. However if you are developing a `nonblocking application` or one that may leave the `QUIC connection` idle for a period of time then you will need to arrange to call these functions. ***幸运的是，一个不会让 `QUIC 连接`处于空闲状态，并且定期调用 I/O 函数的`阻塞应用程序`，通常不需要担心这一点***。但是，***如果您正在开发一个`非阻塞应用程序`或可能使 `QUIC 连接`空闲一段时间的应用程序，那么您将需要安排调用这些函数***。
  * > OpenSSL provides an optional `"thread assisted mode"` that will automatically create a background thread and will regularly call [SSL_handle_events(3)]() in a thread safe manner. This provides a simple way for an application to satisfy the `QUIC` requirements for time based events without having to implement special logic to accomplish it. ***OpenSSL 提供了一个可选的`“线程辅助模式”`，它将自动创建后台线程，并以线程安全的方式定期调用 [SSL_handle_events(3)]() 。这为应用程序提供了一种简单的方法来满足基于时间的事件的 `QUIC` 要求，而无需实现特殊的逻辑来完成它***。
- > **QUIC AND TLS¶ QUIC 和 TLS**
  * > QUIC reuses parts of the TLS protocol in its implementation. Specifically the TLS handshake also exists in QUIC. The TLS handshake messages are wrapped up in QUIC protocol messages in order to send them to the peer. Once the TLS handshake is complete all application data is sent entirely using QUIC protocol messages without using TLS - although some `TLS handshake messages` may still be sent in some circumstances. ***<ins>`QUIC` 在其实现中重用了 `TLS` 协议的部分内容</ins>。具体来说，`TLS 握手`也存在于 `QUIC` 中。`TLS 握手消息`封装在 `QUIC` 协议消息中，以便将其发送给对等方。<ins>TLS 握手完成后，所有应用程序数据都将完全使用 QUIC 协议消息发送，而不使用 TLS - 尽管在某些情况下仍可能发送某些 `TLS 握手消息`</ins>***。
  * > This relationship between QUIC and TLS means that many of the API functions in OpenSSL that apply to TLS connections also apply to QUIC connections and applications can use them in exactly the same way. Some functions do not apply to QUIC at all, and others have altered semantics. You should refer to the documentation pages for each function for information on how it applies to QUIC. Typically if QUIC is not mentioned in the manual pages then the functions apply to both TLS and QUIC. ***`QUIC` 和 `TLS` 之间的这种关系意味着 OpenSSL 中适用于 TLS 连接的许多 API 函数也适用于 QUIC 连接，并且应用程序可以以完全相同的方式使用它们***。有些函数根本不适用于 QUIC，而其他函数则改变了语义。您应参阅每个函数的文档页面，了解有关其如何应用于 QUIC 的信息。***<ins>通常，如果手册页中未提及 QUIC，则这些函数适用于 TLS 和 QUIC</ins>***。
- > **`QUIC STREAMS`¶ `QUIC 流`**
  * > QUIC introduces the concept of `"streams"`. A stream provides a reliable mechanism for sending and receiving application data between the endpoints. The bytes transmitted are guaranteed to be received in the same order they were sent without any loss of data or reordering of the bytes. A TLS application effectively has one bi-directional stream available to it per TLS connection. A QUIC application can have multiple uni-directional or bi-directional streams available to it for each connection. ***`QUIC` 引入了`“流”`的概念。流提供了一种在端点之间发送和接收应用程序数据的可靠机制。保证所传输的字节按照发送时的顺序接收，不会丢失任何数据或对字节进行重新排序。<ins>`TLS` 应用程序实际上为每个 `TLS 连接`提供一个可用的双向流。`QUIC` 应用程序可以为每个连接提供多个可用的单向或双向流</ins>***。
  * > In OpenSSL an SSL object is used to represent both `connections` and `streams`. A QUIC application creates an `initial SSL object` to represent the `connection` (known as the <ins>`connection SSL object`</ins>). Once the connection is complete additional SSL objects can be created to represent `streams` (known as <ins>`stream SSL objects`</ins>). Unless configured otherwise, a `"default" stream` is also associated with the `connection SSL object` so you can still write data and read data to/from it. Some OpenSSL API functions can only be used with `connection SSL objects`, and some can only be used with `stream SSL objects`. Check the documentation for each function to confirm what type of SSL object can be used in any particular context. A `connection SSL object` that has a `default stream` attached to it can be used in contexts that require a `connection SSL object` or in contexts that require a `stream SSL object`. ***在 OpenSSL 中，`SSL对象`用于表示`连接`和`流`。`QUIC` 应用程序创建一个`初始SSL对象`来表示`连接`（称为<ins>`连接SSL对象`</ins>）。连接完成后，可以创建其他`SSL对象`来表示`流`（称为<ins>`流SSL对象`</ins>）。除非另有配置，否则`“默认”流`也会与`连接SSL对象`关联，因此您仍然可以向其中写入数据或从中读取数据。某些 OpenSSL API 函数只能与`连接SSL对象`一起使用，而某些函数只能与`流SSL对象`一起使用***。检查每个函数的文档，以确认在任何特定上下文中可以使用什么类型的SSL对象。***附加了`默认流`的`连接SSL对象`可以在需要`连接SSL对象`的上下文或需要`流SSL对象`的上下文中使用***。
- > **SOCKETS AND BLOCKING¶ 套接字和阻塞**
  * > TLS assumes `"stream" type` semantics for its underlying transport layer protocol (usually achieved by using TCP). However QUIC assumes `"datagram" type` semantics by using UDP. An OpenSSL application using QUIC is responsible for creating a BIO to represent the underlying transport layer. This BIO must support datagrams and is typically BIO_s_datagram(3), but other BIO choices are available. See bio(7) for an introduction to OpenSSL's **`BIO`** concept. ***`TLS` 为其底层传输层协议假定`“流”类型`语义（通常通过使用 `TCP` 实现）。然而，`QUIC` 通过使用 UDP 假定`“数据报”类型`语义。<ins>使用 QUIC 的 OpenSSL 应用程序负责创建 BIO 来表示底层传输层。该 BIO 必须支持数据报，通常为 [BIO_s_datagram(3)]() ，但也可以使用其他BIO选择</ins>***。有关 OpenSSL 的 **`BIO`** 概念的介绍，请参阅 [bio(7)]() 。
  * > A significant difference between OpenSSL TLS applications and OpenSSL QUIC applications is the way that blocking is implemented. In TLS if your application expects blocking behaviour then you configure the underlying socket for blocking. Conversely if your application wants nonblocking behaviour then the underlying socket is configured to be nonblocking. ***<ins>`OpenSSL TLS 应用程序`和 `OpenSSL QUIC 应用程序`之间的显着区别在于阻塞的实现方式</ins>。在 TLS 中，如果您的应用程序期望阻塞行为，那么您可以将底层套接字配置为阻塞。相反，如果您的应用程序需要非阻塞行为，则底层套接字将配置为非阻塞***。
  * > With an OpenSSL QUIC application the underlying socket must always be configured to be nonblocking. Howevever the SSL object will, by default, still operate in blocking mode. So, from an application's perspective, calls to functions such as SSL_read_ex(3), SSL_write_ex(3) and other I/O functions will still block. OpenSSL itself provides that blocking capability for QUIC instead of the socket. If nonblocking behaviour is desired then the application must call SSL_set_blocking_mode(3). ***<ins>对于 `OpenSSL QUIC 应用程序`，底层套接字必须始终配置为非阻塞</ins>。然而，默认情况下，`SSL对象`仍将在阻止模式下运行***。因此，从应用程序的角度来看，对 [SSL_read_ex(3)]() 、[SSL_write_ex(3)]() 等函数以及其他 I/O 函数的调用仍然会阻塞。***OpenSSL 本身为 QUIC 而不是套接字提供了阻塞功能。如果需要非阻塞行为，则应用程序必须调用 [SSL_set_blocking_mode(3)]()*** 。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-quic-client-block
>> 【[ :star: ][`*`]】 //notes：官方示例完整代码： https://github.com/openssl/openssl/blob/master/demos/guide/quic-client-block.c

ossl-guide-quic-client-block https://docs.openssl.org/master/man7/ossl-guide-quic-client-block/
- > **SIMPLE `BLOCKING` QUIC CLIENT EXAMPLE¶ 简单阻止 QUIC 客户端示例**
  * > This page will present various source code samples demonstrating how to write a simple blocking `QUIC client` application which connects to a server, sends an `HTTP/1.0` request to it, and reads back the response. Note that `HTTP/1.0` over `QUIC` is non-standard and will not be supported by real world servers. This is for demonstration purposes only. ***本页将提供各种源代码示例，演示如何编写一个简单的阻塞 `QUIC 客户端`应用程序，该应用程序连接到服务器、向其发送 `HTTP/1.0` 请求并读回响应***。请注意，***基于 `QUIC` 的 `HTTP/1.0` 是非标准，并且不会受到现实世界服务器的支持。这仅用于演示目的***。
  * > We assume that you already have OpenSSL installed on your system; that you already have some fundamental understanding of OpenSSL concepts, TLS and QUIC (see ossl-guide-libraries-introduction(7), ossl-guide-tls-introduction(7) and ossl-guide-quic-introduction(7)); and that you know how to write and build C code and link it against the libcrypto and libssl libraries that are provided by OpenSSL. It also assumes that you have a basic understanding of UDP/IP and sockets. The example code that we build in this tutorial will amend the blocking TLS client example that is covered in ossl-guide-tls-client-block(7). Only the differences between that client and this one will be discussed so we also assume that you have run through and understand that tutorial. 我们假设您的系统上已经安装了 OpenSSL；您已经对 OpenSSL 概念、`TLS` 和 `QUIC` 有一些基本的了解（请参阅 [ossl-guide-libraries-introduction(7)]() 、[ossl-guide-tls-introduction(7)]() 和 [ossl-guide-quic-introduction(7)]() ）；并且您知道如何编写和构建 C 代码并将其链接到 OpenSSL 提供的 `libcrypto` 和 `libssl` 库。它还假设您对 `UDP/IP` 和`套接字`有基本的了解。***我们在本教程中构建的示例代码将修改 [ossl-guide-tls-client-block(7)]() 中介绍的`阻塞 TLS 客户端`示例***。将仅讨论该客户端与此客户端之间的差异，因此我们还假设您已经完成并理解该教程。
  * > For this tutorial our client will be using a `single QUIC stream`. A subsequent tutorial will discuss how to write a `multi-stream client` (see [ossl-guide-quic-multi-stream(7)]()). ***在本教程中，我们的客户端将使用`单个 QUIC 流`***。后续教程将讨论如何编写`多流客户端`（请参阅 [ossl-guide-quic-multi-stream(7)]() ）。
  * > The complete source code for this example `blocking QUIC client` is available in the **`demos/guide`** directory of the OpenSSL source distribution in the file **`quic-client-block.c`**. It is also available online at https://github.com/openssl/openssl/blob/master/demos/guide/quic-client-block.c . 此示例`阻塞 QUIC 客户端`的完整源代码可在 OpenSSL 源代码分发的 **`demos/guide`** 目录中的 **`quic-client-block.c`** 文件中找到。也可在线获取 https://github.com/openssl/openssl/blob/master/demos/guide/quic-client-block.c 。
  * > **Creating the SSL_CTX and SSL objects¶ 创建 SSL_CTX 和 SSL 对象**
    + > In the TLS tutorial (ossl-guide-tls-client-block(7)) we created an SSL_CTX object for our client and used it to create an SSL object to represent the TLS connection. A QUIC connection works in exactly the same way. We first create an SSL_CTX object and then use it to create an SSL object to represent the QUIC connection. 在 TLS 教程 ( [ossl-guide-tls-client-block(7)]() ) 中，我们为客户端创建了一个 **`SSL_CTX`** 对象，并使用它来创建一个 `SSL对象` 来表示 `TLS 连接`。 ***`QUIC 连接`的工作方式完全相同。我们首先创建一个 `SSL_CTX` 对象，然后使用它创建一个 `SSL对象` 来表示 `QUIC 连接`***。
    + > As in the TLS example the first step is to create an SSL_CTX object for our client. This is done in the same way as before except that we use a different `"method"`. OpenSSL offers two different QUIC client methods, i.e. OSSL_QUIC_client_method(3) and OSSL_QUIC_client_thread_method(3). ***与 TLS 示例一样，第一步是为我们的客户端创建 `SSL_CTX` 对象。这与之前的方式相同，只是我们使用了不同的`“方法”`***。OpenSSL 提供两种不同的 `QUIC 客户端方法`，***即 [`OSSL_QUIC_client_method`(3)]() 和 [`OSSL_QUIC_client_thread_method`(3)]()*** 。
    + > The first one is the equivalent of TLS_client_method(3) but for the QUIC protocol. The second one is the same, but it will additionally create a background thread for handling time based events (known as `"thread assisted mode"`, see ossl-guide-quic-introduction(7)). For this tutorial we will be using OSSL_QUIC_client_method(3) because we will not be leaving the QUIC connection idle in our application and so thread assisted mode is not needed. ***第一个相当于 [TLS_client_method(3)]()，但适用于 `QUIC` 协议。第二个是相同的，但它会另外创建一个后台线程来处理基于时间的事件（称为`“线程辅助模式”`，请参阅 [ossl-guide-quic-introduction(7)]() ）***。在本教程中，我们将使用 [OSSL_QUIC_client_method(3)]()，因为我们不会让应用程序中的 `QUIC 连接`处于空闲状态，因此不需要线程辅助模式。
      ```c
      /*
       * Create an SSL_CTX which we can use to create SSL objects from. We
       * want an SSL_CTX for creating clients so we use OSSL_QUIC_client_method()
       * here.
       */
      ctx = SSL_CTX_new(OSSL_QUIC_client_method());
      if (ctx == NULL) {
          printf("Failed to create the SSL_CTX\n");
          goto end;
      }
      ```
    + > The other setup steps that we applied to the SSL_CTX for TLS also apply to QUIC except for restricting the TLS versions that we are willing to accept. The QUIC protocol implementation in OpenSSL currently only supports TLSv1.3. There is no need to call SSL_CTX_set_min_proto_version(3) or SSL_CTX_set_max_proto_version(3) in an OpenSSL QUIC application, and any such call will be ignored. ***除了限制我们愿意接受的 TLS 版本之外，我们应用于 TLS 的 `SSL_CTX` 的其他设置步骤也适用于 QUIC。<ins>OpenSSL 中的 QUIC 协议实现目前仅支持 `TLSv1.3`</ins>。无需在 OpenSSL QUIC 应用程序中调用 [SSL_CTX_set_min_proto_version(3)]() 或 [SSL_CTX_set_max_proto_version(3)]() ，任何此类调用都将被忽略***。
    + > Once the SSL_CTX is created, the SSL object is constructed in exactly the same way as for the TLS application. ***创建 `SSL_CTX` 后，`SSL对象`的构造方式与 `TLS 应用程序`完全相同***。
  * > **Creating the socket and BIO¶ 创建套接字和 BIO**
    + > A major difference between TLS and QUIC is the underlying transport protocol. TLS uses TCP while QUIC uses UDP. The way that the QUIC socket is created in our example code is much the same as for TLS. We use the BIO_lookup_ex(3) and BIO_socket(3) helper functions as we did in the previous tutorial except that we pass `SOCK_DGRAM` as an argument to indicate UDP (instead of `SOCK_STREAM` for TCP). ***TLS 和 QUIC 之间的主要区别在于底层传输协议。`TLS` 使用 `TCP`，而 `QUIC` 使用 `UDP`***。在我们的示例代码中创建 `QUIC 套接字`的方式与 TLS 非常相似。我们使用 [BIO_lookup_ex(3]() 和 [BIO_socket(3)]() 辅助函数，就像我们在上一个教程中所做的那样，***只是我们传递 `SOCK_DGRAM` 作为参数来指示 `UDP`（而不是 `TCP` 的 `SOCK_STREAM`）***。
    + > You may notice a couple of other differences between this code and the version that we used for TLS. 您可能会注意到此代码与我们用于 TLS 的版本之间还有一些其他差异。
    + > Firstly, we set the `socket` into `nonblocking` mode. This must always be done for an OpenSSL QUIC application. This may be surprising considering that we are trying to write a blocking client. Despite this the SSL object will still have blocking behaviour. See ossl-guide-quic-introduction(7) for further information on this. ***首先，我们将`套接字`设置为`非阻塞`模式。<ins>对于 OpenSSL QUIC 应用程序，必须始终执行此操作</ins>***。考虑到我们正在尝试编写一个阻塞客户端，这可能会令人惊讶。尽管如此，***`SSL对象`仍然具有阻塞行为***。有关详细信息，请参阅 [ossl-guide-quic-introduction(7)]() 。
    + > Secondly, we take note of the IP address of the peer that we are connecting to. We store that information away. We will need it later. 其次，我们记下要连接的对等方的 IP 地址。我们将这些信息存储起来。我们稍后会需要它。
    + > As for our TLS client, once the socket has been created and connected we need to associate it with a BIO object: 类似于我们的 TLS 客户端，一旦创建并连接了套接字，我们需要将其与 BIO 对象关联：
      ```c
      BIO *bio;

      /* Create a BIO to wrap the socket */
      bio = BIO_new(BIO_s_datagram());
      if (bio == NULL) {
          BIO_closesocket(sock);
          return NULL;
      }

      /*
       * Associate the newly created BIO with the underlying socket. By
       * passing BIO_CLOSE here the socket will be automatically closed when
       * the BIO is freed. Alternatively you can use BIO_NOCLOSE, in which
       * case you must close the socket explicitly when it is no longer
       * needed.
       */
      BIO_set_fd(bio, sock, BIO_CLOSE);
      ```
    + > Note the use of BIO_s_datagram(3) here as opposed to BIO_s_socket(3) that we used for our TLS client. This is again due to the fact that QUIC uses UDP instead of TCP for its transport layer. See BIO_new(3), BIO_s_datagram(3) and BIO_set_fd(3) for further information on these functions. ***请注意此处使用的是 [BIO_s_datagram(3)]()，而不是我们用于 TLS 客户端的[BIO_s_socket(3)]()*** 。这又是由于 QUIC 使用 UDP 而不是 TCP 作为其传输层。有关这些函数的更多信息，请参见 [BIO_new(3)]() 、[BIO_s_datagram(3)]() 和 [BIO_set_fd(3)]() 。
  * > **Setting the server's hostname¶ 设置服务器的主机名**
    + > As in the TLS tutorial we need to set the server's hostname both for SNI (Server Name Indication) and for certificate validation purposes. The steps for this are identical to the TLS tutorial and won't be repeated here. 正如在 TLS 教程中一样，我们需要为 `SNI`（`服务器名称指示`）和证书验证目的设置服务器的主机名。***此步骤与 TLS 教程相同，此处不再重复***。
  * > **Setting the `ALPN`¶ 设置 `ALPN`**
    + > ALPN (Application-Layer Protocol Negotiation) is a feature of TLS that enables the application to negotiate which protocol will be used over the connection. For example, if you intend to use HTTP/3 over the connection then the ALPN value for that is "h3" (see https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xml#alpn-protocol-ids ). OpenSSL provides the ability for a client to specify the ALPN to use via the SSL_set_alpn_protos(3) function. This is optional for a TLS client and so our simple client that we developed in ossl-guide-tls-client-block(7) did not use it. However QUIC mandates that the TLS handshake used in establishing a QUIC connection must use ALPN. ***`ALPN`（`应用程序层协议协商`）是 TLS 的一项功能，使应用程序能够协商在连接上使用哪个协议***。例如，如果您打算通过连接使用 HTTP/3，则 ALPN 值为“h3”（请参阅​​ https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xml#alpn-protocol-ids ）。OpenSSL 使客户端能够通过 [SSL_set_alpn_protos(3)]() 函数指定要使用的 `ALPN`。这对于 TLS 客户端来说是可选的，因此我们在 [ossl-guide-tls-client-block(7)]() 中开发的简单客户端没有使用它。***然而，`QUIC` 要求建立 `QUIC 连接`时使用的 `TLS 握手`必须使用 `ALPN`***。
      ```c
      unsigned char alpn[] = { 8, 'h', 't', 't', 'p', '/', '1', '.', '0' };

      /* SSL_set_alpn_protos returns 0 for success! */
      if (SSL_set_alpn_protos(ssl, alpn, sizeof(alpn)) != 0) {
          printf("Failed to set the ALPN for the connection\n");
          goto end;
      }
      ```
    + > The ALPN is specified using a length prefixed array of unsigned chars (it is not a NUL terminated string). Our original TLS blocking client demo was using HTTP/1.0. We will use the same for this example. Unlike most OpenSSL functions SSL_set_alpn_protos(3) returns zero for success and nonzero for failure. `ALPN` 使用长度前缀的无符号字符数组指定（它不是 NUL 终止的字符串）。我们最初的 TLS 阻止客户端演示使用的是 HTTP/1.0。我们将在本示例中使用相同的内容。***与大多数 OpenSSL 函数不同， [SSL_set_alpn_protos(3)]() 成功时返回零，失败时返回非零***。
  * > **Setting the peer address¶ 设置对端地址**
    + > An OpenSSL QUIC application must specify the target address of the server that is being connected to. In "Creating the socket and BIO" above we saved that address away for future use. Now we need to use it via the SSL_set1_initial_peer_addr(3) function. ***`OpenSSL QUIC 应用程序`必须指定要连接的服务器的目标地址***。在上面的“创建套接字和 BIO”中，我们保存了该地址以供将来使用。现在我们需要通过 [SSL_set1_initial_peer_addr(3)]() 函数使用它。
      ```c
      /* Set the IP address of the remote peer */
      if (!SSL_set1_initial_peer_addr(ssl, peer_addr)) {
          printf("Failed to set the initial peer address\n");
          goto end;
      }
      ```
    + > Note that we will need to free the peer_addr value that we allocated via BIO_ADDR_dup(3) earlier: 请注意，我们需要释放之前通过 [BIO_ADDR_dup(3)]() 分配的 `peer_addr` 值：
      ```c
      BIO_ADDR_free(peer_addr);
      ```
  * > **The handshake and application data transfer¶ 握手和应用程序数据传输**
    + > Once initial setup of the SSL object is complete then we perform the handshake via SSL_connect(3) in exactly the same way as we did for the TLS client, so we won't repeat it here. 一旦`SSL对象`的初始设置完成，我们就通过 [SSL_connect(3)]() 执行握手，其方式与我们对 `TLS 客户端`所做的完全相同，因此我们在此不再重复。
    + > We can also perform data transfer using a `default QUIC stream` that is automatically associated with the `SSL object` for us. We can transmit data using SSL_write_ex(3), and receive data using SSL_read_ex(3) in the same way as for TLS. The main difference is that we have to account for failures slightly differently. With QUIC the stream can be reset by the peer (which is fatal for that stream), but the underlying connection itself may still be healthy. 我们还可以使用自动与`SSL对象`关联的`默认 QUIC 流`执行数据传输。我们可以使用 [SSL_write_ex(3)]() 传输数据，并使用 [SSL_read_ex(3)]() 接收数据，方式与 TLS 相同。主要区别在于我们对失败的解释略有不同。***使用 QUIC，流可以由对等方重置（这对于该流来说是致命的），但底层连接本身可能仍然是健康的***。
    + > In the above code example you can see that SSL_ERROR_SSL indicates a stream fatal error. We can use SSL_get_stream_read_state(3) to determine whether the stream has been reset, or if some other fatal error has occurred. 在上面的代码示例中，您可以看到 **`SSL_ERROR_SSL`** 指示流致命错误。我们可以使用 [SSL_get_stream_read_state(3)]() 来确定流是否已重置，或者是否发生了其他致命错误。
  * > **Shutting down the connection¶ 关闭连接**
    + > In the TLS tutorial we knew that the server had finished sending data because SSL_read_ex(3) returned 0, and SSL_get_error(3) returned SSL_ERROR_ZERO_RETURN. The same is true with QUIC except that SSL_ERROR_ZERO_RETURN should be interpreted slightly differently. With TLS we knew that this meant that the server had sent a `"close_notify" alert`. No more data will be sent from the server on that connection. ***在 TLS 教程中，我们知道服务器已完成发送数据，因为 [SSL_read_ex(3)]() 返回 `0`，并且 [SSL_get_error(3)]() 返回 `SSL_ERROR_ZERO_RETURN`。QUIC 也是如此，只是 `SSL_ERROR_ZERO_RETURN` 的解释应该略有不同***。通过 TLS，我们知道这意味着服务器已发送`“close_notify”警报`。该连接上的服务器将不再发送任何数据。
    + > With QUIC it means that the server has indicated `"FIN"` on the stream, meaning that it will no longer send any more data on that stream. However this only gives us information about the stream itself and does not tell us anything about the underlying connection. More data could still be sent from the server on some other stream. Additionally, although the server will not send any more data to the client, it does not prevent the client from sending more data to the server. ***对于 QUIC，这意味着服务器已在流上指示`“FIN”`，这意味着它将不再在该流上发送任何更多数据。然而，这仅向我们提供有关流本身的信息，并没有告诉我们有关底层连接的任何信息。更多数据仍可以通过其他流从服务器发送***。另外，***虽然服务器不会再向客户端发送更多的数据，但这并不妨碍客户端向服务器发送更多的数据***。
    + > In this tutorial, once we have finished reading data from the server on the one stream that we are using, we will close the connection down. As before we do this via the SSL_shutdown(3) function. This example for QUIC is very similar to the TLS version. However the SSL_shutdown(3) function will need to be called more than once: 在本教程中，一旦我们在正在使用的一个流上从服务器读取数据后，我们将关闭连接。***和之前一样，我们通过 [SSL_shutdown(3)]() 函数执行此操作。QUIC 的此示例与 TLS 版本非常相似。然而 [SSL_shutdown(3)]() 函数需要被多次调用***：
      ```c
      /*
       * Repeatedly call SSL_shutdown() until the connection is fully
       * closed.
       */
      do {
          ret = SSL_shutdown(ssl);
          if (ret < 0) {
              printf("Error shutting down: %d\n", ret);
              goto end;
          }
      } while (ret != 1);
      ```
    + > The shutdown process is in two stages. In the first stage we wait until all the data we have buffered for sending on any stream has been successfully sent and acknowledged by the peer, and then we send a CONNECTION_CLOSE to the peer to indicate that the connection is no longer usable. This immediately closes the connection and no more data can be sent or received. SSL_shutdown(3) returns `0` once the first stage has been completed. ***关闭过程分两个阶段。在第一阶段，我们等待，直到我们缓冲的用于在任何流上发送的所有数据都已成功发送并被对等方确认，然后我们向对等方发送 `CONNECTION_CLOSE` 以指示该连接不再可用。<ins>这会立即关闭连接，并且无法发送或接收更多数据</ins>。第一阶段完成后，[SSL_shutdown(3)]() 返回 `0`***。
    + > In the second stage the connection enters a `"closing"` state. Application data cannot be sent or received in this state, but late arriving packets coming from the peer will be handled appropriately. Once this stage has completed successfully SSL_shutdown(3) will return `1` to indicate success. ***在第二阶段，连接进入`“关闭”`状态。<ins>在此状态下无法发送或接收应用程序数据，但来自对等方的迟到数据包将得到适当处理</ins>。一旦此阶段成功完成，[SSL_shutdown(3)]() 将返回 `1` 表示成功***。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## ossl-guide-quic-multi-stream

ossl-guide-quic-multi-stream https://docs.openssl.org/master/man7/ossl-guide-quic-multi-stream/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
