
Is g++ both a c++ compiler and a linker? https://stackoverflow.com/questions/5759353/is-g-both-a-c-compiler-and-a-linker
- https://stackoverflow.com/questions/5759353/is-g-both-a-c-compiler-and-a-linker/5759444#5759444
  * > `g++` and `gcc` are **drivers**. Usually, they run the preprocessor (`cpp`), compiler proper (`cc1plus` for C++ and `cc1` for C) and the linker (`gold` or GNU `ld`) and all other things necessary. The difference between `gcc` and `g++` is that ***the latter includes one additional library to link against (`libstdc++`)***.
  * > Depending on what type of file they are invoked on, they may omit some steps or do things differently. For `.o` files, it doesn't need to run the compiler proper or the preprocessor, for example.
  * > If you pass `-###` to them, you can see it print the tools it invokes in each step of its execution.
