
OpenSSL overviews https://docs.openssl.org/master/man7/
- ossl-guide-introduction https://docs.openssl.org/master/man7/ossl-guide-introduction/
- ossl-guide-libraries-introduction https://docs.openssl.org/master/man7/ossl-guide-libraries-introduction/
- ossl-guide-libcrypto-introduction https://docs.openssl.org/master/man7/ossl-guide-libcrypto-introduction/
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
  * > The following shows a complete example for doing this process for digesting data using `SHA256`. The process is similar for other operations such as encryption/decryption, signatures, message authentication codes, etc. Additional examples can be found in the OpenSSL demos (see "DEMO APPLICATIONS" in ossl-guide-libraries-introduction(7)). ***下面显示了使用 `SHA256` 执行此过程以摘要数据的完整示例。该过程与其他操作类似，例如加密/解密、签名、消息身份验证代码等***。其他示例可以在 OpenSSL 演示中找到（请参阅[ossl-guide-libraries-introduction(7)]() 中的“演示应用程序” ）。
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

## ossl-guide-libssl-introduction

ossl-guide-libssl-introduction https://docs.openssl.org/master/man7/ossl-guide-libssl-introduction/
- > **INTRODUCTION 介绍**
  * > The OpenSSL `libssl` library provides implementations of several secure network communications protocols. Specifically it provides `SSL/TLS` (SSLv3, TLSv1, TLSv1.1, TLSv1.2 and TLSv1.3), `DTLS` (DTLSv1 and DTLSv1.2) and `QUIC` (client side only). The library depends on `libcrypto` for its underlying cryptographic operations (see [ossl-guide-libcrypto-introduction(7)]()). ***OpenSSL `libssl` 库提供了多种安全网络通信协议的实现***。具体来说，它提供 `SSL/TLS`（SSLv3、TLSv1、TLSv1.1、TLSv1.2 和 TLSv1.3）、`DTLS`（DTLSv1 和 DTLSv1.2）和 `QUIC`（***仅限客户端***）。该库依赖于 `libcrypto` 进行底层加密操作（请参阅 [ossl-guide-libcrypto-introduction(7)]() ）。
  * > The set of APIs supplied by `libssl` is common across all of these different network protocols, so a developer familiar with writing applications using one of these protocols should be able to transition to using another with relative ease. ***`libssl` 提供的 API 集在所有这些不同的网络协议中都是通用的，因此熟悉使用其中一种协议编写应用程序的开发人员应该能够相对轻松地过渡到使用另一种协议***。
  * > An application written to use `libssl` will include the `<openssl/ssl.h>` header file and will typically use two main data structures, i.e. **`SSL`** and **`SSL_CTX`**. 编写使用 `libssl` 应用程序将包含 `<openssl/ssl.h>` 头文件，***并且通常会使用两个主要数据结构***，即 **`SSL`** 和 **`SSL_CTX`**。
  * > An `SSL object` is used to ***represent a connection to a remote peer***. Once a connection with a remote peer has been established data can be exchanged with that peer. `SSL对象` 用于表示与远程对等点的连接。一旦与远程对等点建立了连接，就可以与该对等点交换数据。
  * > When using `DTLS` any data that is exchanged uses "datagram" semantics, i.e. ***<ins>the packets of data can be delivered in any order, and they are not guaranteed to arrive at all</ins>***. In this case the `SSL object` used for the connection is also used for exchanging data with the peer. 当使用 `DTLS` 时，交换的任何数据都使用“数据报”语义，***<ins>即数据包可以以任何顺序传送，并且根本不保证它们到达</ins>***。在这种情况下，用于连接的 `SSL对象` 也用于与对等方交换数据。
  * > Both TLS and QUIC support the concept of a "stream" of data. Data sent via a stream is guaranteed to be delivered in order without any data loss. A stream can be uni- or bi-directional. ***`TLS` 和 `QUIC` 都支持数据“流”的概念。<ins>通过流发送的数据保证按顺序传送，不会丢失任何数据</ins>。流可以是单向的或双向的***。
  * > `SSL/TLS` only supports one stream of data per connection and it is always bi-directional. In this case the `SSL object` used for the connection also represents that stream. See [ossl-guide-tls-introduction(7)]() for more information. ***`SSL/TLS` 仅支持每个连接一个数据流，并且始终是双向的。在这种情况下，用于连接的 `SSL对象` 也代表该流***。请参阅 [ossl-guide-tls-introduction(7)]() 了解更多信息。
  * > The `QUIC` protocol can support multiple streams per connection and they can be uni- or bi-directional. In this case an `SSL object` can represent the underlying connection, or a stream, or both. Where multiple streams are in use a separate `SSL object` is used for each one. See [ossl-guide-quic-introduction(7)]() for more information. ***`QUIC` 协议可以支持每个连接多个流，并且它们可以是单向或双向的***。在这种情况下，***`SSL对象`可以代表底层连接或流，或两者。当使用多个流时，每个流都会使用一个单独的 `SSL对象`***。请参阅 [ossl-guide-quic-introduction(7)]() 了解更多信息。
  * > An **`SSL_CTX`** object is used to create the **`SSL`** object for the underlying connection. A single `SSL_CTX` object can be used to create many connections (each represented by a separate `SSL` object). Many API functions in `libssl` exist in two forms: one that takes an `SSL_CTX` and one that takes an `SSL`. Typically settings that you apply to the `SSL_CTX` will then be inherited by any `SSL` object that you create from it. Alternatively you can apply settings directly to the `SSL` object without affecting other `SSL` objects. Note that you should not normally make changes to an `SSL_CTX` after the first `SSL` object has been created from it. **`SSL_CTX`** 对象用于为底层连接创建 **`SSL`** 对象。***单个 `SSL_CTX` 对象可用于创建多个连接（每个连接由一个单独的 `SSL` 对象表示）。`libssl` 中的许多 API 函数以两种形式存在：一种采用 `SSL_CTX` ，另一种采用 `SSL`***。通常，***您应用于 `SSL_CTX` 的设置将被您从其创建的任何 `SSL` 对象继承。或者，您可以将设置直接应用于 `SSL` 对象，而不影响其他 `SSL` 对象***。请注意，***<ins>在创建第一个`SSL` 对象后，通常不应对其进行更改</ins>***。
