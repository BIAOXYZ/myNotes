
# curl

Using curl to automate HTTP jobs https://curl.haxx.se/docs/httpscripting.html

## curl命令总结

```sh
# 注：curl命令默认情况下的http请求动作是GET，也就是相当于 -X GET。

curl 网址[:端口号]  # 查看网页源码。例：curl www.sina.com 或 curl https://www.qq.com:443
curl -L 网址        # 查看网页存在重定向时，自动跳转
```

```sh
# SUSE Linux Enterprise Server 12.3上默认的curl

harbor1:~ # cat /etc/os-release
NAME="SLES"
VERSION="12-SP3"
VERSION_ID="12.3"
PRETTY_NAME="SUSE Linux Enterprise Server 12 SP3"
ID="sles"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:suse:sles:12:sp3"

harbor1:~ # curl --version
curl 7.37.0 (x86_64-suse-linux-gnu) libcurl/7.37.0 OpenSSL/1.0.2j zlib/1.2.8 libidn/1.28 libssh2/1.4.3
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IDN IPv6 Largefile NTLM NTLM_WB SSL libz TLS-SRP

harbor1:~ # curl --help
Usage: curl [options...] <url>
Options: (H) means HTTP/HTTPS only, (F) means FTP only
     --anyauth       Pick "any" authentication method (H)
 -a, --append        Append to target file when uploading (F/SFTP)
     --basic         Use HTTP Basic Authentication (H)
     --cacert FILE   CA certificate to verify peer against (SSL)
     --capath DIR    CA directory to verify peer against (SSL)
 -E, --cert CERT[:PASSWD] Client certificate file and password (SSL)
     --cert-type TYPE Certificate file type (DER/PEM/ENG) (SSL)
     --ciphers LIST  SSL ciphers to use (SSL)
     --compressed    Request compressed response (using deflate or gzip)
 -K, --config FILE   Specify which config file to read
     --connect-timeout SECONDS  Maximum time allowed for connection
 -C, --continue-at OFFSET  Resumed transfer offset
 -b, --cookie STRING/FILE  String or file to read cookies from (H)
 -c, --cookie-jar FILE  Write cookies to this file after operation (H)
     --create-dirs   Create necessary local directory hierarchy
     --crlf          Convert LF to CRLF in upload
     --crlfile FILE  Get a CRL list in PEM format from the given file
 -d, --data DATA     HTTP POST data (H)
     --data-ascii DATA  HTTP POST ASCII data (H)
     --data-binary DATA  HTTP POST binary data (H)
     --data-urlencode DATA  HTTP POST data url encoded (H)
     --delegation STRING GSS-API delegation permission
     --digest        Use HTTP Digest Authentication (H)
     --disable-eprt  Inhibit using EPRT or LPRT (F)
     --disable-epsv  Inhibit using EPSV (F)
     --dns-servers    DNS server addrs to use: 1.1.1.1;2.2.2.2
     --dns-interface  Interface to use for DNS requests
     --dns-ipv4-addr  IPv4 address to use for DNS requests, dot notation
     --dns-ipv6-addr  IPv6 address to use for DNS requests, dot notation
 -D, --dump-header FILE  Write the headers to this file
     --egd-file FILE  EGD socket path for random data (SSL)
     --engine ENGINE  Crypto engine (SSL). "--engine list" for list
 -f, --fail          Fail silently (no output at all) on HTTP errors (H)
 -F, --form CONTENT  Specify HTTP multipart POST data (H)
     --form-string STRING  Specify HTTP multipart POST data (H)
     --ftp-account DATA  Account data string (F)
     --ftp-alternative-to-user COMMAND  String to replace "USER [name]" (F)
     --ftp-create-dirs  Create the remote dirs if not present (F)
     --ftp-method [MULTICWD/NOCWD/SINGLECWD] Control CWD usage (F)
     --ftp-pasv      Use PASV/EPSV instead of PORT (F)
 -P, --ftp-port ADR  Use PORT with given address instead of PASV (F)
     --ftp-skip-pasv-ip Skip the IP address for PASV (F)
     --ftp-pret      Send PRET before PASV (for drftpd) (F)
     --ftp-ssl-ccc   Send CCC after authenticating (F)
     --ftp-ssl-ccc-mode ACTIVE/PASSIVE  Set CCC mode (F)
     --ftp-ssl-control Require SSL/TLS for ftp login, clear for transfer (F)
 -G, --get           Send the -d data with a HTTP GET (H)
 -g, --globoff       Disable URL sequences and ranges using {} and []
 -H, --header LINE   Custom header to pass to server (H)
 -I, --head          Show document info only
 -h, --help          This help text
     --hostpubmd5 MD5  Hex encoded MD5 string of the host public key. (SSH)
 -0, --http1.0       Use HTTP 1.0 (H)
     --http1.1       Use HTTP 1.1 (H)
     --http2         Use HTTP 2 (H)
     --ignore-content-length  Ignore the HTTP Content-Length header
 -i, --include       Include protocol headers in the output (H/F)
 -k, --insecure      Allow connections to SSL sites without certs (H)
     --interface INTERFACE  Specify network interface/address to use
 -4, --ipv4          Resolve name to IPv4 address
 -6, --ipv6          Resolve name to IPv6 address
 -j, --junk-session-cookies Ignore session cookies read from file (H)
     --keepalive-time SECONDS  Interval between keepalive probes
     --key KEY       Private key file name (SSL/SSH)
     --key-type TYPE Private key file type (DER/PEM/ENG) (SSL)
     --krb LEVEL     Enable Kerberos with specified security level (F)
     --libcurl FILE  Dump libcurl equivalent code of this command line
     --limit-rate RATE  Limit transfer speed to this rate
 -l, --list-only     List only mode (F/POP3)
     --local-port RANGE  Force use of these local port numbers
 -L, --location      Follow redirects (H)
     --location-trusted like --location and send auth to other hosts (H)
     --login-options OPTIONS  Server login options (IMAP, POP3, SMTP)
 -M, --manual        Display the full manual
     --mail-from FROM  Mail from this address (SMTP)
     --mail-rcpt TO  Mail to this/these addresses (SMTP)
     --mail-auth AUTH  Originator address of the original email (SMTP)
     --max-filesize BYTES  Maximum file size to download (H/F)
     --max-redirs NUM  Maximum number of redirects allowed (H)
 -m, --max-time SECONDS  Maximum time allowed for the transfer
     --metalink      Process given URLs as metalink XML file
     --negotiate     Use HTTP Negotiate Authentication (H)
 -n, --netrc         Must read .netrc for user name and password
     --netrc-optional Use either .netrc or URL; overrides -n
     --netrc-file FILE  Set up the netrc filename to use
 -:  --next          Allows the following URL to use a separate set of options
     --no-alpn       Disable the ALPN TLS extension (H)
 -N, --no-buffer     Disable buffering of the output stream
     --no-keepalive  Disable keepalive use on the connection
     --no-npn        Disable the NPN TLS extension (H)
     --no-sessionid  Disable SSL session-ID reusing (SSL)
     --noproxy       List of hosts which do not use proxy
     --ntlm          Use HTTP NTLM authentication (H)
     --oauth2-bearer TOKEN  OAuth 2 Bearer Token (IMAP, POP3, SMTP)
 -o, --output FILE   Write output to <file> instead of stdout
     --pass PASS     Pass phrase for the private key (SSL/SSH)
     --post301       Do not switch to GET after following a 301 redirect (H)
     --post302       Do not switch to GET after following a 302 redirect (H)
     --post303       Do not switch to GET after following a 303 redirect (H)
 -#, --progress-bar  Display transfer progress as a progress bar
     --proto PROTOCOLS  Enable/disable specified protocols
     --proto-redir PROTOCOLS  Enable/disable specified protocols on redirect
 -x, --proxy [PROTOCOL://]HOST[:PORT] Use proxy on given port
     --proxy-anyauth Pick "any" proxy authentication method (H)
     --proxy-basic   Use Basic authentication on the proxy (H)
     --proxy-digest  Use Digest authentication on the proxy (H)
     --proxy-negotiate Use Negotiate authentication on the proxy (H)
     --proxy-ntlm    Use NTLM authentication on the proxy (H)
 -U, --proxy-user USER[:PASSWORD]  Proxy user and password
     --proxy1.0 HOST[:PORT]  Use HTTP/1.0 proxy on given port
 -p, --proxytunnel   Operate through a HTTP proxy tunnel (using CONNECT)
     --pubkey KEY    Public key file name (SSH)
 -Q, --quote CMD     Send command(s) to server before transfer (F/SFTP)
     --random-file FILE  File for reading random data from (SSL)
 -r, --range RANGE   Retrieve only the bytes within a range
     --raw           Do HTTP "raw", without any transfer decoding (H)
 -e, --referer       Referer URL (H)
 -J, --remote-header-name Use the header-provided filename (H)
 -O, --remote-name   Write output to a file named as the remote file
     --remote-name-all Use the remote file name for all URLs
 -R, --remote-time   Set the remote file's time on the local output
 -X, --request COMMAND  Specify request command to use
     --resolve HOST:PORT:ADDRESS  Force resolve of HOST:PORT to ADDRESS
     --retry NUM   Retry request NUM times if transient problems occur
     --retry-delay SECONDS When retrying, wait this many seconds between each
     --retry-max-time SECONDS  Retry only within this period
     --sasl-ir       Enable initial response in SASL authentication
 -S, --show-error    Show error. With -s, make curl show errors when they occur
 -s, --silent        Silent mode. Don't output anything
     --socks4 HOST[:PORT]  SOCKS4 proxy on given host + port
     --socks4a HOST[:PORT]  SOCKS4a proxy on given host + port
     --socks5 HOST[:PORT]  SOCKS5 proxy on given host + port
     --socks5-hostname HOST[:PORT] SOCKS5 proxy, pass host name to proxy
     --socks5-gssapi-service NAME  SOCKS5 proxy service name for gssapi
     --socks5-gssapi-nec  Compatibility with NEC SOCKS5 server
 -Y, --speed-limit RATE  Stop transfers below speed-limit for 'speed-time' secs
 -y, --speed-time SECONDS  Time for trig speed-limit abort. Defaults to 30
     --ssl           Try SSL/TLS (FTP, IMAP, POP3, SMTP)
     --ssl-reqd      Require SSL/TLS (FTP, IMAP, POP3, SMTP)
 -2, --sslv2         Use SSLv2 (SSL)
 -3, --sslv3         Use SSLv3 (SSL)
     --ssl-allow-beast Allow security flaw to improve interop (SSL)
     --stderr FILE   Where to redirect stderr. - means stdout
     --tcp-nodelay   Use the TCP_NODELAY option
 -t, --telnet-option OPT=VAL  Set telnet option
     --tftp-blksize VALUE  Set TFTP BLKSIZE option (must be >512)
 -z, --time-cond TIME  Transfer based on a time condition
 -1, --tlsv1         Use => TLSv1 (SSL)
     --tlsv1.0       Use TLSv1.0 (SSL)
     --tlsv1.1       Use TLSv1.1 (SSL)
     --tlsv1.2       Use TLSv1.2 (SSL)
     --trace FILE    Write a debug trace to the given file
     --trace-ascii FILE  Like --trace but without the hex output
     --trace-time    Add time stamps to trace/verbose output
     --tr-encoding   Request compressed transfer encoding (H)
 -T, --upload-file FILE  Transfer FILE to destination
     --url URL       URL to work with
 -B, --use-ascii     Use ASCII/text transfer
 -u, --user USER[:PASSWORD]  Server user and password
     --tlsuser USER  TLS username
     --tlspassword STRING TLS password
     --tlsauthtype STRING  TLS authentication type (default SRP)
 -A, --user-agent STRING  User-Agent to send to server (H)
 -v, --verbose       Make the operation more talkative
 -V, --version       Show version number and quit
 -w, --write-out FORMAT  What to output after completion
     --xattr        Store metadata in extended file attributes
 -q                 If used as the first parameter disables .curlrc
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## curl相关工具

cURL 命令转代码在线工具 https://www.v2ex.com/t/664297
- > 经常需要将 cURL 命令转为其它语言的测试代码的，可以看看这个在线工具 https://curl.6cm.co
- > https://tool.lu/curl
- > 我一直用的是 https://curl.trillworks.com/

问卷调查:如果实现解析 curl 命令的库，大家感兴趣吗？ https://www.v2ex.com/t/652904
- Convert curl syntax to Python, Ansible URI, MATLAB, Node.js, R, PHP, Strest, Go, Dart, JSON, Elixir, Rust https://curl.trillworks.com/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## curl其他帖子

curl网站开发指南 http://www.ruanyifeng.com/blog/2011/09/curl.html

curl 使用指北&实战 https://juejin.im/post/5d85d61f5188257e8e46e477

Linux中使用curl命令访问https站点4种常见错误和解决方法 https://www.jb51.net/LINUXjishu/287588.html
> "解决办法是将签发该证书的私有CA公钥cacert.pem文件内容，追加到/etc/pki/tls/certs/ca-bundle.crt。"
```
[root@cloudsec2 bin]# curl https://9.186.102.71:2379/v3alpha/kv/range
curl: (60) Peer's Certificate issuer is not recognized.
More details here: http://curl.haxx.se/docs/sslcerts.html

