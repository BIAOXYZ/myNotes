
# 主页

CMake Examples https://github.com/ttroy50/cmake-examples || http://ttroy50.github.io/cmake-examples/
- > **Other Links**: There are many CMake tutorials and examples online. The list below includes links to some of these which I have found helpful in my CMake journey.

# 笔记

Hello Headers https://github.com/ttroy50/cmake-examples/blob/master/01-basic/B-hello-headers/README.adoc
- > An alternative to setting specific file names in the SOURCES variable is to use a `GLOB` command to find files using wildcard pattern matching.
  ```cmake
  file(GLOB SOURCES "src/*.cpp")
  ```
