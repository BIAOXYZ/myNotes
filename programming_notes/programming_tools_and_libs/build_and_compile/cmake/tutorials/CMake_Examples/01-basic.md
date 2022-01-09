
RoboMaster视觉教程CMake(一)hello-cmake - 程序员三丰的文章 - 知乎 https://zhuanlan.zhihu.com/p/113554911

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
      >> 【[:star:][`*`]】 //notes：注意：一般不用这种方式来build！！！
  * > **Out-of-Source Build**
    + > Out-of-source builds allow you ***to create a single build folder*** that can be ***anywhere on your file system***. ***All temporary build and object files are located in this directory keeping your source tree clean***. To create an out-of-source build ***run the `cmake` command in the build folder and point it to the directory with your `root CMakeLists.txt` file***. Using out-of-source builds if you want to recreate your cmake environment from scratch, you only need to delete your build directory and then rerun cmake.
      >> 【[:star:][`*`]】 //notes：用 Out-of-source build 的方式很简单，一般都是在项目根目录下建一个 `build` 或者 `_build` 目录，然后进到这个目录里执行 `cmake ..`（如果 `build` 目录在其他位置，则 `cmake` 命令后的目录位置也要相应变化）。实际上，我经常是搞两个目录，一个叫 `debugbuild` 一个叫 `releasebuild`。

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
    > The ***`PRIVATE`*** identifier specifies the scope of the include. ***This is important for <ins>libraries</ins> and is explained in the next example***. More details on the function is available [here](https://cmake.org/cmake/help/v3.0/command/target_include_directories.html).
    >> 【[:star:][`*`]】 //notes：实际项目中基本都是简单粗暴地直接用 ***`include_directories()`*** 就可以了。。。
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
    >> 【[:star:][`*`]】 //notes：注意，这是一个使用 `make` 的技巧，而不是 `cmake` 的。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

C-static-library https://github.com/ttroy50/cmake-examples/blob/master/01-basic/C-static-library/README.adoc
- > **Adding a Static Library**
  * > The ***`add_library()`*** function is used to create a library from some source files. This is called as follows:
    ```cmake
    add_library(hello_library STATIC
        src/Hello.cpp
    )
    ```
  * > This will be used to create a ***static library*** with the name `libhello_library.a` with the sources in the ***`add_library`*** call.
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
    >> 【[:star:][`*`]】 //notes：这三个范围应该主要是针对 ***库的 include 目录*** 而言的。当某个库用 ***`target_include_directories()`*** 语句去 include 某些（头文件）路径时，这些路径根据三个范围关键词的不同，分别达到的效果是： <br> ***`PRIVATE`*** —— 这些路径给自己用；***`INTERFACE`*** —— 这些路径给链接这个库的后续目标用；***`PUBLIC`*** —— 这些路径既给自己用，也给链接这个库的后续目标用，也就是有：***`PUBLIC` = `PRIVATE` + `INTERFACE`***。 <br> 但是还是觉得这些细粒度范围控制没鸟用，直接都用 ***`PUBLIC`*** 不就得了。。。
    >>> 此外，前一个例子也用到了 ***`target_include_directories()`***，不过在那个例子里是针对 executable 的 include 目录，所以没有这么多精细的范围控制（因为没有别的会去链接一个二进制文件）。
  * > Tip: For public headers it is often a good idea to have your include folder ***be "namespaced" with sub-directories***. <br> The ***directory passed to `target_include_directories`*** will be ***the root of your include directory*** tree and your C++ files should ***include the path from there to your header***. <br> For this example you can see that we do it as follows:
    ```cpp
    #include "static/Hello.h"
    ```
    > Using this method means that there is less chance of header filename clashes when you use multiple libraries in your project.
    >> 【[:star:][`*`]】 //notes：上面这段话的意思是说：你的 include 目录应该用子目录细分一下，然后添加 include 的目录的时候，把那个 include 相关的最高级目录加进去。但是在代码文件里用 `#include "xxx"` 引入某个头文件时，用从 ***include的根目录*** 出发直到 ***该头文件位置***（也就是中间会包含一些子目录）的形式，比如：`#include "subfold1/subfold2/.../xxx"`。这样的好处是减少冲突。
- > **Linking a Library**
  * > When creating ***an executable that will use your library you must tell the compiler about the library***. This can be done using the ***`target_link_libraries()`*** function.
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

D-shared-library https://github.com/ttroy50/cmake-examples/blob/master/01-basic/D-shared-library/README.adoc
- > **Adding a Shared Library**
  * > As with the previous example on ***static libraries***, the ***`add_library()`*** function is also used to create a ***shared library*** from some source files. This is called as follows:
    ```cmake
    add_library(hello_library SHARED
        src/Hello.cpp
    )
    ```
    > This will be used to create a ***shared library*** with the name `libhello_library.so` with the sources passed to the ***`add_library()`*** function.
- > **Alias Target**
  * > As the name suggests an [alias target](https://cmake.org/cmake/help/v3.0/manual/cmake-buildsystem.7.html#alias-targets) is ***an alternative name for a target*** that can be used instead of the real target name ***in read-only contexts***.
    ```cmake
    add_library(hello::library ALIAS hello_library)
    ```
    > As shown below, this allows you to reference the target using the alias name when linking it against other targets.
- > **Linking a Shared Library**
  * > Linking a shared library is the same as linking a static library. When creating your executable use the the ***`target_link_library()`*** function to point to your library
    ```cmake
    add_executable(hello_binary
        src/main.cpp
    )

    target_link_libraries(hello_binary
        PRIVATE
            hello::library
    )
    ```
    > This tells CMake to link the `hello_library` against the `hello_binary executable` using the alias target name.
  * > An example of this being called by the linker is
    ```sh
    /usr/bin/c++ CMakeFiles/hello_binary.dir/src/main.cpp.o -o hello_binary -rdynamic libhello_library.so -Wl,-rpath,/home/matrim/workspace/cmake-examples/01-basic/D-shared-library/build
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

E-installing https://github.com/ttroy50/cmake-examples/blob/master/01-basic/E-installing/README.adoc
- > This example shows how to generate a ***`make install` target*** to install files and binaries on your system. This is ***based on the previous shared library example***.
- > **Installing**
  * > CMake offers the ability to add a ***`make install` target*** to allow a user to install binaries, libraries and other files. The base install location is controlled by the variable ***`CMAKE_INSTALL_PREFIX`*** which can be set using `ccmake` or by calling `cmake` with ***`cmake .. -DCMAKE_INSTALL_PREFIX=/install/location`***
  * > The files that are installed are controlled by the [***`install()`***](https://cmake.org/cmake/help/v3.0/command/install.html) function.
    ```cmake
    install (TARGETS cmake_examples_inst_bin
        DESTINATION bin)
    ```
    > Install the binary generated from the target `cmake_examples_inst_bin` target to the destination `${CMAKE_INSTALL_PREFIX}/bin`
    ```cmake
    install (TARGETS cmake_examples_inst
        LIBRARY DESTINATION lib)
    ```
    > Install the shared library generated from the target `cmake_examples_inst` target to the destination `${CMAKE_INSTALL_PREFIX}/lib`
    ```cmake
    install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/
        DESTINATION include)
    ```
    > Install the header files for developing against the `cmake_examples_inst` library into the `${CMAKE_INSTALL_PREFIX}/include` directory.
    ```cmake
    install (FILES cmake-examples.conf
        DESTINATION etc)
    ```
    > Install a configuration file to the destination `${CMAKE_INSTALL_PREFIX}/etc`
    >> 【[:star:][`*`]】 //notes：注意，上面涉及的 `bin`、`lib`、`include`、`etc` 都是可以改的，只是一般大家都用这些而已。我改成 `bin123`、`lib456`、`include789`、`etc000` 试了照样可以成功。目录不存在也没关系，只要用户权限够就会自动创建。
  * > After `make install` has been run, CMake generates an ***`install_manifest.txt`*** file which includes details on all installed files.
    * > Note: If you run the `make install` command as `root`, the ***`install_manifest.txt`*** file will be owned by `root`.
- > **Extra Notes**
  * > **Overriding the default install location**
    + > As mentioned the ***default install location*** is set from the ***`CMAKE_INSTALL_PREFIX`***, which defaults to ***`/usr/local/`***
    + > If you want to change this default location for all users you can add the following code to your top level `CMakeLists.txt` before adding any binaries or libraries.
      ```cmake
      if( CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT )
        message(STATUS "Setting default CMAKE_INSTALL_PREFIX path to ${CMAKE_BINARY_DIR}/install")
        set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE STRING "The path to use for make install" FORCE)
      endif()
      ```
      > This example sets the default install location to under your build directory.
      >> 【[:star:][`*`]】 //notes：更具体的说，由于我们在这一系列教程里都新建一个 `build` 目录去生成 `Makefile` 等文件，并在该目录里执行后续 `make` 相关命令，因此上述例子里的修改会把prefix变成 `其他前缀路径/project_root/build/install`。
  * > **DESTDIR**
    + > If you wish to stage your install to confirm that all files are included, the ***`make install` target*** supports the ***`DESTDIR`*** argument.
      ```sh
      make install DESTDIR=/tmp/stage
      ```
    + > This will create the install path ***`${DESTDIR}/${CMAKE_INSTALL_PREFIX}`*** for all your installation files. In this example, it would install all files under the path `/tmp/stage/usr/local`
      ```sh
      $ tree /tmp/stage
      /tmp/stage
      └── usr
          └── local
              ├── bin
              │   └── cmake_examples_inst_bin
              ├── etc
              │   └── cmake-examples.conf
              └── lib
                  └── libcmake_examples_inst.so
      ```
      >> 【[:star:][`*`]】 //notes：注意，这是一个使用 `make` 的技巧，而不是 `cmake` 的。
      >>> 原文里那个 “stage” 的意思有点类似 git 的 `stage area` （暂存区）里的那个 stage。主要就是想表达：可以把所有要安装的东西先安装到一个容易删掉的目录里，看看是不是对着，挺像 dry-run 的效果的。
  * > **Uninstall**
    + > By default CMake does not add a ***`make uninstall` target***. For details on how to generate an ***`uninstall` target*** see this [FAQ](https://cmake.org/Wiki/CMake_FAQ#Can_I_do_.22make_uninstall.22_with_CMake.3F)
    + > For an easy way to remove the files from this example, you can use:
      ```sh
      sudo xargs rm < install_manifest.txt
      ```
      >> 【[:star:][`*`]】 //notes：这个技巧不错！

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

F-build-type https://github.com/ttroy50/cmake-examples/blob/master/01-basic/F-build-type/README.adoc
- > **Introduction**
  * > CMake has a number of built in build configurations which can be used to compile your project. These specify ***the optimization levels*** and ***if debug information is to be included in the binary***.
  * > The levels provided are:
    + > `Release` - Adds the `-O3 -DNDEBUG` flags to the compiler
    + > `Debug` - Adds the `-g` flag
    + > `MinSizeRel` - Adds `-Os -DNDEBUG`
    + > `RelWithDebInfo` - Adds `-O2 -g -DNDEBUG` flags
- > **Set Build Type**
  * > The build type can be set using the following methods.
    + > Using a gui tool such as `ccmake` / `cmake-gui`
    + > Passing into `cmake`
      ```sh
      cmake .. -DCMAKE_BUILD_TYPE=Release
      ```
- > **Set Default Build Type**
  * > The ***default build type provided by CMake*** is to ***include no compiler flags for optimization***. For some projects you may want to ***set a default build type*** so that you do not have to remember to set it.
  * > To do this you can add the following to your top level `CMakeLists.txt`
    ```cmake
    if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
      message("Setting build type to 'RelWithDebInfo' as none was specified.")
      set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
      # Set the possible values of build type for cmake-gui
      set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
        "MinSizeRel" "RelWithDebInfo")
    endif()
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