试ETCD的时候碰到的问题。试了下把自己生成的ca.pem内容按帖子里说的追加到"/etc/pki/tls/certs/ca-bundle.crt"末尾了，
但是还是不行。猜测是因为我这边ETCD是双向SSL认证的原因，所以client端也得改点啥???回头再研究吧，反正目前重点不在ETCD。
```

记一次解决curl https证书问题 https://www.cnblogs.com/xuxinkun/p/5417836.html

curl 命令学习使用小结 https://www.v2ex.com/t/643426

Linux curl 命令详解 https://www.cnblogs.com/zhanglianghhh/p/11326428.html
- > `-k, --insecure`
  * > (SSL)允许curl执行不安全的SSL连接和传输。
  * > 所有SSL连接都尝试使用默认安装的CA证书包来确保安全。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## curl新闻

cURL 作者 Daniel Stenberg 宣布即将从 Mozilla 离职 https://www.cnbeta.com/articles/tech/789651.htm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# restful api

Representational state transfer https://en.wikipedia.org/wiki/Representational_state_transfer   【[表现层状态转换](https://zh.wikipedia.org/wiki/%E8%A1%A8%E7%8E%B0%E5%B1%82%E7%8A%B6%E6%80%81%E8%BD%AC%E6%8D%A2)】

***阮一峰restful api相关***：
- RESTful API 最佳实践 http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html
- RESTful API 设计指南 http://www.ruanyifeng.com/blog/2014/05/restful_api.html
- 理解RESTful架构 http://www.ruanyifeng.com/blog/2011/09/restful.html

REST 入门介绍 http://www.cnblogs.com/shanyou/archive/2012/05/12/2496959.html
> 在 REST 中的资源 (Resource) 代表整个网络上的资源。网络上提供了各式各样的资源，而网络上的资源由 URI (统一资源标识符,Uniform Resource Identifier) 来提供。 回想，你如何连上我的 博客，你可能通过浏览器直接输入  www.cnblogs.com/shanyou 此域名来到达首页，也能用书签或网络上的链接，经点击后来连上我的博客。然后，你想看这一篇名为「REST 入门介绍」的文章，所以以你接下去点击这文章的标题连结，接去下阅读。我们简易了解一下整个流程：
> 1. 通过URL ( http://www.cnblogs.com/shanyou ) ， Client 向 http://www.cnblogs.com/shanyou 发出请求
> 2. www.cnblogs.com/shanyou 收到请求，回应首页给 Client
> 3. Client 又点击 REST 文章连结  (假设是 http://www.cnblogs.com/shanyou/archive/2011/06/30/2095018.html) 向 http://www.cnblogs.com/shanyou发出archive/2011/06/30/2095018.html  此篇文章的请求
> 4. www.cnblogs.com/shanyou  收到请求，响应 REST 文章内容给 Client
>   
> Client 的通过 URI 来获取资源的具体象征 (Representational)。Client 取得这些具体象征使这些应用程序转变其状态 (以 浏览器而言，取得HTML、CSS、JavaScript … 来生成界面)，随着不断取得资源的具体象征， Client 端不断地改变其状态，这样不断的反复 (iterations ) 过程就是所谓的 Representational State Transfer。

## `PUT` v.s. `POST`

REST – PUT vs POST https://restfulapi.net/rest-put-vs-post/
- > **1. Difference between `PUT` and `POST`**
  * > `PUT` method is [idempotent](https://restfulapi.net/idempotent-rest-apis/). So if we retry a request multiple times, that should be equivalent to a single request invocation.
    > 
    > `POST` is NOT idempotent. So if we retry the request N times, we will end up having N resources with N different URIs created on the server.
- > **2. PUT vs POST with Example**
  * > Let’s say we are designing a network application. Let’s list down a few URIs and their purpose to get a better understanding of when to use POST and when to use PUT operations.
    ```console
    GET 	/device-management/devices       : Get all devices
    POST 	/device-management/devices       : Create a new device
    
    GET 	/device-management/devices/{id}   : Get the device information identified by "id"
    PUT 	/device-management/devices/{id}   : Update the device information identified by "id"
    DELETE	/device-management/devices/{id}   : Delete device by "id"
    ```
    > Follow similar URI design practices for other resources as well.

What is the difference between POST and PUT in HTTP? https://stackoverflow.com/questions/630453/what-is-the-difference-between-post-and-put-in-http

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [wget](https://www.gnu.org/software/wget/)

## wget命令总结

```sh
# 例： wget -O virtctl https://github.com/kubevirt/kubevirt/releases/download/v0.32.0/virtctl-v0.32.0-linux-amd64 会直接把
# 原来名字为 virtctl-v0.32.0-linux-amd64 的文件下载下来并重命名成 virtctl。
wget -O <想改成的文件名> <文件下载地址>        
```

## wget其他

【:star:】 GNU Wget 1.20 Manual https://www.gnu.org/software/wget/manual/

17. wget 文件下载 https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/wget.html
```sh
实例2：使用wget -O下载并以不同的文件名保存
$wget -O wordpress.zip http://www.minjieren.com/download.aspx?id=1080
```

linux 下载 命令 wget 和 curl https://blog.csdn.net/freeking101/article/details/53691481

用wget下载需要用户名和密码认证的网站或者ftp服务器文件 https://www.jianshu.com/p/dc01f7a0436f

## wget后台下载

Linux：wget后台下载/查看后台任务进度 https://blog.csdn.net/wanglc7/article/details/85136418
- > 1：后台下载 —— 使用 `wget -b + url`
  ```sh
  [root@8f9fbda9bb48 ~]# wget -b http://cn.wordpress.org/wordpress-3.1-zh_CN.zip 
  Continuing in background, pid 835.
  Output will be written to 'wget-log'.
  ```
  > 后台任务启动后，会返回两段话，第一段返回一个pid，代表这个后台任务的进程，并且我们可以kill掉这个id来终止此次下载，第二段返回了一句话，意思是会将输出（持续）写入到 `wget-log` 这个文件。
- > 2：查看wget后台进度 —— 有几种方法可以查看：
  * > 1) 使用（断点续传）`wget -c + 正在执行的下载地址`
  * > 2) 找到下载文件的文件夹，其中那个正在写入的输出文件，使用 `tail -f wget-log`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
