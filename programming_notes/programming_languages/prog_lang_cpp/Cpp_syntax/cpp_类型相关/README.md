
# 数据类型的后缀表示法

What do 0LL or 0x0UL mean? https://stackoverflow.com/questions/7036056/what-do-0ll-or-0x0ul-mean

0L vs 0LL in std::accumulate function in C++ https://codeforces.com/blog/entry/91004
- 回复里的：
  * > 0L= long (32 bits) 0LL= long long(64 bits)
    >> yeah! but the question is why does it work in ideone and not on codeforces? is there any difference I should be aware of?
    >>> Probably long is 64-bit on ideone. ***In c++ types like `int` or `long` have no fixed size and are architecture-defined***
  * > It's not really about the compiler either. It can differ by platform/os. long is 32 bit on (mainly) windows, long is 64 bit mostly everywhere else. (Assuming not exotic and not ancient hardware.) https://en.wikipedia.org/wiki/64-bit_computing#64-bit_data_models

C++基本数据类型总结 https://www.cnblogs.com/zrtqsk/p/4369864.html
- > **三、前缀和后缀**。
  * > 1、前缀：
    + > 0开头表示8进制，0x或0X开头表示16进制。
  * > 2、后缀：
    * > —— l或L表示 `long` 常量
    * > —— u或U表示 `unsigned int` 常量
    * > —— ul、uL、Ul、UL、lU、lu、LU、Lu表示 `unsigned long` 常量。（lu可以采用任意顺序和大小写表示）
    * > —— ll、LL表示 `long long` 常量。
    * > —— ull、Ull、uLL、ULL表示 `unsigned long long` 常量。
