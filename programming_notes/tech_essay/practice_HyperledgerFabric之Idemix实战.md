
# 0.

# 1. 安装docker，docker-compose，go语言环境

这一步不再赘述。已经有总结了。

# 2.下载Fabric源码并编译

- Docs » 快速入门 https://hyperledger-fabric.readthedocs.io/en/latest/dev-setup/build.html
- Building Hyperledger Fabric https://hyperledgercn.github.io/hyperledgerDocs/getting_started/

在 GOPATH/src/github.com/hyperledger/ 目录下执行：
```
git clone https://github.com/hyperledger/fabric.git
```

进入fabric目录执行：
```
make dist-clean all
```

跑一下全量测试用例：
```
make unit-test
```
```
//这里之所以有些用例不过是因为查了下CentOS下couchDB镜像有问题，得自己编译还是怎么回事。总之系统问题，暂时不管了。
...
...
unit-tests_1_de8bd23ee673 | ?           github.com/hyperledger/fabric/common/tools/cryptogen    [no test files]
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/cryptogen/ca 0.029s  coverage: 95.6% of statements
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/cryptogen/csp        0.023s  coverage: 88.9% of statements
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/cryptogen/metadata   0.004s  coverage: 66.7% of statements
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/cryptogen/msp        0.078s  coverage: 84.3% of statements
unit-tests_1_de8bd23ee673 | ?           github.com/hyperledger/fabric/common/tools/idemixgen    [no test files]
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/idemixgen/idemixca   0.487s  coverage: 81.6% of statements
unit-tests_1_de8bd23ee673 | ok          github.com/hyperledger/fabric/common/tools/idemixgen/metadata   0.004s  coverage: 66.7% of statements
...
...
```

# 3.运行e2e例子

- 1-HyperLedger实战-快速搭建一个Fabric1.0环境 - 苏小乐的文章 - 知乎 https://zhuanlan.zhihu.com/p/35063055