- > **DATA STRUCTURES 数据结构**
  * > As well as **`SSL_CTX`** and **`SSL`** there are a number of other data structures that an application may need to use. They are summarised below. 除了 **`SSL_CTX`** 和 **`SSL`** 之外，应用程序还可能需要使用许多其他数据结构。它们总结如下。
  * > **`SSL_METHOD`** （`SSL 方法`）
    + > This structure is used to indicate the kind of connection you want to make, e.g. whether it is to represent the client or the server, and whether it is to use `SSL/TLS`, `DTLS` or `QUIC` (client only). It is passed as a parameter when creating the `SSL_CTX`. ***该结构用于指示您想要建立的连接类型，例如是代表客户端还是服务器，以及是否使用 `SSL/TLS`、`DTLS` 或 `QUIC`（仅限客户端）。创建 `SSL_CTX` 时它作为参数传递***。
  * > **`SSL_SESSION`** （`SSL 会话`）
    + > After establishing a connection with a peer the agreed cryptographic material can be reused to create future connections with the same peer more rapidly. The set of data used for such a future connection establishment attempt is collected together into an **`SSL_SESSION`** object. A single successful connection with a peer may generate zero or more such **`SSL_SESSION`** objects for use in future connection attempts. ***与对等点建立连接后，可以重复使用商定的加密材料，以便更快地与同一对等点创建未来的连接。用于此类未来连接建立尝试的数据集被收集到 `SSL_SESSION` 对象中***。与对等方的单个成功连接可能会生成零个或多个此类 `SSL_SESSION` 对象，以供将来的连接尝试使用。
  * > **`SSL_CIPHER`** （`SSL 密码`）
    + > During connection establishment the client and server agree upon cryptographic algorithms they are going to use for encryption and other uses. A single set of cryptographic algorithms that are to be used together is known as a `ciphersuite`. Such a set is represented by an **`SSL_CIPHER`** object. 在连接建立期间，客户端和服务器就它们将用于加密和其他用途的加密算法达成一致。一起使用的一组密码算法称为`密码套件`。这样的集合由 **`SSL_CIPHER`** 对象表示。
    + > The set of available ciphersuites that can be used are configured in the **`SSL_CTX`** or **`SSL`**. 可以使用的可用密码套件集在 **`SSL_CTX`** 或 **`SSL`** 中配置。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
