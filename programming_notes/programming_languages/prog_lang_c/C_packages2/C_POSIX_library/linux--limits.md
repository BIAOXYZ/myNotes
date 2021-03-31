
# 官方

limits.h - implementation-defined constants https://pubs.opengroup.org/onlinepubs/009696699/basedefs/limits.h.html

limits.h - implementation-defined constants https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html

limits.h https://github.com/torvalds/linux/blob/master/include/uapi/linux/limits.h
- `#define PATH_MAX        4096	/* # chars in a path name including nul */` https://github.com/torvalds/linux/blob/54d50897d544c874562253e2a8f70dfcad22afe8/include/uapi/linux/limits.h#L13

# 和C标准库里的limits.h的区别

目前就知道两点：
- 引用这个库一般用`#include <linux/limits.h>`，引用C标准库里的一般用`#include <limits.h>`。
- 这个库里有宏`PATH_MAX`的定义，C标准库里的那个没有。

Where is PATH_MAX defined in Linux? https://stackoverflow.com/questions/9449241/where-is-path-max-defined-in-linux

# 其他
