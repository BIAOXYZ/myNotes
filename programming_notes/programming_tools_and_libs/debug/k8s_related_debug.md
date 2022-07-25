
K8s远程调试，你的姿势对了吗？ https://cloud.tencent.com/developer/article/1624638

# Operator-SDK related Debug

How to setup my IDEA to debug the operator in golang locally? https://github.com/operator-framework/operator-sdk/issues/1315

Debug Kubernetes Operator-sdk locally using Vscode https://dev.to/austincunningham/debug-kubernetes-operator-sdk-locally-using-vscode-130k

# 个人实战1: vscode远程调试以 operator-sdk v0.15.0/v0.17.0 版本为工具的 applicationcompatibility-operator 项目

## 说明

- `////`注释掉的是lauch.json的默认值，新值则是根据一个pdf攻略里的值填的；
- `"dlvLoadConfig":`那里的设置是从网上一个帖子（[解决vs code 调试golang时字符串显示不全的问题。](https://blog.csdn.net/bilinxing_/article/details/90737819)）里看到的，主要是解决有些变量值太长显示不全的问题，和远程调试operator本身无关。
- `/* */`注释掉的内容是根据网上另一篇攻略里的配置写的，但是不起作用的，可以无视了。

## 大概过程

### 0. linux服务器上go配置好，dlv什么的都搞定。

### 1. 首先项目clone到远端linux机器上，然后pdf攻略里是在mac上搞了个samba，把linux上项目代码让mac可以访问。——我这边是直接win10上vscode remote方式打开linux上的代码目录，更方便些。

### 2. 在`代码仓库根目录`下配置调试用的`launch.json`。建立`launch.json`的过程如下：
```
i.   Open the remote samba project in your VSC
ii.  Command + Shift + P and type Go: Install/Update Tools , select dlv and press OK
iii. Command + Shift + P and type Debug: Open launch.json and select go . This will create a file called
     launch.json under .vscode (Please make sure you do not check these in with your PRs)
iv.  Replace the content of launch.json with the following using your actual values for name, 
     remotePath, port and host
----------------------------------------------------------------------------------------------------
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "9.46.77.153",
            "type": "go",
            "request": "attach",
            "mode": "remote",
            "remotePath": "/root/go/src/github.ibm.com/IBMPrivateCloud/deployer-operator",
            "port": 2345,
            "host": "9.46.77.153"
        }
    ]
}     
```
>> ps：但是我怀疑可以在linux服务器上直接cd到代码仓库根目录下`mkdir .vscode; touch launch.json`，然后直接把正确的内容贴到`launch.json`里就行。但是我没试过，不过我觉得应该可以。

```sh
# 这个是我改过的肯定可以用的版本
[root@lolls-inf ~]# cat /root/cp4mcmrelated/gitrepo/applicationcompatibility-operator/.vscode/launch.json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",

    "configurations": [
        {
            ////"name": "Launch",
            "name": "9.46.86.154",
            "type": "go",
            ////"request": "launch",
            "request": "attach",
            ////"mode": "auto",
            "mode": "remote",
            ////"program": "${fileDirname}",
            ////"env": {},
            ////"args": []
            "remotePath": "/root/cp4mcmrelated/gitrepo/applicationcompatibility-operator",
            "port": 2345,
            "host": "9.46.86.154",

            "dlvLoadConfig": {
                "followPointers": true,
                "maxVariableRecurse": 1,
                "maxStringLen": 512, //字符串最大长度
                "maxArrayValues": 64,
                "maxStructFields": -1
            }
        }
    ]


    /*
    "configurations": [
        {
            "name": "9.46.86.154",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}/cmd/manager/main.go",
            "env": {
                "WATCH_NAMESPACE": "default"
            },
            "args": []
        }
    ]
    */
}

[root@lolls-inf ~]#
```

### 3. linux服务器上启动dlv
//（注意，不是在仓库根目录了，是在仓库根目录下的cmd目录下的manager目录，也就是有`main.go`的目录）

```sh
[root@lolls-inf manager]# pwd
/root/cp4mcmrelated/gitrepo/applicationcompatibility-operator/cmd/manager
[root@lolls-inf manager]# ls
main.go
[root@lolls-inf manager]# dlv debug --headless --listen=:2345 --log --api-version=2
API server listening at: [::]:2345
2020-05-11T20:56:54-07:00 info layer=debugger launching process with args: [/root/cp4mcmrelated/gitrepo/applicationcompatibility-operator/cmd/manager/__debug_bin]

```

### 4. vscode里 Run -- Start Debugging

```
In VSC go to Debug button on the left , select the newly created launch configuration and click
on Start debugging. Your MAC debugger will then connect to your headless debugger running
on your remote
```
