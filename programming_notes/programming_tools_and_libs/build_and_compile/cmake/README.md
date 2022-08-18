
# 官方

CMake https://github.com/Kitware/CMake
- > Mirror of CMake upstream repository https://gitlab.kitware.com/cmake/cmake

CMake Tutorial https://cmake.org/cmake/help/v3.19/guide/tutorial/index.html

## 中文版（应该是机翻）

CMake 3.21 (中文) https://runebook.dev/zh-CN/docs/cmake/-index-

# 系统性攻略

cmake使用教程（十一）-使用cpack打包源码并编写自动化脚本上传到仓库 https://juejin.cn/post/6844903641443205128

【[:star:][`*`]】 CMake Examples https://github.com/ttroy50/cmake-examples || http://ttroy50.github.io/cmake-examples/

【[:star:][`*`]】 CGold: The Hitchhiker’s Guide to the CMake https://cgold.readthedocs.io/en/latest/index.html || https://github.com/ruslo/CGold

【[:star:][`*`]】 CMake Cookbook https://github.com/dev-cafe/cmake-cookbook || CMake菜谱（CMake Cookbook中文版） https://www.bookstack.cn/books/CMake-Cookbook
- 本书相关
  * github翻译地址： https://github.com/xiaoweiChen/CMake-Cookbook
  * gitbook 在线阅读： https://app.gitbook.com/@chenxiaowei/s/cmake-cookbook/
- `4.4 使用Boost Test进行单元测试` https://www.bookstack.cn/read/CMake-Cookbook/content-chapter4-4.4-chinese.md
  * https://github.com/dev-cafe/cmake-cookbook/tree/v1.0/chapter-04/recipe-04

CMake Tutorial https://medium.com/@onur.dundar1/cmake-tutorial-585dd180109b

CMake 入门 https://zh.wikibooks.org/wiki/CMake_%E5%85%A5%E9%96%80
- CMake 入门/运算子 https://zh.wikibooks.org/zh-hans/CMake_%E5%85%A5%E9%96%80/%E9%81%8B%E7%AE%97%E5%AD%90

CMake：
- CMake Day 3 —— 编译二进制或库 https://blog.csdn.net/qq_34347375/article/details/110672947
- CMake Day 4 —— 设置头文件路径和链接库 https://azmddy.github.io/article/%E7%BC%96%E8%AF%91%E6%9E%84%E5%BB%BA/cmake-day-4.html

# 其他攻略

【使用CMake组织C++工程】2：CMake 常用命令和变量 https://elloop.github.io/tools/2016-04-10/learning-cmake-2-commands

使用CMake https://frostime.github.io/2019/03/30/%E4%BD%BF%E7%94%A8CMake/

带你看 CMake https://www.jianshu.com/p/9e8e0566ccc5
- > 说在前面
  * > 6.cmake 指定开关 `-DXXX=XX` eg：`-DOPT1=ON`
- > 指定编译参数
  * > note: 请这样设置 `set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")` 否则会导致修改系统的 `CXXFLAGS`。

CMake 学习笔记 https://www.jianshu.com/p/c417e4ab8b30

VS Code与CMake真乃天作之合 - Pokerpoke的文章 - 知乎 https://zhuanlan.zhihu.com/p/52874931
- > CMake 快成了C/C++开源项目的标配了，`mkdir build && cd build && cmake .. && make && sudo make install` 带来了十分的快感
- > 在VS Code扩展标签中搜索CMake并安装以下两个扩展，安装之后扩展会进行相关初始化
  ```console
  CMake
  CMake Tools
  ```
- 回复：
  * > `cmake -H. -Bbuild && cmake --build build` 可以换掉你那一大串。
  * > QtCreator丑不丑另说，但丫的cmake项目想要debug，就必须编译所有的目标，巨智障。
    >> `cmake --build . --target target_name`
  * > 难道不应该 `cmake -S. -Bbuild -DCMAKE_INSTALL_PRRFIX=~/.local && make -j9 -Cbuild all install` 吗

cmake https://blog.csdn.net/rangfei/category_10398401.html
- cmake(3)：编译库和链接可执行文件 https://blog.csdn.net/rangfei/article/details/108756768

# cmake现实中的例子

- https://github.com/hattonl/cpp-project-structure/blob/master/CMakeLists.txt

