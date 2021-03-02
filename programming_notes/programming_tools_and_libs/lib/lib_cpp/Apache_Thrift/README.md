
# 官方

Apache Thrift https://github.com/apache/thrift

Apache Thrift https://thrift.apache.org/
- C++ Tutorial https://thrift.apache.org/tutorial/cpp.html

# 其他

Thrift by Example https://thrift-tutorial.readthedocs.io/en/latest/usage-example.html

Apache Thrift – 可伸缩的跨语言服务开发框架 https://developer.ibm.com/zh/languages/java/tutorials/j-lo-apachethrift/

Apache Thrift系列详解(一) - 概述与入门 https://juejin.cn/post/6844903622380093447

由浅入深了解Thrift（一）——Thrift介绍与用法 https://blog.csdn.net/houjixin/article/details/42778335

使用Thrift来实现跨语言的方法调用 http://www.bjhee.com/thrift.html `[1]`
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

# 个人实战

## 主要参考文章 `[1]`

Katacoda Ubuntu Playground https://www.katacoda.com/courses/ubuntu/playground
```sh
mkdir test
cd test
sudo apt update
sudo apt install -y gcc g++ openssl libboost-all-dev python-dev
# 下面这行apt里是需要自己装的
apt install -y automake pkg-config flex bison libssl-dev

git clone https://github.com/apache/thrift.git
cd thrift/
git checkout -b 0.13.0 origin/0.13.0

./bootstrap.sh
# ./configure --without-go --without-java --without-ruby 

# 原文是上面这句，编不过。后来看了官方github，应该是这个flag不可少： --with-boost=/usr/lib/x86_64-linux-gnu
./configure --with-as3=no --with-qt5=no --with-csharp=no --with-java=no --with-erlang=no --with-nodejs=no --with-nodets=no --with-lua=no --with-perl=no --with-php=no --with-php_extension=no --with-py3=no --with-dart=no --with-ruby=no --with-haskell=no --with-go=no --with-swift=no --with-rs=no --with-cl=no --with-haxe=no --with-dotnetcore=no --with-d=no --with-boost=/usr/lib/x86_64-linux-gnu

make -sj8
sudo make install

cd tutorial/
cat << EOF > tester.thrift
// 定义命名空间
namespace php mytest
namespace py mytest
namespace cpp mytest

typedef i32 Int  // 类型名称映射，将32位整型映射位Int类型

// 定义服务接口，接口中提供两个方法。
service Tester
{
	Int add(1:Int num1, 2:Int num2),  // 整数加法
	string merge(1:string str1, 2:string str2),  // 字符串连接
}
EOF

thrift -r --gen py tester.thrift
thrift -r --gen cpp tester.thrift

cat << EOF > gen-py/TesterServer.py
import glob
import sys
sys.path.append('../gen-py')  # Changed
sys.path.insert(0, glob.glob('../../lib/py/build/lib*')[0])

from mytest import Tester  # Changed
from mytest.ttypes import *  # Changed

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

# Changed
class TesterHandler:
    def __init__(self):
        self.log = {}

    def add(self, num1, num2):
        print('add(%d, %d) is called' % (num1, num2))
        return num1 + num2

    def merge(self, str1, str2):
        print('merge(%s, %s) is called' % (str1, str2))
        return str1 + str2

if __name__ == '__main__':
    handler = TesterHandler()  # Changed
    processor = Tester.Processor(handler)  # Changed
    transport = TSocket.TServerSocket(host='127.0.0.1', port=9090)
    tfactory = TTransport.TBufferedTransportFactory()
    pfactory = TBinaryProtocol.TBinaryProtocolFactory()

    server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)

    print('Starting the server...')
    server.serve()
    print('done.')
EOF

cat << EOF > gen-py/TesterClient.py
import sys
import glob
sys.path.append('../gen-py')  # Changed
sys.path.insert(0, glob.glob('../../lib/py/build/lib*')[0])

from mytest import Tester  # Changed
from mytest.ttypes import *  # Changed

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

def main():
    transport = TSocket.TSocket('localhost', 9090)
    transport = TTransport.TBufferedTransport(transport)
    protocol = TBinaryProtocol.TBinaryProtocol(transport)
    client = Tester.Client(protocol)
    transport.open()

    sum_ = client.add(3, 4)
    print('3 + 4 = %d' % sum_)
    # Changed
    str_ = client.merge('Hello ', 'Python')
    print('Hello + Python = %s' % str_)

    transport.close()

if __name__ == '__main__':
    try:
        main()
    except Thrift.TException as tx:
        print('%s' % tx.message)
EOF

$ cd gen-py/
$ python TesterServer.py 
Starting the server...
add(3, 4) is called
merge(Hello , Python) is called

# 新开个窗口
$ cd test/thrift/tutorial/gen-py/
$ python TesterClient.py 
3 + 4 = 7
Hello + Python = Hello Python
```

