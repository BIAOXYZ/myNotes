
Is g++ both a c++ compiler and a linker? https://stackoverflow.com/questions/5759353/is-g-both-a-c-compiler-and-a-linker
- https://stackoverflow.com/questions/5759353/is-g-both-a-c-compiler-and-a-linker/5759444#5759444
  * > `g++` and `gcc` are **drivers**. Usually, they run the preprocessor (`cpp`), compiler proper (`cc1plus` for C++ and `cc1` for C) and the linker (`gold` or GNU `ld`) and all other things necessary. The difference between `gcc` and `g++` is that ***the latter includes one additional library to link against (`libstdc++`)***.
  * > Depending on what type of file they are invoked on, they may omit some steps or do things differently. For `.o` files, it doesn't need to run the compiler proper or the preprocessor, for example.
  * > If you pass `-###` to them, you can see it print the tools it invokes in each step of its execution.

What is the difference between g++ and gcc? https://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc
- https://stackoverflow.com/questions/172587/what-is-the-difference-between-g-and-gcc/172592#172592
  * > `gcc` and `g++` are compiler-drivers of ***`the GNU Compiler Collection`*** (***which was once upon a time just `the GNU C Compiler`***).
  * > Even though they automatically determine which backends (`cc1` `cc1plus` ...) to call depending on the file-type, unless overridden with `-x language`, they have some differences.
  * > The probably most important difference in their defaults is which libraries they link against automatically.
  * > According to GCC's online documentation [link options](https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html) and [how g++ is invoked](https://gcc.gnu.org/onlinedocs/gcc/Invoking-G_002b_002b.html), ***`g++` is equivalent to `gcc -xc++ -lstdc++ -shared-libgcc`*** (the 1st is a compiler option, the 2nd two are linker options). This can be checked by running both with the `-v` option (it displays the backend toolchain commands being run).