# 相关问题和回答

## 头文件包含还是库链接？

Undefined reference to function CMake https://stackoverflow.com/questions/38530491/undefined-reference-to-function-cmake

## `Unknown CMake command "target_link_options"`

Does cmake have something like target_link_options? https://stackoverflow.com/questions/25043458/does-cmake-have-something-like-target-link-options
>> //notes：Ubuntu自带的cmake版本是3.5，这个版本太低了，都没有`target_link_options`参数。一般都是用3.13或以上吧，需要自己升级下。

## `can not be used when making a shared object; recompile with -fPIC`
>> //notes：这个问题的起因是一模一样的代码，***在Mac下能编过，在Debian 9下编不过***。
>>> 根据Debian 9下的报错提示，修改很简单：在 `CMakeLists.txt` 里加上 `-fPIC` 选项即可，比如这个：`set(CMAKE_CXX_FLAGS "-std=c++11 -fPIC ${CMAKE_CXX_FLAGS}")`。但是造成这个现象的根因还没找到。下面两个帖子里有些线索，不过没时间深究，先不管了。

Got "recompile with -fPIC" error while the option is passed to the linker https://stackoverflow.com/questions/46731707/got-recompile-with-fpic-error-while-the-option-is-passed-to-the-linker

cmake编译错误"recompile with -fPIC" https://blog.csdn.net/googler_offer/article/details/95243150

--------------------------------------------------

What is the purpose of a `.cmake` file? https://stackoverflow.com/questions/46456498/what-is-the-purpose-of-a-cmake-file
- https://stackoverflow.com/questions/46456498/what-is-the-purpose-of-a-cmake-file/46456654#46456654
  * > You can include it with the include command. Similar to how other languages allow you to split source files into modules or header files, they can contain function definitions, macros which can then be reused across multiple CmakeLists.
  * > See https://cmake.org/cmake/help/v3.0/command/include.html
  * > Note that ***you can actually include any file***, but a `.cmake` extension is commonly used.

--------------------------------------------------

What is the difference between include_directories and target_include_directories in CMake? https://stackoverflow.com/questions/31969547/what-is-the-difference-between-include-directories-and-target-include-directorie
- https://stackoverflow.com/questions/31969547/what-is-the-difference-between-include-directories-and-target-include-directorie/31969632#31969632
  * > `include_directories(x/y)` affects directory scope. All targets in this CMakeList, as well as those in all subdirectories added after the point of its call, will have the path `x/y` added to their `include path`.
  * > `target_include_directories(t x/y)` has target scope — it adds `x/y` to the `include path` for target `t`.
  * > You want the former one if all of your targets use the include directories in question. You want the latter one if the path is specific to a target, ***or if you want finer control of the path's visibility***. The latter comes from the fact that `target_include_directories()` supports the `PRIVATE`, `PUBLIC`, and `INTERFACE` qualifiers.
>> 【[:star:][`*`]】 //notes：说白了就是不带 target 的那个命令对其执行后所有编译目标的 include path 都加上了某些搜索路径（比如回答里的路径 `x/y`），但是带 target 的版本只对该语句执行后的指定目标（比如回答里的目标 `t`）的 include path  加上了某些搜索路径（`x/y`）。总体来看，带 target 的版本一般不需要吧，因为没啥必要搞这么细的控制。。。

--------------------------------------------------

cmake 之 PUBLIC|PRIVATE|INTERFACE 关键字 https://ravenxrz.ink/archives/e40194d1.html

cmake：`target_**` 中的 PUBLIC，PRIVATE，INTERFACE - 大川搬砖的文章 - 知乎 https://zhuanlan.zhihu.com/p/82244559

CMake target_include_directories meaning of scope https://stackoverflow.com/questions/26243169/cmake-target-include-directories-meaning-of-scope
- https://stackoverflow.com/questions/26243169/cmake-target-include-directories-meaning-of-scope/28305481#28305481

--------------------------------------------------

