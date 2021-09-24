
cmake https://blog.csdn.net/rangfei/category_10398401.html
- cmake(3)：编译库和链接可执行文件 https://blog.csdn.net/rangfei/article/details/108756768

What is the purpose of a `.cmake` file? https://stackoverflow.com/questions/46456498/what-is-the-purpose-of-a-cmake-file
- https://stackoverflow.com/questions/46456498/what-is-the-purpose-of-a-cmake-file/46456654#46456654
  * > You can include it with the include command. Similar to how other languages allow you to split source files into modules or header files, they can contain function definitions, macros which can then be reused across multiple CmakeLists.
  * > See https://cmake.org/cmake/help/v3.0/command/include.html
  * > Note that you can actually include any file, but a `.cmake` extension is commonly used.
