
`CMakeLists.txt`:
```cmake
cmake_minimum_required (VERSION 3.5)

project(subprojects)

# Add sub directories
add_subdirectory(sublibrary1)
add_subdirectory(sublibrary2)
add_subdirectory(subbinary)
```

A-basic https://github.com/ttroy50/cmake-examples/blob/master/02-sub-projects/A-basic/README.adoc
- > **Introduction**
  * > This example shows how to setup a CMake project that includes sub-projects. The top level CMakeLists.txt calls the CMakeLists.txt in the sub directories to create the following:
    + > sublibrary1 - A static library
    + > sublibrary2 - A header only library
    + > subbinary - An executable
  * > The files included in this example are:
    ```sh
    $ tree
    .
    ├── CMakeLists.txt
    ├── subbinary
    │   ├── CMakeLists.txt
    │   └── main.cpp
    ├── sublibrary1
    │   ├── CMakeLists.txt
    │   ├── include
    │   │   └── sublib1
    │   │       └── sublib1.h
    │   └── src
    │       └── sublib1.cpp
    └── sublibrary2
        ├── CMakeLists.txt
        └── include
            └── sublib2
                └── sublib2.h
    ```
  * > Tip: In this example I have moved the header files to a subfolder under each projects include directory, while leaving the target include as the root include folder. ***This is a good idea to prevent filename clashes*** because you have to include a file like below:
    ```cpp
    #include "sublib1/sublib1.h"
    ```
    > This also means that if you install your library for other users the default install location would be `/usr/local/include/sublib1/sublib1.h`.
- > **Adding a Sub-Directory**
  * > A `CMakeLists.txt` file can include and call sub-directories which include a `CMakeLists.txt` files.
    ```cmake
    add_subdirectory(sublibrary1)
    add_subdirectory(sublibrary2)
    add_subdirectory(subbinary)
    ```
- > **Referencing Sub-Project Directories**
  * > When a project is created using the ***`project()`*** command, CMake will ***automatically create a number of variables which can be used to reference details about the project***. These variables can then be used by other sub-projects or the main project. For example, to reference the source directory for a different project you can use.
    ```console
    ${sublibrary1_SOURCE_DIR}
    ${sublibrary2_SOURCE_DIR}
    ```
  * > The variables created by CMake include:

    | **Variable** | **Info** |
    |:--|:--|
    | ***`PROJECT_NAME`*** | The name of the project set by the current ***`project()`***. |
    | `CMAKE_PROJECT_NAME` | The name of the first project set by the ***`project()`*** command, i.e. the top level project. |
    | ***`PROJECT_SOURCE_DIR`*** | The source directory of the current project. |
    | `PROJECT_BINARY_DIR` | The build directory for the current project. |
    | `name_SOURCE_DIR` | The source directory of the project called "name". In this example the source directories created would be `sublibrary1_SOURCE_DIR`, `sublibrary2_SOURCE_DIR`, and `subbinary_SOURCE_DIR` |
    | `name_BINARY_DIR` | The binary directory of the project called "name". In this example the binary directories created would be `sublibrary1_BINARY_DIR`, `sublibrary2_BINARY_DIR`, and `subbinary_BINARY_DIR` |

- > **Header only Libraries**
  * > If you have a library that is created as a header only library, cmake supports the ***`INTERFACE`*** target to allow ***creating a target without any build output***. More details can be found from [here](https://cmake.org/cmake/help/v3.4/command/add_library.html#interface-libraries)
    ```cmake
    add_library(${PROJECT_NAME} INTERFACE)
    ```
  * > When creating the target you can also ***include directories for that target*** using the ***`INTERFACE`*** scope. The ***`INTERFACE`*** scope is use to make target requirements that are used in any Libraries that link this target but not in the compilation of the target itself.
    ```cmake
    target_include_directories(${PROJECT_NAME}
        INTERFACE
            ${PROJECT_SOURCE_DIR}/include
    )  
    ```
- > **Referencing Libraries from Sub-Projects**
  * > If a sub-project creates a library, it can be referenced by other projects by calling the name of the target in the ***`target_link_libraries()`*** command. This means that ***you don’t have to reference the full path of the new library and it is added as a dependency***.
    ```cmake
    target_link_libraries(subbinary
        PUBLIC
            sublibrary1
    )
    ```
  * > Alternatively, you can create an alias target which allows you to reference the target in ***read only contexts***.
  * > To create an alias target run:
    ```cmake
    add_library(sublibrary2)
    add_library(sub::lib2 ALIAS sublibrary2)
    ```
    > To reference the alias, just it as follows:
    >> //notes：这一节的 typo 贼多，前面表格里我都已经改了一些了，估计作者到这也已经累够呛了。。。
    ```cmake
    target_link_libraries(subbinary
        sub::lib2
    )
    ```
- > **Include directories from sub-projects**
  * > When adding the libraries from the sub-projects, ***starting from cmake v3***, there is ***no need to add the projects include directories in the include directories of the binary using them***.
  * > This is controlled by the scope in the ***`target_include_directories()`*** command when creating the libraries. In this example because the `subbinary executable` links the `sublibrary1` and `sublibrary2` libraries it will automatically include the `${sublibrary1_SOURCE_DIR}/include` and `${sublibrary2_SOURCE_DIR}/include` folders as they are exported with the ***`PUBLIC`*** and ***`INTERFACE`*** scopes of the libraries.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
