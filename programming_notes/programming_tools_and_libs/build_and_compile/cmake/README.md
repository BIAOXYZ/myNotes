
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

Cmake之深入理解find_package()的用法 - 希葛格的韩少君的文章 - 知乎 https://zhuanlan.zhihu.com/p/97369704

--------------------------------------------------

cmake:设置编译选项的讲究(add_compile_options和CMAKE_CXX_FLAGS的区别) https://blog.csdn.net/10km/article/details/51731959

CMake设置编译选项的几种方法 https://blog.csdn.net/dreamback1987/article/details/103698524
