
CMake构建系统 - fangcun的文章 - 知乎 https://zhuanlan.zhihu.com/p/56167140
- > **目标属性**
  * > `INCLUDE_DIRECTORIES`，`COMPILE_DEFINITIONS` 和 `COMPILE_OPTIONS` 目标属性在编译二进制目标的源文件时被使用。
  * > `INCLUDE_DIRECTORIES` 属性中的条目会被加上 `-I` 或 `-isystem` 前缀，按照条目在属性中出现的顺序加入编译使用的命令行中。
  * > `COMPILE_DEFINITIONS` 属性中的条目会被加上 `-D` 或 `/D` 前缀，按照不确定的顺序加入编译使用的命令行中。为了方便 `SHARED` 和 `MODULE` 库目标的使用，`DEFINE_SYMBOL` 目标属性也被加入编译命令行中。
  * > `COMPILE_OPTIONS` 属性中的条目被转义处理后，按照它们在属性中出现的顺序加入编译命令行。部分编译选项可能会进行单独的特殊处理，比如 `POSITION_INDEPENDENT_CODE`。
  * > `INTERFACE_INCLUDE_DIRECTORIES`，`INTERFACE_COMPILE_DEFINITIONS` 和 `INTERFACE_COMPILE_OPTIONS` 目标属性的内容也是构建需求，它们指定的内容必须被编译链接的目标所满足。对于任意二进制目标，`target_link_libraries()` 指令所指定链接的目标的 `INTERFACE` 目标属性需要被满足。
- > **构建需求传递**
  * > 一般而言，如果一个目标仅仅使用了一个库的实现，***并且目标本身没有使用库的头文件***，可以对这一依赖使用 `PRIVATE` 关键字。如果目标本身使用了库的实现和头文件(比如用来做类的继承)，应该对这一依赖使用 `PUBLIC` 关键字。如果目标本身只使用了库的头文件，而没有使用它的实现，应该对这一依赖使用 `INTERFACE` 关键字。`target_link_libraries()`指令可以多次使用依赖关键字：
    ```cmake
    target_link_libraries(archiveExtras
      PUBLIC archive
      PRIVATE serialization
    )
    ```
