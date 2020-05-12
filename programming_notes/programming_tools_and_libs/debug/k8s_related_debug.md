
# Operator-SDK related Debug

How to setup my IDEA to debug the operator in golang locally? https://github.com/operator-framework/operator-sdk/issues/1315

Debug Kubernetes Operator-sdk locally using Vscode https://dev.to/austincunningham/debug-kubernetes-operator-sdk-locally-using-vscode-130k

# 个人实战

## vscode远程调试以 operator-sdk v0.15.0/v0.17.0 版本为工具的 applicationcompatibility-operator 项目

`////`注释掉的是lauch.json的默认值，新值是根据一个pdf攻略里的；`/* */`注释掉的是根据网上攻略写的但是不起作用的一个配置。

```
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
            "host": "9.46.86.154"
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
