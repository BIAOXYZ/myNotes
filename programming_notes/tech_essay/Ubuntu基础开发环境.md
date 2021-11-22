
# `ubuntu-20.04.3-desktop-amd64.iso`

```sh
cat << EOF > setup-env.sh
#!/usr/bin/env bash
sudo apt update
sudo apt install -y git cmake automake autoconf libtool
sudo apt install -y vim wget curl openssh-server
sudo apt install -y python3-pip
sudo apt install -y docker.io
systemctl enable docker
sudo apt install -y ansible

# FOR -- `lex` and `yacc`
sudo apt install -y flex bison
# FOR -- `pyenv`
sudo apt-get install -y libreadline-dev libssl-dev libbz2-dev libsqlite3-dev
EOF
```

# `pyenv`

## 1

Ubuntu下pyenv install 3.6.5 build失败 https://www.jianshu.com/p/a8f6c5f6b273
```sh
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev
```

## 2

***`(0)`*** 然而即使是已经能成功用 `pyenv` 安装某些版本的 python，因为openssl库版本的问题，还是有些版本的 python 装不上，官方说明如下：

ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib? https://github.com/pyenv/pyenv/wiki/Common-build-problems#error-the-python-ssl-extension-was-not-compiled-missing-the-openssl-lib
```console
2. Your OpenSSL version is incompatible with the Python version you're trying to install
Old Python versions (for CPython, <3.5.3 and <2.7.13) require OpenSSL 1.0 while newer systems provide 1.1, and vice versa.
Note that OpenSSL 1.0 is EOL and by now practically unusable on the Internet due to using obsolete standards.

Install the right OpenSSL version, and point the build to its location as per above if needed.

E.g.:

On Debian stretch and Ubuntu bionic, libssl-dev is OpenSSL 1.1.x, but support for that was only added in Python 2.7.13, 3.5.3 and 3.6.0. To install earlier versions, you need to replace libssl-dev with libssl1.0-dev.

sudo apt-get remove libssl-dev
sudo apt-get update
sudo apt-get install libssl1.0-dev
pyenv/pyenv/issues/945#issuecomment-409627448 has a more complex workaround that preserves libssl-dev.
```

***`(1)`*** 之前已经解决了各种库依赖，已经能成功安装一些python版本，比如 `3.6.5`。但是发现装 `2.7.11` 时候还是提示 openssl 库依赖问题。
```sh
$ pyenv install 3.6.5
Downloading Python-3.6.5.tar.xz...
-> https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz
Installing Python-3.6.5...
Installed Python-3.6.5 to /home/bytedance/.pyenv/versions/3.6.5

$ pyenv versions
* system (set by /home/bytedance/.pyenv/version)
  3.6.5
$ 
$ pyenv install 2.7.11
Downloading Python-2.7.11.tar.xz...
-> https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz
Installing Python-2.7.11...
ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?

Please consult to the Wiki page to fix the problem.
https://github.com/pyenv/pyenv/wiki/Common-build-problems


BUILD FAILED (Ubuntu 20.04 using python-build 20180424)
```

***`(2)`*** 后来看了官方wiki（参见前面第 ***`(0)`*** 部分）才知道是因为有些老旧的python版本（`for CPython, <3.5.3 and <2.7.13`）编译安装依赖 `OpenSSL 1.0`，然而其他是依赖 `OpenSSL 1.1` 的。所以最后直接安了python `2.7.14` 了事。。。
```sh
$ pyenv install 2.7.14
Downloading Python-2.7.14.tar.xz...
-> https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
Installing Python-2.7.14...
Installed Python-2.7.14 to /home/bytedance/.pyenv/versions/2.7.14

$ 
```

# Java

如何在 Ubuntu 20.04 上安装 Java - 雪梦科技的文章 - 知乎 https://zhuanlan.zhihu.com/p/137114682
- > **二、安装 OpenJDK 11**
```
sudo apt update
sudo apt install openjdk-11-jdk
```
- > **三、安装 OpenJDK 8**
```sh
sudo apt update
sudo apt install openjdk-8-jdk
```

How To Install Java with Apt on Ubuntu 18.04 https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
