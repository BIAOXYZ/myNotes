
# 0.HyperledgerFabric之Idemix实战

https://github.com/BIAOXYZ/MATERIALSTORE1/tree/master/2018/20181120_Hyperledger%20Idemix%E5%AE%9E%E6%88%98

# 1.安装docker，docker-compose，go语言环境

这一步不再赘述。已经有总结了。

# 2.下载Fabric源码并编译

- Docs » 快速入门 https://hyperledger-fabric.readthedocs.io/en/latest/dev-setup/build.html
- Building Hyperledger Fabric https://hyperledgercn.github.io/hyperledgerDocs/getting_started/

## 过程

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

- 1-快速搭建一个Fabric1.0环境  |  基于shell脚本的方式 - 苏晓乐的文章 - 知乎 https://zhuanlan.zhihu.com/p/35063055 [:star:]

## 过程

进入`fabric/examples/e2e_cli`目录并执行:
```
./network_setup.sh up
```

我们首先进入CLI，我们重新打开一个命令行窗口，输入：
```
docker exec -it cli bash
```

运行以下命令可以查询a账户的余额：
```
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
```

然后，我们试一试把a账户的余额再转20元给b账户，运行命令：
```
peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -c '{"Args":["invoke","a","b","20"]}'
```

再次查询a账户：
```
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
```

****************************************************************************************************
****************************************************************************************************
****************************************************************************************************
至此，Fabric区块链网络搭建成功，不过其实大部分步骤是通过运行e2e_cli脚本自动完成的。后面会手动完成这一步骤，并在该过程中带上idemix。
****************************************************************************************************
****************************************************************************************************
****************************************************************************************************


# 4.手动运行搭建和运行Fabric网络

- 手动搭建Fabric网络-详解链码安装、实例化过程 - 苏晓乐的文章 - 知乎 https://zhuanlan.zhihu.com/p/35363316 [:star:]
- 注：另外，该过程还需参考代码对应目录下的一些（最新的）shell脚本，应该是攻略还是会慢慢过时的原因。

## 过程

```
cd examples/e2e_cli/

../../.build/bin/cryptogen generate --config=./crypto-config.yaml  # 生成需要的
```

```
// 这个是那个博文里的，实际上报错后没再用这句了，用的fabric代码库脚本里的
../../.build/bin/configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

//报错：
2018-11-26 16:15:40.929 CST [common/tools/configtxgen] main -> INFO 002 Loading configuration
2018-11-26 16:15:40.987 CST [common/tools/configtxgen/encoder] New -> PANI 003 Error creating channel group: could not create consortiums group: failed to create consortium SampleConsortium: failed to create consortium org: 1 - Error loading MSP configuration for org: Org3MSP: failed to read issuer public key file: could not read file /home/test2/go/src/github.com/hyperledger/fabric/examples/e2e_cli/crypto-config/idemix/idemix-config/msp/IssuerPublicKey: open /home/test2/go/src/github.com/hyperledger/fabric/examples/e2e_cli/crypto-config/idemix/idemix-config/msp/IssuerPublicKey: no such file or directory
2018-11-26 16:15:40.987 CST [common/tools/configtxgen] func1 -> PANI 004 Error creating channel group: could not create consortiums group: failed to create consortium SampleConsortium: failed to create consortium org: 1 - Error loading MSP configuration for org: Org3MSP: failed to read issuer public key file: could not read file /home/test2/go/src/github.com/hyperledger/fabric/examples/e2e_cli/crypto-config/idemix/idemix-config/msp/IssuerPublicKey: open /home/test2/go/src/github.com/hyperledger/fabric/examples/e2e_cli/crypto-config/idemix/idemix-config/msp/IssuerPublicKey: no such file or directory


//所以，可见现在idemix似乎是标配了。生成配置之前得先生成idemix要用的组件。
../../.build/bin/idemixgen ca-keygen
../../.build/bin/idemixgen signerconfig -u OU1 -e OU1 -r 1
//执行完这两句得把生成的idemix-config目录拷贝到crypto-config目录下的（自己新建的）idemix目录里。

//继续生成各种配置，不过这里用的是脚本里的代码，简单改了一下，替换变量名什么的。
../../.build/bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID e2e-orderer-syschan -outputBlock ./channel-artifacts/genesis.block
../../.build/bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel
../../.build/bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
../../.build/bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP
```

```
修改docker-compose-cli.yaml并注释掉cli中command这一行
```

启动Fabric环境的容器：
```
test2@localhost:e2e_cli {release-1.3}\> docker-compose -f docker-compose-cli.yaml up -d
Creating network "e2e_default" with the default driver
Creating zookeeper1             ... done
Creating zookeeper0             ... done
Creating peer1.org1.example.com ... done
Creating peer0.org2.example.com ... done
Creating zookeeper2             ... done
Creating peer0.org1.example.com ... done
Creating peer1.org2.example.com ... done
Creating kafka3                 ... done
Creating kafka2                 ... done
Creating kafka0                 ... done
Creating kafka1                 ... done
Creating orderer.example.com    ... done
Creating cli                    ... done
```

### 创建channel

```
进入CLI内部：
docker exec -it cli bash
```

```
设置一个环境变量方便后续使用：
ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
```

```
创建channel：
peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_CA
```

```
CLI默认连接的是peer0.org1，所以只要这一句就可以：
peer channel join -b mychannel.block
```

