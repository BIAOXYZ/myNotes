
# cmake变量

**cmake-variables(7)** https://cmake.org/cmake/help/v3.24/manual/cmake-variables.7.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Variables that Provide Information¶

## `CMAKE_CURRENT_SOURCE_DIR`、`CMAKE_SOURCE_DIR`、`<PROJECT-NAME>_SOURCE_DIR`、`PROJECT_SOURCE_DIR`

`CMAKE_CURRENT_SOURCE_DIR` https://cmake.org/cmake/help/latest/variable/CMAKE_CURRENT_SOURCE_DIR.html

`CMAKE_SOURCE_DIR` https://cmake.org/cmake/help/latest/variable/CMAKE_SOURCE_DIR.html

`<PROJECT-NAME>_SOURCE_DIR` https://cmake.org/cmake/help/latest/variable/PROJECT-NAME_SOURCE_DIR.html

`PROJECT_SOURCE_DIR` https://cmake.org/cmake/help/latest/variable/PROJECT_SOURCE_DIR.html

Difference between CMAKE_CURRENT_SOURCE_DIR and CMAKE_CURRENT_LIST_DIR https://stackoverflow.com/questions/15662497/difference-between-cmake-current-source-dir-and-cmake-current-list-dir

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `CMAKE_PROJECT_NAME`、`PROJECT_NAME`

`PROJECT_NAME` https://cmake.org/cmake/help/v3.24/variable/PROJECT_NAME.html
- > Name of the project given to the project command.
- > This is the name given to the most recently called [`project()`](https://cmake.org/cmake/help/v3.24/command/project.html#command:project) command in the current directory scope or above. To obtain ***the name of the top level project***, see the [**`CMAKE_PROJECT_NAME`**](https://cmake.org/cmake/help/v3.24/variable/CMAKE_PROJECT_NAME.html#variable:CMAKE_PROJECT_NAME) variable.

Difference between CMAKE_PROJECT_NAME and PROJECT_NAME? https://stackoverflow.com/questions/38938315/difference-between-cmake-project-name-and-project-name
- 【[:star:][`*`]】 https://stackoverflow.com/questions/38938315/difference-between-cmake-project-name-and-project-name/38940669#38940669
  * > The difference is that `CMAKE_PROJECT_NAME` is the name from the last `project` call from ***the root CMakeLists.txt***, while `PROJECT_NAME` is from the last `project` call, regardless from the location of the file containing the command. The difference is recognizable from the following test.
  * > File structure:
    ```console
    |-CMakeLists.txt
    \-test2
      |-CMakeLists.txt
      \-test3
        \-CMakeLists.txt
    ```
  * > `CMakeLists.txt`:
    ```cmake
    cmake_minimum_required(VERSION 3.0)
    project(A)
    message("< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    project(B)
    message("< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    add_subdirectory(test2)
    message("< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    project(C)
    message("< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    ```
  * > `test2/CMakeLists.txt`:
    ```cmake
    project(D)
    message("<< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    add_subdirectory(test3)
    project(E)
    message("<< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    ```
  * > `test2/test3/CMakeLists.txt`:
    ```cmake
    project(F)
    message("<<< ${CMAKE_PROJECT_NAME} / ${PROJECT_NAME}")
    ```
  * > The relevant output is:
    ```console
    < A / A
    < B / B
    << B / D
    <<< B / F
    << B / E
    < B / B
    < C / C
    ```
  * > In the sub-directories, always B is the value for `CMAKE_PROJECT_NAME`.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `CMAKE_VERBOSE_MAKEFILE`

`CMAKE_VERBOSE_MAKEFILE` https://cmake.org/cmake/help/latest/variable/CMAKE_VERBOSE_MAKEFILE.html

cmake, print compile/link commands https://stackoverflow.com/questions/3379207/cmake-print-compile-link-commands

cmake使用笔记 https://www.cnblogs.com/ailumiyana/p/10721123.html
- > **`CMAKE_VERBOSE_MAKEFILE`**
  * > 显示详细的原始编译信息，主要用于定位一些链接错误，看看库路径什么的是否配置对。
    ```cmake
    # print compile info
    set(CMAKE_VERBOSE_MAKEFILE ON)
    ```
  * > 或者执行 `make` 时
    ```sh
    $ make VERBOSE=1
    ```
    > 或者
    ```sh
    $ export VERBOSE=1
    $ make
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Variables for Languages¶

## `CMAKE_<LANG>_FLAGS`

`CMAKE_<LANG>_FLAGS` https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS.html
- > For each language, if this variable is not defined, it is initialized and stored in the cache using values from environment variables in combination with CMake's builtin defaults for the toolchain:
  * > `CMAKE_C_FLAGS`: Initialized by the `CFLAGS` environment variable.
  * > `CMAKE_CXX_FLAGS`: Initialized by the `CXXFLAGS` environment variable.
