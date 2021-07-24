
# vsc C++ debug

C/C++ for Visual Studio Code https://code.visualstudio.com/docs/languages/cpp
- Debug C++ in Visual Studio Code https://code.visualstudio.com/docs/cpp/cpp-debug
  * > `To learn more, see Configuring C/C++ debugging.` -- Configuring C/C++ debugging https://code.visualstudio.com/docs/cpp/launch-json-reference
  * > `If you are debugging with GDB on Windows, see Windows Debugging with MinGW64.` -- Using GCC with MinGW https://code.visualstudio.com/docs/cpp/config-mingw

>> //notes：其实主要是MinGW没那么好下，即使是在官方主页上（不注意会下那个默认版本，解压后里面没有`bin`目录，不能用！）也容易下错。下面这俩至少都试过了可以用。

Run, Debug & get IntelliSense for C C++ in VSCode https://dev.to/jerrygoyal/run-debug-get-intellisense-for-c-c-in-vscode-4e0o  `【2】`
- > Windows: Download [MinGW64.zip](https://github.com/GorvGoyl/MinGW64/releases) (latest release) and extract it to the C Drive.
- > VSCode can create and auto-configure these files if we try to debug for the first time. To do that, open C++ file in VSCode and either hit F5 or go to Debug -> Start Debugging and select ***`C++ (GDB/LLDB)`*** then select g++.exe build and debug active file.

Visual Studio Code 如何编写运行 C、C++ 程序？ - 知乎 https://www.zhihu.com/question/30315894
- Visual Studio Code 如何编写运行 C、C++ 程序？ - 谭九鼎的回答 - 知乎 https://www.zhihu.com/question/30315894/answer/154979413  `【1】`
  * > 下载编译器：[MinGW-w64 - for 32 and 64 bit Windows](https://sourceforge.net/projects/mingw-w64/files/) 往下稍微翻一下，选最新版本中的***`x86_64-posix-seh`***。最好不要用 Download Latest Version，这个是在线安装包，可能因为国内的“网络环境”下载失败。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 个人实战1（Windows下）

>> //notes：主要参考`【1】`，其次参考`【2】`，总结出了一个至少可以成功单步调试的配置：
- 新建一个文件夹，里面随便放个c++文件，比如：`test-infolder.cpp`。
```cpp
// main.cpp
#include <iostream>
using namespace std;

int main()
{
    int result;
    int a = 2;
    int b = 3;
    result = a + b;
    cout << result << endl;
    return 0;
}
```
- 安装`官方C/C++`插件，`Code Runner`插件我也装了（但是我试了下，disable掉这个插件也可以单步。所以应该是不装这个也可以）。
- 安装MinGW。我是安到了`C:\MinGW64`下，也就是说`gdb.exe`的完整路径是：`C:\MinGW64\bin\gdb.exe`。
- 最关键的`launch.json`和`tasks.json`分别如下：

`launch.json`
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "test win debug",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "C:\\MinGW64\\bin\\gdb.exe",
            "setupCommands": [
                {
                    "description": "为 gdb 启用整齐打印",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "Compile"
        }    
    ]
}
```
`tasks.json`
```json
{
    "tasks": [
        {
            "type": "process",
            "label": "Compile",
            "command": "C:\\MinGW64\\bin\\g++.exe",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ],
    "version": "2.0.0"
}
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 个人实战2（Linux下）

1. 文件名就是 `debug.cpp`，编译时候要加 `-g` 编debug版本，整个语句是：`g++ debug.cpp -g -o debug`
```cpp
#include <iostream>
using namespace std;

int add_five(int x) {
    for (int i = 0; i < 5; ++i) {
        x += 1;
    }
    return x;
}

int main() {

    int n = 3;
    cout << "start" << endl;
    int m = add_five(n);
    return m;

}
```

2. `launch.json` 内容如下：
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/debug",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

3. 在vscode里打开代码的workspace，打好断点，`F5`即可。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
