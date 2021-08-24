
# 参考

windows 10上使用vscode编译运行和调试C/C++ - tnnmigga的文章 - 知乎 https://zhuanlan.zhihu.com/p/77645306
- > 如果需要是c语言也就是gcc将下面的command项由g++改为gcc，如果是多文件编译（即函数声明和函数定义分开，不懂的别乱改），需要将args列表中的 `"${file}"` 项修改为 `"${workspaceFolder}/*.cpp"` ，多文件推荐用cmake
- > 事实上现在已经可以正常调试了，并且现在可以按 `ctrl+shift+b` 直接调用配置好的task***编译而不运行程序**，类似于一些IDE的编译选项
  
>> //notes：起因是在编译这个项目（ https://github.com/MegrezZhu/GradientBoostingDecisionTree ）时，不用vscode的话已经搞成了（**办法是修改其仓库里自带的makefile，改为编译debug版本；然后去下载一下libsvm格式的训练集和测试集；最后准备一份配置文件即可，稍微修改下原仓库自带的就行**。），但是想用vscode却不行。
>>> 之所以用vscode不行，就是因为编译不过，所以肯定是某些配置文件要改。后来搜到上面那个链接，看了看想到了应该是改 `task.json`。不过看下面这个stackexchange的问答，`task.json` 不只是为编译用的，而是可以成为任何一般性任务的配置。

What is the difference between launch.json and task.json in visual studio code? https://stackoverflow.com/questions/41483477/what-is-the-difference-between-launch-json-and-task-json-in-visual-studio-code/48297787
- https://stackoverflow.com/questions/41483477/what-is-the-difference-between-launch-json-and-task-json-in-visual-studio-code/48297787#48297787
  * > `launch.json` is used for to launch an app for debugging. It has settings geared for things like mapping to your workspace source code or defining the Chrome port to use.
  * > To use a configuration from `launch.json`, you select it on the Debug panel and click the run button.
  * > `tasks.json` is used to execute anything else you may want, be that source code formatters, bundlers or a SASS compiler.
  * > To use a configuration from `tasks.json`, you select Run Task from the command list.

# 个人实战

## 1. 在项目根目录下创建一个 `tmp` 目录，把需要的文件（注：这些文件仅和该项目有关，和通常的debug调试无关！）准备好：
  
- 配置文件 `conf`：
  ```console
  eta = 1.                 # shrinkage rate
  gamma = 0.               # minimum gain required to split a node
  maxDepth = 6             # max depth allowed
  minChildWeight = 1       # minimum allowed size for a node to be splitted
  rounds = 1               # REQUIRED. number of subtrees
  subsample = 1.           # subsampling ratio for each tree
  colsampleByTree = 1.     # tree-wise feature subsampling ratio
  maxThreads = 1;          # max running threads
  features = 123;          # REQUIRED. number of features
  validateSize = .2        # if greater than 0, input data will be split into two sets and used for training and validation repectively
  ```
- `libsvm`格式的训练集和测试集，直接从官方【 [LIBSVM Data: Classification (Binary Class)](https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html) 】下载或者用别的格式转。
  * `wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a9a`
  * `wget https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a9a.t`
- 输出文件`output`甚至不需要提前准备，会自动生成。

## 2. 添加如下两个配置文件（很容易看出来，这里 `task.json` 是负责把二进制文件编译出来的任务；`launch.json` 负责调试。这俩都有 `"args"` 参数，是为了不同的任务设置的）。

