
# 官方

Apache Thrift https://github.com/apache/thrift

Apache Thrift https://thrift.apache.org/

# 其他

Thrift by Example https://thrift-tutorial.readthedocs.io/en/latest/usage-example.html

Apache Thrift – 可伸缩的跨语言服务开发框架 https://developer.ibm.com/zh/languages/java/tutorials/j-lo-apachethrift/

Apache Thrift系列详解(一) - 概述与入门 https://juejin.cn/post/6844903622380093447

由浅入深了解Thrift（一）——Thrift介绍与用法 https://blog.csdn.net/houjixin/article/details/42778335

使用Thrift来实现跨语言的方法调用 http://www.bjhee.com/thrift.html
- > **编写接口文件**
  * > Thrift的核心就是通过接口文件，来生成各语言的代码，接口文件以`*.thrift`命名。代码生成完，被调用方要编写服务端代码，其本质就是通过Thrift库监听一个Socket端口；而调用方编写客户端代码，同样通过Thrift库调用服务端的Socket端口，实现RPC调用。

# 问题处理

Thrift 安装 https://www.jianshu.com/p/1af4df2b9649
- > 3、configure
  ```console
  在configure过程中，提示以下错误：
  ./configure: line 16656: syntax error near unexpected token `QT,'
  ./configure: line 16656: `    PKG_CHECK_MODULES(QT, QtCore >= 4.3, QtNetwork >= 4.3, have_qt=yes, have_qt=no)'
  
  解决方法：安装 apt-get install pkg-config
  ```
- > 4、make
  ```console
  make
  第一遇到的错误：command yacc is not found
  解决办法：sudo apt-get install flex bison
  ```

How to fix: fatal error: openssl/opensslv.h: No such file or directory in RedHat 7 https://stackoverflow.com/questions/46008624/how-to-fix-fatal-error-openssl-opensslv-h-no-such-file-or-directory-in-redhat
- https://stackoverflow.com/questions/46008624/how-to-fix-fatal-error-openssl-opensslv-h-no-such-file-or-directory-in-redhat/46008642#46008642
  * > To fix this problem, you have to install OpenSSL development package, which is available in standard repositories of all modern Linux distributions.
    ```console
    To install OpenSSL development package on Debian, Ubuntu or their derivatives:
    $ sudo apt-get install libssl-dev
    
    To install OpenSSL development package on Fedora, CentOS or RHEL:
    $ sudo yum install openssl-devel 
    ```

Thrift 的若干问题记录 https://www.cnblogs.com/gaowengang/p/12470301.html