“轻松搞定CMake”系列之find_package用法详解 https://blog.csdn.net/zhanghm1995/article/details/105466372
- > 重点看下其中 `OpenCV_DIR`、`OpenCV_INCLUDE_DIRS` 和 `OpenCV_LIBS` 打印的结果，这是我在 `CMakeLists.txt` 中用 `message` 命令输出这三个变量的值的结果。
- > 可以看到在执行 `find_package(OpenCV 3 REQUIRED)` 命令后，CMake找到了我们安装的位于 `/usr/local` 下的OpenCV库，并设置了CMake变量 `OpenCV_DIR` 为OpenCV库的配置文件所在路径，正是通过载入这个路径下的 `OpenCVConfig.cmake` 配置文件才能配置好OpenCV库，然后在 `OpenCVConfig.cmake` 配置文件中定义了变量 `OpenCV_INCLUDE_DIRS` 为OpenCV库头文件包含路径，这样我们才能才在代码中使用 `#include <opencv2/opencv.hpp>` 而不会出现编译错误，同时定义了变量 `OpenCV_LIBS` 为OpenCV链接库路径，这样我们才能正确链接到OpenCV中的库文件，而不会出现类似未定义的引用这样的链接错误。
- > 通过这个例子就可以看出 `find_package` 本质上就是一个搜包的命令，通过一些特定的规则找到 `<package_name>Config.cmake` 包配置文件，通过执行该配置文件，从而定义了一系列的变量，通过这些变量就可以准确定位到OpenCV库的头文件和库文件，完成编译。
- > **3、find_package命令搜包过程**
  * > `find_package` 命令有两种工作模式，这两种工作模式的不同决定了其搜包路径的不同：
  * > Module模式只有两个查找路径：`CMAKE_MODULE_PATH` 和 CMake安装路径下的Modules目录，
  * > 搜包路径依次为：
    ```console
    CMAKE_MODULE_PATH
    CMAKE_ROOT
    ```
  * > 先在 `CMAKE_MODULE_PATH` 变量对应的路径中查找。如果路径为空，或者路径中查找失败，则在CMake安装目录（即 `CMAKE_ROOT` 变量）下的 `Modules目录` 下（通常为 `/usr/share/cmake-3.10/Modules`，3.10是我的CMake版本）查找。这两个变量可以在 `CMakeLists.txt` 文件中打印查看具体内容：
    ```cmake
    message(STATUS "CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")
    message(STATUS "CMAKE_ROOT = ${CMAKE_ROOT}")
    ```

Cmake之深入理解find_package()的用法 - 希葛格的韩少君的文章 - 知乎 https://zhuanlan.zhihu.com/p/97369704

--------------------------------------------------

cmake:设置编译选项的讲究(add_compile_options和CMAKE_CXX_FLAGS的区别) https://blog.csdn.net/10km/article/details/51731959

CMake设置编译选项的几种方法 https://blog.csdn.net/dreamback1987/article/details/103698524

# 其他

现代 CMake 使用技巧 https://www.incredibuild.cn/blog/modern-cmake-tips-and-tricks-2
- > 11.使用 CMake 将模块依赖关系可视化
  * > CMake 支持本机依赖关系的可视化。使用 ZGRViewer 等程序可以很容易地查看输出点文件。
- > 13.什么时候使用 `PRIVATE`，`PUBLIC`  和  `INTERFACE`
  * > 下面的图表很好地解释了什么时候应该在 CMake 使用 `PRIVATE`，`PUBLIC` 和 `INTERFACE`.

    | 依赖关系 | 描述 |
    |--|--|
    | `PRIVATE`	| 我需要，但是依赖者不需要 |
    | `PUBLIC` | 我和依赖者都需要 |
    | `INTERFACE` | 我不需要，但是依赖者需要 |

## 卸载源码编译安装的 cmake

Remove CMake from standard installation locations. Tested on Ubuntu. https://gist.github.com/datatypevoid/86240308911c901fd198eb4df804cc49
>> //notes：其实核心就是最后那几句 `rm -rf ......`。注意有的时候 `/usr/local/bin` 下面还有 `cpack` 和 `ctest`，也不知道不删会不会有影响，反正一股脑删了就行！
```sh
rm_options="-rf"

rm ${rm_options} /usr/local/share/cmake* \
  /usr/local/lib/cmake \
  /usr/local/doc/cmake* \
  /usr/local/bin/cmake \
  /usr/local/share/aclocal/cmake.m4
```

https://askubuntu.com/questions/942713/how-do-i-remove-cmake-after-installing-it-from-source
