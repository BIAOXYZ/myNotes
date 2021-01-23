
# 源头

ld 链接出来的可执行文件无法被执行？提示 No such file or directory https://www.v2ex.com/t/747499
- > 这是我的两个源代码文件
```c
//main.c
#include "stdio.h"
int sum(int *a, int n);

int array[2] = {1, 2};

int main()
{
        int val = sum(array,2);
        printf("%d\n", val);
        return 0;
}
```
```c
//sum.c
int sum(int *a, int n)
{
        int i=0,s =0;
        for(;i<n;i++)
                s+=a[i];
        return s;
}
```
- > 通过以下步骤生成可执行文件：
```sh
# preprocessing
gcc -E main.c -o main.i 
gcc -E sum.c -o sum.i

# compilation
gcc -Og -S main.i -o main.s 
gcc -Og -S sum.i -o sum.s

# assembling
as main.s -o main.o
as sum.s -o sum.o

# linking
ld -o prog sum.o main.o -lc --entry main
```
- > 但是生成的可执行文件运行不了：
```sh
$ ./prog
-bash: ./prog: No such file or directory

$ file ./prog
prog: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib/ld6, not stripped

$ stat prog
  File: prog
  Size: 6424      	Blocks: 16         IO Block: 4096   regular file
Device: 801h/2049d	Inode: 3153139     Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/       u)   Gid: ( 1000/       u)
Access: 2021-01-22 17:41:02.516854257 +0800
Modify: 2021-01-22 17:31:02.969230783 +0800
Change: 2021-01-22 17:40:57.432364965 +0800
 Birth: -
```
- > 我使用的操作系统是 ubuntu 18.04 x86-64
- 回复：
  * > 解决了，gcc 调用 ld 的时候会自动传入很多参数，可以通过 gcc -v 来查看到底传了什么参数 把这些参数复制然后手动传给 ld，就正常了

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战
