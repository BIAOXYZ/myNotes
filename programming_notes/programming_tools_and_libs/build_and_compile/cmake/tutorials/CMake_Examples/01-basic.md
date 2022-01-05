
A-hello-cmake https://github.com/ttroy50/cmake-examples/blob/master/01-basic/A-hello-cmake/README.adoc
- > NOTE: A shorthand that some people use is to ***have the project name and executable name the same***. This allows you to specify the `CMakeLists.txt` as follows,
  ```cmake
  cmake_minimum_required(VERSION 2.6)
  project (hello_cmake)
  add_executable(${PROJECT_NAME} main.cpp)
  ```
  > In this example, the `project()` function, will create a variable ***`${PROJECT_NAME}`*** with the value `'hello_cmake'`. This can then be passed to the `add_executable()` function to output a `'hello_cmake'` executable.
- > **Binary Directory**
  * > The root or top level folder that you run the cmake command from is known as your ***`CMAKE_BINARY_DIR`*** and is the root folder for all your binary files. CMake supports building and generating your binary files both ***in-place*** and also ***out-of-source***.
  * > **In-Place Build**
    + > In-place builds generate all temporary build files in the same directory structure as the source code. This means that all Makefiles and object files are interspersed with your normal code. ***To create an in-place build target run the `cmake` command in your root directory***.
      >> 注意：基本不要用这种方式来build！！！
  * > **Out-of-Source Build**
    + > Out-of-source builds allow you ***to create a single build folder*** that can be ***anywhere on your file system***. ***All temporary build and object files are located in this directory keeping your source tree clean***. To create an out-of-source build ***run the `cmake` command in the build folder and point it to the directory with your `root CMakeLists.txt` file***. Using out-of-source builds if you want to recreate your cmake environment from scratch, you only need to delete your build directory and then rerun cmake.
      >> //notes：用 Out-of-source build 的方式很简单，一般都是在项目根目录下建一个 `build` 或者 `_build` 目录，然后进到这个目录里执行 `cmake ..`（如果 `build` 目录在其他位置，则 `cmake` 命令后的目录位置也要相应变化）。实际上，我经常是搞两个目录，一个叫 `debugbuild` 一个叫 `releasebuild`。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

B-Hello-Headers https://github.com/ttroy50/cmake-examples/blob/master/01-basic/B-hello-headers/README.adoc
- > **Directory Paths**

  |Variable | Info |
  |:--|:--|
  | `CMAKE_SOURCE_DIR` |The root source directory |
  | `CMAKE_CURRENT_SOURCE_DIR` |The current source directory if using sub-projects and directories. |
  | `PROJECT_SOURCE_DIR` |The source directory of the current cmake project. |
  | `CMAKE_BINARY_DIR` |The root binary / build directory. This is ***the directory where you ran the `cmake` command***. |
  | `CMAKE_CURRENT_BINARY_DIR` | The build directory you are currently in. |
  | `PROJECT_BINARY_DIR` | The build directory for the current project. |

- > Note: An alternative to setting specific file names in the *SOURCES* variable is to use a ***`GLOB`*** command to find files using wildcard pattern matching.
  ```cmake
  file(GLOB SOURCES "src/*.cpp")
  ```