```sh
# 编译C++部分（目前还没成功）

export LD_LIBRARY_PATH=/root/test/thrift/lib/cpp/.libs:$LD_LIBRARY_PATH

cd ../
cat << EOF > gen-cpp/TesterServer.cpp
#include <thrift/concurrency/ThreadManager.h>
#include <thrift/concurrency/ThreadFactory.h>
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/server/TThreadPoolServer.h>
#include <thrift/server/TThreadedServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>
#include <thrift/TToString.h>

#include <iostream>
#include <stdexcept>
#include <sstream>

#include "../gen-cpp/Tester.h"  // Changed

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::concurrency;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using namespace apache::thrift::server;

using namespace mytest;  // Changed

// Changed
class TesterHandler : public TesterIf {
public:
  TesterHandler() = default;

  Int add(const Int num1, const Int num2) override {
    cout << "add(" << num1 << ", " << num2 << ") is called" << endl;
    return num1 + num2;
  }

  void merge(std::string& _return, const std::string& str1, const std::string& str2) override {
    cout << "merge(" << str1 << ", " << str2 << ") is called" << endl;
    char buffer[str1.length() + str2.length() + 1];
    sprintf(buffer, "%s%s", str1.c_str(), str2.c_str());
    _return = buffer;
    return;
  }
};

// Changed
class TesterCloneFactory : virtual public TesterIfFactory {
 public:
  ~TesterCloneFactory() override = default;
  TesterIf* getHandler(const ::apache::thrift::TConnectionInfo& connInfo) override
  {
    std::shared_ptr<TSocket> sock = std::dynamic_pointer_cast<TSocket>(connInfo.transport);
    cout << "Incoming connection\n";
    cout << "\tSocketInfo: "  << sock->getSocketInfo() << "\n";
    cout << "\tPeerHost: "    << sock->getPeerHost() << "\n";
    cout << "\tPeerAddress: " << sock->getPeerAddress() << "\n";
    cout << "\tPeerPort: "    << sock->getPeerPort() << "\n";
    return new TesterHandler;
  }
  void releaseHandler( ::mytest::TesterIf* handler) override {
    delete handler;
  }
};

int main() {
  TThreadedServer server(
    std::make_shared<TesterProcessorFactory>(std::make_shared<TesterCloneFactory>()),  // Changed
    std::make_shared<TServerSocket>(9090), //port
    std::make_shared<TBufferedTransportFactory>(),
    std::make_shared<TBinaryProtocolFactory>());

  cout << "Starting the server..." << endl;
  server.serve();
  cout << "Done." << endl;
  return 0;
}
EOF


cat << EOF > gen-cpp/TesterClient.cpp
#include <iostream>

#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>

#include "../gen-cpp/Tester.h"  // Changed

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

using namespace mytest;  // Changed

int main() {
  std::shared_ptr<TTransport> socket(new TSocket("localhost", 9090));
  std::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
  std::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));
  TesterClient client(protocol);    // Changed

  try {
    transport->open();

    cout << "5 + 6 = " << client.add(5, 6) << endl;
    // Changed
    std::string result;
    client.merge(result, "Hello ", "C++");
    cout << "Hello + C++ = " << result << endl;

    transport->close();
  } catch (TException& tx) {
    cout << "ERROR: " << tx.what() << endl;
  }
}
EOF

cd gen-cpp/

# 目前这里编不过。
g++ -o TesterServer tester_constants.cpp tester_types.cpp Tester.cpp TesterServer.cpp -lthrift
g++ -o TesterClient tester_constants.cpp tester_types.cpp Tester.cpp TesterClient.cpp -lthrift
```
