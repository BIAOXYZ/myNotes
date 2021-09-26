
# 主页

CMake Examples https://github.com/ttroy50/cmake-examples || http://ttroy50.github.io/cmake-examples/
- > **Other Links**: There are many CMake tutorials and examples online. The list below includes links to some of these which I have found helpful in my CMake journey.

# 笔记

## 01-basic

B-Hello-Headers https://github.com/ttroy50/cmake-examples/blob/master/01-basic/B-hello-headers/README.adoc
- > **Directory Paths**

  |Variable | Info |
  |:--|:--|
  | `CMAKE_SOURCE_DIR` |The root source directory |
  | `CMAKE_CURRENT_SOURCE_DIR` |The current source directory if using sub-projects and directories. |
  | `PROJECT_SOURCE_DIR` |The source directory of the current cmake project. |
  | `CMAKE_BINARY_DIR` |The root binary / build directory. This is the directory where you ran the cmake command. |
  | `CMAKE_CURRENT_BINARY_DIR` | The build directory you are currently in. |
  | `PROJECT_BINARY_DIR` | The build directory for the current project. |

- > Note: An alternative to setting specific file names in the SOURCES variable is to use a ***`GLOB`*** command to find files using wildcard pattern matching.
  ```cmake
  file(GLOB SOURCES "src/*.cpp")
  ```
- > Tip: For modern CMake ***it is NOT recommended to use a variable for sources***. Instead it is typical to directly declare the sources in the `add_xxx` function. <br> This is particularly important for glob commands which may not always show you the correct results if you add a new source file.
- > **Including Directories**
  * > When you have different include folders, you can make your compiler aware of them using the ***`target_include_directories()`*** function. When compiling this target this will add these directories to the compiler with the ***`-I`*** flag e.g. `-I/directory/path`
    ```cmake
    target_include_directories(target
        PRIVATE
            ${PROJECT_SOURCE_DIR}/include
    )
    ```
    > The ***`PRIVATE`*** identifier specifies the scope of the include. ***This is important for libraries and is explained in the next example***. More details on the function is available [here](https://cmake.org/cmake/help/v3.0/command/target_include_directories.html).

C-static-library https://github.com/ttroy50/cmake-examples/blob/master/01-basic/C-static-library/README.adoc
- > **Populating Including Directories**
  * > In this example, we include directories in the library using the ***`target_include_directories()`*** function with the scope set to ***`PUBLIC`*** .
    ```cmake
    target_include_directories(hello_library
        PUBLIC
            ${PROJECT_SOURCE_DIR}/include
    )
    ```
  * > This will cause the included directory used in the following places:
    + > When compiling the library
    + > When compiling any additional target that links the library.
  * > The meaning of scopes are:
    + > ***`PRIVATE`*** - the directory is added to this target’s include directories.
    + > ***`INTERFACE`*** - the directory is added to the include directories for any targets that link this library.
    + > ***`PUBLIC`*** - As above, it is included in this library and also any targets that link this library.
    >> //notes：这三个范围应该主要是针对库的 include 目录而言的。当某个库用 ***`target_include_directories()`*** 语句去 include 某些（头文件）路径时，这些路径根据三个范围关键词的不同，分别达到的效果是： <br> ***`PRIVATE`*** —— 这些路径给自己用；***`INTERFACE`*** —— 这些路径给链接这个库的后续目标用；***`PUBLIC`*** —— 这些路径既给自己用，也给链接这个库的后续目标用，也就是有：***`PUBLIC` = `PRIVATE` + `INTERFACE`***。 <br> 但是还是觉得这些细粒度范围控制没鸟用，直接都用 ***`PUBLIC`*** 不就得了。。。
  * > Tip: For public headers it is often a good idea to have your include folder ***be "namespaced" with sub-directories***. <br> The ***directory passed to `target_include_directories`*** will be ***the root of your include directory*** tree and your C++ files should ***include the path from there to your header***. <br> For this example you can see that we do it as follows:
    ```cpp
    #include "static/Hello.h"
    ```
    > Using this method means that there is less chance of header filename clashes when you use multiple libraries in your project.
    >> //notes：上面这段话的意思是说：你的 include 目录应该用子目录细分一下，然后添加 include 的目录的时候，把那个 include 相关的最高级目录加进去。但是在代码文件里用 `#include xxx` 引入时，包含子目录的形式。
- > **Linking a Library**
  * > When creating an executable that will use your library you must tell the compiler about the library. This can be done using the ***`target_link_libraries()`*** function.
    ```cmake
    add_executable(hello_binary
        src/main.cpp
    )
    
    target_link_libraries( hello_binary
        PRIVATE
            hello_library
    )
    ```
  * > This tells CMake to link the ***hello_library*** against the ***hello_binary executable*** during link time. It will also ***propagate any include directories with `PUBLIC` or `INTERFACE` scope from the <ins>linked library target</ins>***.
  * > An example of this being called by the compiler is
    ```sh
    /usr/bin/c++ CMakeFiles/hello_binary.dir/src/main.cpp.o -o hello_binary -rdynamic libhello_library.a
    ```
