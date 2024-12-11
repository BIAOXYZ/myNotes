
# 官方

`<cstdlib> (stdlib.h)` http://www.cplusplus.com/reference/cstdlib/
- **String conversion**
  * atoi http://www.cplusplus.com/reference/cstdlib/atoi/
- **Dynamic memory management**
  * calloc https://cplusplus.com/reference/cstdlib/calloc/
  * free https://cplusplus.com/reference/cstdlib/free/
  * malloc http://www.cplusplus.com/reference/cstdlib/malloc/
  * realloc https://cplusplus.com/reference/cstdlib/realloc/
- **Integer arithmetics**
  * abs http://www.cplusplus.com/reference/cstdlib/abs/
- **Environment**
  * `getenv()` https://cplusplus.com/reference/cstdlib/getenv/

`std::getenv` https://en.cppreference.com/w/cpp/utility/program/getenv

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `calloc`

calloc https://cplusplus.com/reference/cstdlib/calloc/
- > `void* calloc (size_t num, size_t size);`
- > **Allocate and zero-initialize array**
  * > Allocates a block of memory for an array of `num` elements, each of them `size` bytes long, ***and initializes all its bits to zero***.
  * > The effective result is ***the allocation of a zero-initialized memory block of (`num*size`) bytes***.
  * > If size is zero, the return value depends on the particular library implementation (it may or may not be a null pointer), but the returned pointer shall not be dereferenced.
- > **Return Value**
  * > On success, a pointer to the memory block allocated by the function.
  * > ***The type of this pointer is always `void*`***, which can be cast to the desired type of data pointer in order to be dereferenceable.
    >> //notes：所以 `calloc` 类似 `malloc`，返回的指针需要进行强制类型转换后才能解引用。
  * > If the function ***failed to allocate*** the requested block of memory, a ***null pointer*** is returned.
- > **Example**
  ```c
  /* calloc example */
  #include <stdio.h>      /* printf, scanf, NULL */
  #include <stdlib.h>     /* calloc, exit, free */

  int main ()
  {
    int i,n;
    int * pData;
    printf ("Amount of numbers to be entered: ");
    scanf ("%d",&i);
    pData = (int*) calloc (i,sizeof(int));
    if (pData==NULL) exit (1);
    for (n=0;n<i;n++)
    {
      printf ("Enter number #%d: ",n+1);
      scanf ("%d",&pData[n]);
    }
    printf ("You have entered: ");
    for (n=0;n<i;n++) printf ("%d ",pData[n]);
    free (pData);
    return 0;
  }
  ```
  > This program simply stores numbers and then prints them out. But the number of items it stores can be adapted each time the program is executed because it allocates the needed memory during runtime.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `free`

free https://cplusplus.com/reference/cstdlib/free/
- > `void free (void* ptr);`
- > **Deallocate memory block**
  * > A block of memory previously allocated by a call to `malloc`, `calloc` or `realloc` is deallocated, making it available again for further allocations.
  * > If `ptr` does not point to a block of memory allocated with the above functions, it causes ***undefined behavior***.
  * > If ptr is a ***null pointer***, the function does nothing.
  * > Notice that this function ***<ins>does not change the value of `ptr` itself</ins>, hence it <ins>still points to the same (now invalid) location</ins>***.
    >> 【[ :star: ][`*`]】 //notes：`free` 函数不会改变指针本身的值（***改变的是指向的地址里的内容***），它仍然指向相同的（现在无效的）位置。
