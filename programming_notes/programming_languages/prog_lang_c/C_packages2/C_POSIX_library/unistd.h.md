
# 官方

unistd.h https://en.wikipedia.org/wiki/Unistd.h

unistd.h - standard symbolic constants and types https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/unistd.h.html

# 其他

C++ alternative to C header files http://www.cpp.re/forum/unices/168187/
- > The 4 remaining headers are Unix specific and AFAIK there are no c++ equivalent headers.

# `readlink()`

Linux C 获取当前进程可执行文件路径 https://blog.csdn.net/yasi_xi/article/details/38039589
```c
#include <stdio.h>
#include <unistd.h>
#include <linux/limits.h>
 
int main() {
	char dir[PATH_MAX] = {0};
	int n = readlink("/proc/self/exe", dir, PATH_MAX);
	printf("PATH_MAX: %d\n", PATH_MAX);
	printf("readlink return: %d\n", n);
	printf("dir: %s\n", dir);
	return 0;
}
//////////////////////////////////////////////////
// 在作者本地机器上，上面文件生成的可执行文件是 /home/yasi/tmp/t，执行结果如下：
PATH_MAX: 4096
readlink return: 16
dir: /home/yasi/tmp/t
```
