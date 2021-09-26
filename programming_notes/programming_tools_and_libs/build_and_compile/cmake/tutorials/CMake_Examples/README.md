
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