**`launch.json`**：
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
            //"program": "${fileDirname}/boost",
            "program": "${workspaceFolder}/boost",
            //"args": [],
            "args": ["tmp/conf", "tmp/a9a", "tmp/a9a.t", "tmp/output"],
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
            ],
            "preLaunchTask": "C/C++: g++ build active file",
            "miDebuggerPath": "/usr/bin/gdb"
        }
    ]
}
```

**`task.json`**：
```json
{
    "tasks": [
        {
            "type": "cppbuild",
            "label": "C/C++: g++ build active file",
            "command": "/usr/bin/g++",
            // "args": [
            //     "-g",
            //     "${file}",
            //     "-o",
            //     "${fileDirname}/${fileBasenameNoExtension}"
            // ],
            "args": [
                "-g",
                "-fopenmp",
                "-m64",
                "-o",
                "boost",
                "${workspaceFolder}/GBDT/src/main.cpp",
                "${workspaceFolder}/GBDT/src/lib/logger.cpp",
                "${workspaceFolder}/GBDT/src/lib/util.cpp",
                "${workspaceFolder}/GBDT/src/lib/gbdt.cpp",
                "${workspaceFolder}/GBDT/src/lib/regression_tree.cpp",
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
            },
            "detail": "Task generated by Debugger."
        }
    ],
    "version": "2.0.0"
}
```

>> //notes：其实后来想到（并且试过了），也可以（像之前的一些工程一样）不用配置 `task.json`，而是注释掉 `launch.json` 里这一行：`"preLaunchTask": "C/C++: g++ build active file"`；当需要调试时，在linux命令行里把debug版的二进制编出来，然后在vsc里启动调试即可 —— 这么修改的效果，说白了就是不要每次启动调试时再额外新编译一个二进制了，直接用项目里已有的。

## 3. 打好断点，`F5`启动调试即可。

>> //notes：但是我发现这个配置比较好的一点是：似乎不像某些配置必须从 `main.cpp` 文件那里按`F5`启动调试，这个配置从任何文件的位置都可以按`F5`启动调试。
>>> 后来想了想，尤其是对比了之前 `aby3` 项目的[配置攻略](cpp_example2.md)，觉得基本是 `${workspaceFolder}` 代替 `${fileDirname}` 的原因 —— 后者明显必须从指定的目录启动调试，而前者和启动调试的目录无关（更准确地说法是：**前者使用 `${workspaceFolder}` 那种写法不会影响生成的待调试的二进制文件的位置**）！

## 4. 补充

对于单步调试来说，数据集还是比较大。于是从 `a9a` 和 `a9a.t` 里各取了前十行，另存为 `ba9a` 和 `ba9a.t`，单步调试时其实用的是这两个。
```sh
$ cat ba9a
-1 3:1 11:1 14:1 19:1 39:1 42:1 55:1 64:1 67:1 73:1 75:1 76:1 80:1 83:1 
-1 5:1 7:1 14:1 19:1 39:1 40:1 51:1 63:1 67:1 73:1 74:1 76:1 78:1 83:1 
-1 3:1 6:1 17:1 22:1 36:1 41:1 53:1 64:1 67:1 73:1 74:1 76:1 80:1 83:1 
-1 5:1 6:1 17:1 21:1 35:1 40:1 53:1 63:1 71:1 73:1 74:1 76:1 80:1 83:1 
-1 2:1 6:1 18:1 19:1 39:1 40:1 52:1 61:1 71:1 72:1 74:1 76:1 80:1 95:1 
-1 3:1 6:1 18:1 29:1 39:1 40:1 51:1 61:1 67:1 72:1 74:1 76:1 80:1 83:1 
-1 4:1 6:1 16:1 26:1 35:1 45:1 49:1 64:1 71:1 72:1 74:1 76:1 78:1 101:1 
+1 5:1 7:1 17:1 22:1 36:1 40:1 51:1 63:1 67:1 73:1 74:1 76:1 81:1 83:1 
+1 2:1 6:1 14:1 29:1 39:1 42:1 52:1 64:1 67:1 72:1 75:1 76:1 82:1 83:1 
+1 4:1 6:1 16:1 19:1 39:1 40:1 51:1 63:1 67:1 73:1 75:1 76:1 80:1 83:1 
$ 
$ cat ba9a.t 
-1 1:1 6:1 17:1 21:1 35:1 42:1 54:1 62:1 71:1 73:1 74:1 76:1 80:1 83:1 
-1 3:1 6:1 14:1 22:1 36:1 40:1 56:1 63:1 67:1 73:1 74:1 76:1 82:1 83:1 
+1 2:1 10:1 18:1 24:1 38:1 40:1 59:1 63:1 67:1 73:1 74:1 76:1 80:1 83:1 
+1 4:1 6:1 16:1 20:1 37:1 40:1 54:1 63:1 71:1 73:1 75:1 76:1 80:1 83:1 
-1 1:1 14:1 20:1 37:1 42:1 62:1 67:1 72:1 74:1 76:1 78:1 83:1 
-1 3:1 6:1 17:1 31:1 35:1 42:1 49:1 64:1 67:1 73:1 74:1 76:1 78:1 83:1 
-1 2:1 17:1 22:1 36:1 42:1 66:1 71:1 73:1 74:1 76:1 80:1 83:1 
+1 5:1 7:1 14:1 23:1 39:1 40:1 52:1 63:1 67:1 73:1 75:1 76:1 78:1 83:1 
-1 1:1 6:1 18:1 20:1 37:1 42:1 49:1 66:1 67:1 72:1 74:1 76:1 80:1 83:1 
-1 5:1 6:1 14:1 27:1 35:1 40:1 48:1 63:1 67:1 73:1 74:1 76:1 78:1 83:1 
$ 
```

然后只需要把 **`launch.json`** 里的这一行 `"args": ["tmp/conf", "tmp/a9a", "tmp/a9a.t", "tmp/output"],` 改成 `"args": ["tmp/conf", "tmp/ba9a", "tmp/ba9a.t", "tmp/output"],` 即可。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 补充：另外一种调试方式：通过修改项目自带的 `makefile`，然后命令行gdb调试

## 1. 与前面的第一步相同，同样要准备配置文件、训练集、预测集、输出文件。

## 2. 修改 `makefile`，可以生成debug版本程序（`-g` 后面的 `-Ddebug` 似乎省略掉也没问题）。

// 修改后的 `makefile`：
```makefile
src = GBDT/src
build_dir = build
target = boost
objects = $(build_dir)/main.o $(build_dir)/logger.o $(build_dir)/util.o $(build_dir)/gbdt.o $(build_dir)/regression_tree.o

