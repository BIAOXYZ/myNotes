
# C++ 错误

How to end C++ code https://stackoverflow.com/questions/30250934/how-to-end-c-code
- https://stackoverflow.com/questions/30250934/how-to-end-c-code/1116494#1116494
  * > Call the [`std::exit`](http://en.cppreference.com/w/cpp/utility/program/exit) function. 

return statement vs exit() in main() https://stackoverflow.com/questions/461449/return-statement-vs-exit-in-main

Exit codes in C/C++ with Examples https://www.geeksforgeeks.org/exit-codes-in-c-c-with-examples/
- > **Some of the Exit Codes are:**
  ```console
  exit(1): It indicates abnormal termination of a program perhaps as a result a minor problem in the code.
  exit(2): It is similar to exit(1) but is displayed when the error occurred is a major one. This statement is rarely seen.
  exit(127): It indicates command not found.
  exit(132): It indicates that a program was aborted (received SIGILL), perhaps as a result of illegal instruction or that the binary is probably corrupt.
  exit(133): It indicates that a program was aborted (received SIGTRAP), perhaps as a result of dividing an integer by zero.
  exit(134): It indicates that a program was aborted (received SIGABRT), perhaps as a result of a failed assertion.
  exit(136): It indicates that a program was aborted (received SIGFPE), perhaps as a result of floating point exception or integer overflow.
  exit(137): It indicates that a program took up too much memory.
  exit(138): It indicates that a program was aborted (received SIGBUS), perhaps as a result of unaligned memory access.
  exit(139): It indicates Segmentation Fault which means that the program was trying to access a memory location not allocated to it. This mostly occurs while using pointers or trying to access an out-of-bounds array index.
  exit(158/152): It indicates that a program was aborted (received SIGXCPU), perhaps as a result of CPU time limit exceeded.
  exit(159/153): It indicates that a program was aborted (received SIGXFSZ), perhaps as a result of File size limit exceeded.
  ```

bool型返回值函数，没写return语句的时候返回啥？ https://www.cnblogs.com/whiteBear/p/16122686.html

# C++ 异常

How to throw a C++ exception https://stackoverflow.com/questions/8480640/how-to-throw-a-c-exception
