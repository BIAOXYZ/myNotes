
cmake https://blog.csdn.net/rangfei/category_10398401.html
- cmake(3)：编译库和链接可执行文件 https://blog.csdn.net/rangfei/article/details/108756768

# 相关问题和回答

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
