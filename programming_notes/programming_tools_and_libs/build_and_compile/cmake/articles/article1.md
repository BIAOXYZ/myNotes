
使用CMake组织C++项目 https://uint128.com/2020/03/03/%E4%BD%BF%E7%94%A8CMake%E7%BB%84%E7%BB%87C-%E9%A1%B9%E7%9B%AE/
- > **让CMake找到我的源文件**
  * > 如果源文件太多了，可以把源文件都放到一个目录里。比如把所有的源文件都放在了 src 目录里。
  * > 使用 `aux_source_directory(<src_dir> <var_name>)` 命令把 `src_dir` 目录下的所有源文件都放到 `var_name` 变量里。
  * > 使用方法：
    ```cmake
    aux_source_directory(./src SRCS)
    # 可执行程序
    add_executable(${PROJECT_NAME} ${SRCS})
    # 静态链接库
    add_library(${PROJECT_NAME} STATIC ${SRCS})
    ```
  * > 注意：`aux_source_directory` 不会递归包含子目录，而且在源代码目录新增源文件后，要刷新 CMake 缓存才能生效。
- > **让CMake找到我的头文件**
  * > 用 `include_directories(<dir> [dir2] [dir3] ...)` 命令设置头文件目录，告诉 CMake 应该到哪些目录里寻找头文件。如果用 `target_link_libraries()` 让构建目标链接一个库，可以不对这个库的头文件目录使用这个命令，具体参考下文。
  * > 使用方法：
    ```cmake
    include_directories(./include)
    ```
- > **创建库项目**
  * > 使用 `add_library(<project name> <type> <src>)` 命令可以创建一个库项目。
  * > 使用 `target_include_directories(<project name> <INTERFACE|PUBLIC|PRIVATE> <include_dir>)` 设置库的头文件目录。为了让链接本库的项目能够正常使用，一般设置 `PUBLIC` 属性。
  * > 使用方法：
    ```cmake
    # 静态链接库
    add_library(${PROJECT_NAME} STATIC a.cpp b.cpp c.cpp)
    target_include_directories(${PROJECT_NAME} PUBLIC ./include)
    # 或者：
    add_library(${PROJECT_NAME} STATIC ${SRCS})
    target_include_directories(${PROJECT_NAME} PUBLIC ./include)
    # 动态链接库
    add_library(${PROJECT_NAME} SHARED ${SRCS})
    target_include_directories(${PROJECT_NAME} PUBLIC ./include)
    # Header-Only 库
    add_library(${PROJECT_NAME} INTERFACE)
    target_include_directories(${PROJECT_NAME} PUBLIC ./include)
    ```
