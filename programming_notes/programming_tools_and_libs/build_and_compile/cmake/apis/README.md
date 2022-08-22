
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# cmake命令

`cmake-commands(7)¶` https://cmake.org/cmake/help/v3.24/manual/cmake-commands.7.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `aux_source_directory()`

aux_source_directory https://cmake.org/cmake/help/latest/command/aux_source_directory.html

【[:star:][`*`]】 Cmake命令之add_subdirectory介绍 https://www.jianshu.com/p/07acea4e86a3

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `find_library()`

find_library https://cmake.org/cmake/help/latest/command/find_library.html

Package vs Library https://stackoverflow.com/questions/23832339/package-vs-library
- https://stackoverflow.com/questions/23832339/package-vs-library/23838081#23838081
  * > Imagine you want to use zlib in your project, you need to find the header file `zlib.h`, and the library `libz.so` (on Linux). You can use the low-level cmake commands `find_path` and `find_library` to find them, or you can use `find_package(ZLIB)`. The later command will try to find out all what is necessary to use zlib. It can be extra macro definitions, or dependencies.
  * > **Update, more detail about `find_package`**: when the CMake command `find_package(SomeThing)` is called, [as in the documentation](https://cmake.org/cmake/help/v3.0/command/find_package.html), there are two possible modes that cmake can run:
    + > the module mode (that searches for a file `FindSomeThing.cmake`)
    + > or the config mode (that searches for a file named `SomeThingConfig.cmake`)
  * > For ZLIB, there is a module named `FindZLIB`, shipped with CMake itself (on my Linux machine that is the file `/usr/share/cmake/Modules/FindZLIB.cmake`). That module is a CMake script that uses the CMake API to search for ZLIB files in default locations, or ask the user for the location if it cannot be found automatically.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `include_directories()`

include_directories https://cmake.org/cmake/help/v3.24/command/include_directories.html
- > The include directories are added to the `INCLUDE_DIRECTORIES` directory property for the current CMakeLists file. They are also added to the `INCLUDE_DIRECTORIES` target property for each target in the current CMakeLists file. The target property values are the ones used by the generators.

### 如何打印出当前 include_directories 后的头文件包含目录？

Listing include_directories in CMake https://stackoverflow.com/questions/6902149/listing-include-directories-in-cmake
- 【[:star:][`*`]】 https://stackoverflow.com/questions/6902149/listing-include-directories-in-cmake/6904431#6904431
  * > You can use the `get_property` command to retrieve the value of the directory property `INCLUDE_DIRECTORIES`. Something like this:
    ```cmake
    get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
    foreach(dir ${dirs})
      message(STATUS "dir='${dir}'")
    endforeach()
    ```
  * > The value of this directory property only tracks the `include_directories` commands that have occurred previously in the same CMakeLists file, or that have been inherited from previous occurrences in a parent CMakeLists file. If your `find_package` and `include_directories` commands are scattered about throughout many subdirectories, this becomes a challenging issue.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `set()`

set https://cmake.org/cmake/help/v3.0/command/set.html
- > Set a CMake, cache or environment variable to a given value.
  ```cmake
  set(<variable> <value>
      [[CACHE <type> <docstring> [FORCE]] | PARENT_SCOPE])
  ```
- > Within CMake sets `<variable>` to the value `<value>`. `<value>` is expanded before `<variable>` is set to it. ***Normally, `set` will set a `regular CMake variable`. If `CACHE` is present, then the `<variable>` is put in the `cache` instead, unless it is already in the cache***. See section [‘Variable types in CMake’]() below for details of `regular and cache variables` and their interactions. If `CACHE` is used, `<type>` and `<docstring>` are required. `<type>` is used by the CMake GUI to choose a widget with which the user sets a value. The value for `<type>` may be one of
  ```console
  FILEPATH = File chooser dialog.
  PATH     = Directory chooser dialog.
  STRING   = Arbitrary string.
  BOOL     = Boolean ON/OFF checkbox.
  INTERNAL = No GUI entry (used for persistent variables).
  ```
  > If `<type>` is `INTERNAL`, the `cache variable` is marked as internal, and will not be shown to the user in tools like `cmake-gui`. This is intended for values that should be persisted in the cache, but which users should not normally change. ***`INTERNAL` implies `FORCE`***.
  > 
  > Normally, `set(…CACHE…)` creates `cache variables`, but does not modify them. If `FORCE` is specified, the value of the `cache variable` is set, even if the variable is already in the cache. This should normally be avoided, as it will remove any changes to the cache variable’s value by the user.
- > **Variable types in CMake**
  * > In CMake there are <ins>***two***</ins> types of variables: `normal variables` and `cache variables`. `Normal variables` are meant for the internal use of the script (***just like variables in most programming languages***); they are not persisted across CMake runs. `Cache variables` (unless set with `INTERNAL`) are mostly intended for configuration settings where the first CMake run determines a suitable default value, which the user can then override, by editing the cache with tools such as `ccmake` or `cmake-gui`. `Cache variables` are stored in the `CMake cache file`, and are persisted across CMake runs.
  * > ***Both types can exist at the same time with the same name but different values***. When `${FOO}` is evaluated, CMake first looks for a normal variable ‘FOO’ in scope and uses it if set. If and only if no normal variable exists then it falls back to the cache variable ‘FOO’.
  * > Some examples:
    + > The code ‘set(FOO “x”)’ sets the normal variable ‘FOO’. It does not touch the cache, but it will hide any existing cache value ‘FOO’.
    + > The code ‘set(FOO “x” CACHE …)’ checks for ‘FOO’ in the cache, ignoring any normal variable of the same name. If ‘FOO’ is in the cache then nothing happens to either the normal variable or the cache variable. If ‘FOO’ is not in the cache, then it is added to the cache.
  * > Finally, whenever a cache variable is added or modified by a command, CMake also removes the normal variable of the same name from the current scope so that an immediately following evaluation of it will expose the newly cached value.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
