
VSCode 配置文件的变量索引 - WuYuanhun的文章 - 知乎 https://zhuanlan.zhihu.com/p/44967536
- 【[:star:][`*`]】 Variables Reference https://code.visualstudio.com/docs/editor/variables-reference

# 个人实战

>> //notes：下面就是以 https://github.com/ladnir/aby3 这个开源项目为例，说明 `launch.json` 里的各种 ***Variable*** 应该根据项目编译出的二进制文件的不同，来选择和修改。这个项目的调试需要执行编译生成的 `./frontend/frontend.exe`（不用被后缀迷惑，linux下也是有这个`.exe`后缀的，不影响），注意到这里生成的***二进制文件名***和***相对目录名***相同，并且还得额外加个`.exe`，所以配置文件里就那么改了。。。
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "g++ - Build and debug active file",
            "type": "cppdbg",
            "request": "launch",
            //"program": "${fileDirname}/${fileBasenameNoExtension}.exe",
            "program": "${fileDirname}/${relativeFileDirname}.exe",
            "args": ["-linear-plain"],
            //"args": ["-linear -p 0"],
            ///"args": ["-logistic-plain"],
            "stopAtEntry": false,
            //"cwd": "${workspaceFolder}",
            "cwd": "${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            //"preLaunchTask": "C/C++: g++ build active file",
            "miDebuggerPath": "/usr/bin/gdb"
        }
    ]
}
```