- > **Example**
  ```c
  /* free example */
  #include <stdlib.h>     /* malloc, calloc, realloc, free */

  int main ()
  {
    int * buffer1, * buffer2, * buffer3;
    buffer1 = (int*) malloc (100*sizeof(int));
    buffer2 = (int*) calloc (100,sizeof(int));
    buffer3 = (int*) realloc (buffer2,500*sizeof(int));
    free (buffer1);
    free (buffer3);
    return 0;
  }
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `malloc`

malloc http://www.cplusplus.com/reference/cstdlib/malloc/
- > `void* malloc (size_t size);`
- > **Allocate memory block**
  * > Allocates a block of `size` bytes of memory, returning a pointer to the beginning of the block.
  * > ***The content of the newly allocated block of memory is not initialized***, remaining with indeterminate values.
  * > If size is zero, the return value depends on the particular library implementation (it may or may not be a null pointer), but the returned pointer shall not be dereferenced.
- > **Return Value**
  * > On success, a pointer to the memory block allocated by the function.
  * > ***The type of this pointer is always `void*`***, which can be cast to the desired type of data pointer in order to be dereferenceable.
    >> //notes：所以 `malloc` 返回的指针需要进行强制类型转换后才能解引用。
  * > If the function ***failed to allocate*** the requested block of memory, a **null pointer** is returned.
- > **Example**
  ```c
  /* malloc example: random string generator*/
  #include <stdio.h>      /* printf, scanf, NULL */
  #include <stdlib.h>     /* malloc, free, rand */

  int main ()
  {
    int i,n;
    char * buffer;

    printf ("How long do you want the string? ");
    scanf ("%d", &i);

    buffer = (char*) malloc (i+1);
    if (buffer==NULL) exit (1);

    for (n=0; n<i; n++)
      buffer[n]=rand()%26+'a';
    buffer[i]='\0';

    printf ("Random string: %s\n",buffer);
    free (buffer);

    return 0;
  }
  ```
  > This program generates a string of the length specified by the user and fills it with alphabetic characters. The possible length of this string is only limited by the amount of memory available to `malloc`

malloc https://en.cppreference.com/w/c/memory/malloc

C动态内存分配 https://zh.wikipedia.org/wiki/C%E5%8A%A8%E6%80%81%E5%86%85%E5%AD%98%E5%88%86%E9%85%8D
- > 函数概述

  | 函数 | 描述 |
  | --- | --- |
  | malloc	| 分配指定数量的字节 |
  | realloc | 调整指定内存块的大小，必要时会重新分配 |
  | calloc | 分配指定数量的字节，并初始化为 0 |
  | free | 释放指定的内存块 |

- > **类型安全**
  * > `malloc` 所执行的内存分配基于字节数而不是类型，其返回类型为 void 指针 `（void *）`，表示该指针所指向区域的数据类型未知。C++ 由于其强类型系统，***实际使用该指针时需要进行强制类型转换***，而 C 语言中则不必进行。
    ```c
    int * ptr;
    ptr = malloc(10 * sizeof(int));		/* 不进行强制类型转换 */
    ptr = (int *)malloc(10 * sizeof(int));	/* 进行强制类型转换 */
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `realloc`

realloc https://cplusplus.com/reference/cstdlib/realloc/
- > `void* realloc (void* ptr, size_t size);`
- > **Reallocate memory block**
  * > Changes the size of the memory block pointed to by `ptr`.
  * > The function ***may move the memory block to a new location*** (whose address is returned by the function).
  * > ***The content of the memory block is preserved up to the lesser of the new and old sizes, even if the block is moved to a new location***. If the ***new size is larger, the value of the newly allocated portion is indeterminate***.
  * > In case that `ptr` is a ***null pointer***, the function ***behaves like `malloc`***, assigning a new block of size bytes and returning a pointer to its beginning.
- > **Example**
  ```c
  /* realloc example: rememb-o-matic */
  #include <stdio.h>      /* printf, scanf, puts */
  #include <stdlib.h>     /* realloc, free, exit, NULL */

  int main ()
  {
    int input,n;
    int count = 0;
    int* numbers = NULL;
    int* more_numbers = NULL;

    do {
       printf ("Enter an integer value (0 to end): ");
       scanf ("%d", &input);
       count++;

       more_numbers = (int*) realloc (numbers, count * sizeof(int));

       if (more_numbers!=NULL) {
         numbers=more_numbers;
         numbers[count-1]=input;
       }
       else {
         free (numbers);
         puts ("Error (re)allocating memory");
         exit (1);
       }
    } while (input!=0);

    printf ("Numbers entered: ");
    for (n=0;n<count;n++) printf ("%d ",numbers[n]);
    free (numbers);

    return 0;
  }
  ```
  > The program prompts the user for numbers until a zero character is entered. Each time a new value is introduced the memory block pointed by numbers is increased by the size of an int.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `qsort()`

qsort http://www.cplusplus.com/reference/cstdlib/qsort/

qsort, qsort_s https://en.cppreference.com/w/c/algorithm/qsort

qsort https://en.wikipedia.org/wiki/Qsort

qsort(3) - Linux man page https://linux.die.net/man/3/qsort

qsort https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/qsort

C语言qsort函数用法 https://www.cnblogs.com/eniac12/p/4769229.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `getenv()`

C/C++ 获取系统环境变量方法. https://www.cnblogs.com/algorithmic/archive/2012/09/23/2698604.html

C/C++ 获取环境变量的值 https://blog.csdn.net/xuebing1995/article/details/110659393

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `strtoul()`

C语言strtoul函数简介 https://blog.csdn.net/qq_37858386/article/details/78458401

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

Is there any difference in the way `atof` and `strtod` work? https://stackoverflow.com/questions/67353927/is-there-any-difference-in-the-way-atof-and-strtod-work
- https://stackoverflow.com/questions/67353927/is-there-any-difference-in-the-way-atof-and-strtod-work/67353969#67353969

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