RoboMaster视觉笔记CMake（六） Compile Flags - 程序员三丰的文章 - 知乎 https://zhuanlan.zhihu.com/p/149212650

G-compile-flags https://github.com/ttroy50/cmake-examples/blob/master/01-basic/G-compile-flags/README.adoc
- > **Introduction**
  * > CMake supports setting compile flags in a number of different ways:
    + > using ***`target_compile_definitions()`*** function
    + > using the ***`CMAKE_C_FLAGS`*** and ***`CMAKE_CXX_FLAGS`*** variables.
- > **Set Per-Target C++ Flags**
  * > ***The recommended way*** to set C++ flags in modern CMake is to use ***per-target flags*** which can be populated to other targets through the ***`target_compile_definitions()`*** [function](https://cmake.org/cmake/help/v3.0/command/target_compile_definitions.html?highlight=target_compile_definitions). This will populate the [INTERFACE_COMPILE_DEFINITIONS](https://cmake.org/cmake/help/v3.0/prop_tgt/INTERFACE_COMPILE_DEFINITIONS.html#prop_tgt:INTERFACE_COMPILE_DEFINITIONS) for the library and ***push the definition to the linked target depending on the scope***.
    ```cmake
    target_compile_definitions(cmake_examples_compile_flags
        PRIVATE EX3
    )
    ```
    > This will cause the compiler to add the definition `-DEX3` when compiling the target.
  * > If the ***target was a library*** and the scope `PUBLIC` or `INTERFACE` has been chosen the definition would also be included in any executables that link this target.
    >> 【[:star:][`*`]】 //notes：验证了我前面的笔记：那些scope之类的是对编译生成的库而言的，因为只有库才会被后续的各种编译目标链接，从而可能会有各种“传导”。说到“传导”，比起前面的“传导” `include目录`，这里“传导” `编译flag` 更复杂了，还涉及另外两个变量：`COMPILE_DEFINITIONS` 和 `INTERFACE_COMPILE_DEFINITIONS`。这里直接引用官方文档了：
    >>> The `INTERFACE`, `PUBLIC` and `PRIVATE` keywords are required to specify the scope of the following arguments. `PRIVATE` and `PUBLIC` items will populate the [COMPILE_DEFINITIONS](https://cmake.org/cmake/help/latest/prop_tgt/COMPILE_DEFINITIONS.html) property of `<target>`. `PUBLIC` and `INTERFACE` items will populate the [INTERFACE_COMPILE_DEFINITIONS](https://cmake.org/cmake/help/latest/prop_tgt/INTERFACE_COMPILE_DEFINITIONS.html) property of `<target>`.
    >>>> 简单总结官方文档就是：如果是 `PRIVATE`，就传导 `COMPILE_DEFINITIONS`；如果是 `INTERFACE`，就传导 `INTERFACE_COMPILE_DEFINITIONS`；如果是 `PUBLIC`，则两个都传导。
  * > For compiler options you can also use the ***`target_compile_options()`*** [function](https://cmake.org/cmake/help/v3.0/command/target_compile_options.html).
    >> 【[:star:][`*`]】 //notes：这俩看起来好像。。。至于区别，官网都TM没有。。。目前我能搜到的唯一一点大概是：`target_compile_definitions()` 里的东西对应的是 `cmake` 命令里 `-D` 后面的那些参数（`-D` 应该也就是 `definitions` 的缩写了）。这个只能是等后面碰到了再细化，还好一般不会用到这些功能。。。
- > **Set Default C++ Flags**
  * > The default ***`CMAKE_CXX_FLAGS`*** is ***either empty or contains the appropriate flags for the build type***.
  * > To set ***<ins>additional default</ins>*** compile flags you can add the following to your top level `CMakeLists.txt`
    ```cmake
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEX2" CACHE STRING "Set C++ Compiler Flags" FORCE)
    ```
  * > Similarly to ***`CMAKE_CXX_FLAGS`*** other options include:
    + > Setting C compiler flags using ***`CMAKE_C_FLAGS`***.
    + > Setting linker flags using ***`CMAKE_LINKER_FLAGS`***.
  * > Note: The values ***`CACHE STRING "Set C++ Compiler Flags" FORCE`*** from the above command are ***used to force this variable to be set in the `CMakeCache.txt` file***. For more details, see [here](https://cmake.org/cmake/help/v3.0/command/set.html).
    >> 【[:star:][`*`]】 //notes：关于这里的 `CACHE ...... FORCE` 的用法，参见下面的回答吧（回答里也指向了上面CMake `set` 命令的官方文档页面）。也是第一次见，看懂了但是先不展开了。
    >>> what does "CACHE STRING" in CMake CMakeLists file mean? https://stackoverflow.com/questions/36097090/what-does-cache-string-in-cmake-cmakelists-file-mean
  * > Once set the `CMAKE_C_FLAGS` and `CMAKE_CXX_FLAGS` will set a compiler flag / definition ***globally*** for all targets ***in this directory or any included sub-directories***. This method is ***not recommended*** for general usage now and the ***`target_compile_definitions`*** function is preferred.
- > **Set CMake Flags**
  * > Similar to the build type a global C++ compiler flag can be set using the following methods.
    + > Using a gui tool such as `ccmake` / `cmake-gui`
    + > Passing into cmake
      ```sh
      cmake .. -DCMAKE_CXX_FLAGS="-DEX3"
      ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

H-third-party-library https://github.com/ttroy50/cmake-examples/blob/master/01-basic/H-third-party-library/README.adoc
- > **Introduction**
  * > Nearly all non-trivial projects will have a requirement for including third party libraries, headers, or programs. CMake has support for finding the path to these tools using the ***`find_package()`*** function. This will search for CMake modules in the format ***`"FindXXX.cmake"`*** from the list of folders in ***`CMAKE_MODULE_PATH`***. On linux the default search path will include ***`/usr/share/cmake/Modules`***. On my system this includes support for approximately 142 common third party libraries.
- > **Finding a Package**
  * > As mentioned above the ***`find_package()`*** function will <ins>search for CMake modules in the formant ***`"FindXXX.cmake"`*** from the list of folders in ***`CMAKE_MODULE_PATH`***</ins>. The exact format of the arguments to ***`find_package`*** will depend on the module you are looking for. This is typically documented at the top of the ***`FindXXX.cmake`*** file.
  * > A basic example of finding boost is below:
    ```cmake
    find_package(Boost 1.46.1 REQUIRED COMPONENTS filesystem system)
    ```
  * > The arguments are:
    + > Boost - Name of the library. This is part of used to find the module file `FindBoost.cmake`
    + > 1.46.1 - The minimum version of boost to find
    + > ***`REQUIRED`*** - Tells the module that this is required and ***to fail if it cannot be found***
    + > ***`COMPONENTS`*** - The list of components to find in the library.
  * > Boost includes can take more arguments and also make use of other variables. More complex setups are provided in later examples.
- > **Checking if the package is found**
  * > Most included packages will set a variable ***`XXX_FOUND`***, which can be used to check if the package is available on the system.
  * > In this example the variable is `Boost_FOUND`:
    ```cmake
    if(Boost_FOUND)
        message ("boost found")
        include_directories(${Boost_INCLUDE_DIRS})
    else()
        message (FATAL_ERROR "Cannot find Boost")
    endif()
    ```
- > **Exported Variables**
  * > After a package is found it will often export variables which can inform the user where to find the library, header, or executable files. Similar to the ***`XXX_FOUND`*** variable, ***these are package specific*** and are typically documented at the top of the ***`FindXXX.cmake`*** file.
  * > The variables exported in this example include:
    + > `Boost_INCLUDE_DIRS` - The path to the boost header files.
  * > In some cases you can also check these variables by examining the cache using `ccmake` or `cmake-gui`.
- > **Alias / Imported targets**
  * > Most modern CMake libraries [export](https://cmake.org/cmake/help/v3.6/prop_tgt/IMPORTED.html#prop_tgt:IMPORTED) `ALIAS` targets in their module files. The benefit of imported targets are that they can also populate include directories and linked libraries.
  * > For example, starting from v3.5+ of CMake, the Boost module supports this. Similar to using your own `ALIAS` target for libraires, an `ALIAS` in a module can make referencing found targets easier.
  * > In the case of Boost, all targets are exported using the `Boost::` identifier and then the name of the subsystem. For example you can use:
    ```console
    Boost::boost for header only libraries
    Boost::system for the boost system library.
    Boost::filesystem for filesystem library.
    ```
  * > As with your own targets, these targets include their dependencies, so linking against `Boost::filesystem` will automatically add `Boost::boost` and `Boost::system` dependencies.
  * > To link against an imported target you can use the following:
    ```cmake
      target_link_libraries( third_party_include
          PRIVATE
              Boost::filesystem
      )
    ```
- > **Non-alias targets**
  * > While most modern libraries use imported targets, not all modules have been updated. In the case where a library hasn’t been updated you will often find the following variables available:
    + > ***`xxx_INCLUDE_DIRS`*** - A variable pointing to the include directory for the library.
    + > ***`xxx_LIBRARY`*** - A variable pointing to the library path.
  * > These can then be added to your ***`target_include_directories`*** and ***`target_link_libraries`*** as:
    ```cmake
    # Include the boost headers
    target_include_directories( third_party_include
        PRIVATE ${Boost_INCLUDE_DIRS}
    )
    
    # link against the boost libraries
    target_link_libraries( third_party_include
        PRIVATE
        ${Boost_SYSTEM_LIBRARY}
        ${Boost_FILESYSTEM_LIBRARY}
    )
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
