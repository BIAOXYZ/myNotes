
# 官方

sizeof operator https://en.cppreference.com/w/c/language/sizeof

sizeof operator https://en.cppreference.com/w/cpp/language/sizeof

# 其他

## sizeof某个类型 v.s. sizeof该类型的指针

Size of pointer of integer type vs Size of `int*` https://stackoverflow.com/questions/30436432/size-of-pointer-of-integer-type-vs-size-of-int
- https://stackoverflow.com/questions/30436432/size-of-pointer-of-integer-type-vs-size-of-int/30436797#30436797
  * > Every beginner always gets confused with pointer declaration versus de-referencing the pointer, because the syntax looks the same.
    + > `int *p;` means "declare a pointer to int". You can also write it as `int* p;` (identical meaning, personal preference).
    + > `*p`, when used anywhere else but in the declaration, means "take the contents of what p points at".
  * > Thus `sizeof(*p)` means "***<ins>give me the size of the contents that p points at</ins>***", but `sizeof(int*)` means "***give me the size of the pointer type itself***". On your machine, `int` is apparently 4 bytes but pointers are 8 bytes (typical 64 bit machine).

Difference between `sizeof(int *)` and `sizeof(int)` in C/C++ https://www.geeksforgeeks.org/difference-between-sizeofint-and-sizeofint-in-c-c/
```console
int -- means a variable whose datatype is integer.
sizeof(int) -- returns the number of bytes used to store an integer.
int* -- means a pointer to a variable whose datatype is integer.
sizeof(int*) -- returns the number of bytes used to store a pointer.
```
