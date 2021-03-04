
一段源码， Visual Studio 2019 上编译不成功， Linux 上可以 https://www.v2ex.com/t/758288
- > gcc 肯定是报 warning 了，编译成功不代表运行不 core
- > 因为你没加 `-Wall -Wextra -Werror`，加了 gcc 就也会拒绝编译了
- > 第一个问题是指针变量未初始化就使用。 <br> 第二个问题是 unsigned long 在不同平台上长度不一致，建议改成 strtoull 。
- > 用 gcc/clang 编译的时候，加参数 `-Wall -Wextra -Wpedantic` 是基操，加上以后可以看到如下警告：warning: variable 'str' is uninitialized when used here [-Wuninitialized]
- > 局部变量没有初始化的话初值不一定为 0，指针好像也是这样的，所以 char*还是习惯初始化为 NULL 或者 malloc 。 <br> 如果需求定长 64 位的 int 类型，应该用 stdint.h 标头里的 uint64_t，在 printf/scanf 中用 inttypes.h 标头里的宏 PRIu64/SCNu64，如果是地址应该用 intptr_t/PRIiPTR/SCNiPTR。

一个 msvc 与 gcc/clang 不一致的例子，哪边是对的？ https://www.v2ex.com/t/729105

求问 gcc9 中-O1 比-O0 多了哪些优化选项？ https://www.v2ex.com/t/722402

不懂就问：其他电脑编译好的二进制文件可以直接到其他机器使用吗？ https://www.v2ex.com/t/720696