ver = debug
ifeq ($(ver), debug)
cc = g++ -std=c++14 -g -Ddebug -fopenmp -m64
else
cc = g++ -std=c++17 -O3 -fopenmp -m64
endif

all: $(build_dir) $(target)

$(build_dir):
	mkdir -p $(build_dir)

$(target): $(objects)
	$(cc) -o $(target) $(objects)

$(build_dir)/main.o: $(src)/main.cpp $(src)/lib/util.h $(src)/lib/logger.h $(src)/lib/regression_tree.h $(src)/lib/gbdt.h
	$(cc) -c $(src)/main.cpp -o $(build_dir)/main.o
$(build_dir)/util.o: $(src)/lib/util.cpp $(src)/lib/util.h $(src)/lib/logger.h
	$(cc) -c $(src)/lib/util.cpp -o $(build_dir)/util.o
$(build_dir)/logger.o: $(src)/lib/logger.cpp $(src)/lib/logger.h
	$(cc) -c $(src)/lib/logger.cpp -o $(build_dir)/logger.o
$(build_dir)/regression_tree.o: $(src)/lib/regression_tree.cpp $(src)/lib/regression_tree.h $(src)/lib/util.h $(src)/lib/logger.h
	$(cc) -c $(src)/lib/regression_tree.cpp -o $(build_dir)/regression_tree.o
$(build_dir)/gbdt.o: $(src)/lib/gbdt.cpp $(src)/lib/regression_tree.h $(src)/lib/gbdt.h $(src)/lib/logger.h
	$(cc) -c $(src)/lib/gbdt.cpp -o $(build_dir)/gbdt.o

.PHONY: clean
clean:
	rm -rf $(build_dir) $(target)

```

// 额外记录一下为了debug单步调试，`makefile` 相比原版都改了些啥。
```diff
$ git diff
diff --git a/makefile b/makefile
index a0d292c..f0ea513 100644
--- a/makefile
+++ b/makefile
@@ -2,7 +2,13 @@ src = GBDT/src
 build_dir = build
 target = boost
 objects = $(build_dir)/main.o $(build_dir)/logger.o $(build_dir)/util.o $(build_dir)/gbdt.o $(build_dir)/regression_tree.o
+
+ver = debug
+ifeq ($(ver), debug)
+cc = g++ -std=c++14 -g -Ddebug -fopenmp -m64
+else
 cc = g++ -std=c++17 -O3 -fopenmp -m64
+endif

 all: $(build_dir) $(target)
```

## 在项目根目录执行 `make` 后，即可生成可调试的二进制文件。

// 其背后调用的命令是：
```sh
$ make
g++ -std=c++14 -g -Ddebug -fopenmp -m64 -o boost build/main.o build/logger.o build/util.o build/gbdt.o build/regression_tree.o
```