- > Tip: For modern CMake ***it is <ins>NOT</ins> recommended to use a variable for sources***. Instead it is typical to directly declare the sources in the ***`add_xxx`*** function. <br> This is particularly important for glob commands which may not always show you the correct results if you add a new source file.
- > **Including Directories**
  * > When you have different include folders, you can make your compiler aware of them using the ***`target_include_directories()`*** [function](https://cmake.org/cmake/help/v3.0/command/target_include_directories.html). When compiling this target this will add these directories to the compiler with the ***`-I`*** flag e.g. `-I/directory/path`
    ```cmake
    target_include_directories(target
        PRIVATE
            ${PROJECT_SOURCE_DIR}/include
    )
    ```
    > The ***`PRIVATE`*** identifier specifies the scope of the include. ***This is important for libraries and is explained in the next example***. More details on the function is available [here](https://cmake.org/cmake/help/v3.0/command/target_include_directories.html).
- > **Standard Output**
  ```console
  $ make
  Scanning dependencies of target hello_headers
  [ 50%] Building CXX object CMakeFiles/hello_headers.dir/src/Hello.cpp.o
  [100%] Building CXX object CMakeFiles/hello_headers.dir/src/main.cpp.o
  Linking CXX executable hello_headers
  [100%] Built target hello_headers
  ```
- > **Verbose Output**
  * > In the previous examples, when running the `make` command the output only shows the status of the build. To see the full output for debugging purposes you can add ***`VERBOSE=1`*** flag when running `make`.
  * > The ***`VERBOSE`*** output is show below, and a examination of the output shows the include directories being added to the c++ compiler command.  【--> 一句里面两个语法错误，瞬间让我以为我记错仓库了。。。】
    ```console
    $ make clean
    
    $ make VERBOSE=1
    /usr/bin/cmake -H/home/matrim/workspace/cmake-examples/01-basic/hello_headers -B/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build --check-build-system CMakeFiles/Makefile.cmake 0
    /usr/bin/cmake -E cmake_progress_start /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles/progress.marks
    make -f CMakeFiles/Makefile2 all
    make[1]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    make -f CMakeFiles/hello_headers.dir/build.make CMakeFiles/hello_headers.dir/depend
    make[2]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    cd /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build && /usr/bin/cmake -E cmake_depends "Unix Makefiles" /home/matrim/workspace/cmake-examples/01-basic/hello_headers /home/matrim/workspace/cmake-examples/01-basic/hello_headers /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles/hello_headers.dir/DependInfo.cmake --color=
    make[2]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    make -f CMakeFiles/hello_headers.dir/build.make CMakeFiles/hello_headers.dir/build
    make[2]: Entering directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    /usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 1
    [ 50%] Building CXX object CMakeFiles/hello_headers.dir/src/Hello.cpp.o
    /usr/bin/c++    -I/home/matrim/workspace/cmake-examples/01-basic/hello_headers/include    -o CMakeFiles/hello_headers.dir/src/Hello.cpp.o -c /home/matrim/workspace/cmake-examples/01-basic/hello_headers/src/Hello.cpp
    /usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 2
    [100%] Building CXX object CMakeFiles/hello_headers.dir/src/main.cpp.o
    /usr/bin/c++    -I/home/matrim/workspace/cmake-examples/01-basic/hello_headers/include    -o CMakeFiles/hello_headers.dir/src/main.cpp.o -c /home/matrim/workspace/cmake-examples/01-basic/hello_headers/src/main.cpp
    Linking CXX executable hello_headers
    /usr/bin/cmake -E cmake_link_script CMakeFiles/hello_headers.dir/link.txt --verbose=1
    /usr/bin/c++       CMakeFiles/hello_headers.dir/src/Hello.cpp.o CMakeFiles/hello_headers.dir/src/main.cpp.o  -o hello_headers -rdynamic
    make[2]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    /usr/bin/cmake -E cmake_progress_report /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles  1 2
    [100%] Built target hello_headers
    make[1]: Leaving directory `/home/matrim/workspace/cmake-examples/01-basic/hello_headers/build'
    /usr/bin/cmake -E cmake_progress_start /home/matrim/workspace/cmake-examples/01-basic/hello_headers/build/CMakeFiles 0
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

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
    >> //notes：上面这段话的意思是说：你的 include 目录应该用子目录细分一下，然后添加 include 的目录的时候，把那个 include 相关的最高级目录加进去。但是在代码文件里用 `#include "xxx"` 引入某个头文件时，用从 ***include的根目录*** 出发直到 ***该头文件位置***（也就是中间会包含一些子目录）的形式，比如：`#include "subfold1/subfold2/.../xxx"`。这样的好处是减少冲突。
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
