
# 1

系统级性能分析工具perf的介绍与使用 https://www.cnblogs.com/arnoldlu/p/6241297.html

```c
#include <stdio.h>

void test_little(void)
{
  int i,j;

  for(i = 0; i < 30000000; i++) 
    j=i; 
}

void test_mdedium(void)
{
  int i,j;

  for(i = 0; i < 60000000; i++) 
    j=i; 
}

void test_high(void)
{
  int i,j;

  for(i = 0; i < 90000000; i++) 
    j=i; 
}

void test_hi(void)
{
  int i,j;

  for(i = 0; i < 120000000; i++) 
    j=i; 
}

int main(void)
{
  int i, pid, result;

  for(i = 0; i<2; i++) {
    result = fork();
    if(result>0)
      printf("i=%d parent parent=%d current=%d child=%d\n", i, getppid(), getpid(), result);
    else
      printf("i=%d child parent=%d current=%d\n", i, getppid(), getpid());

    if(i==0)
    {
      test_little();
      sleep(1);
    } else {
      test_mdedium();
      sleep(1);
    }
  }

  pid = wait(NULL);
  test_high();
  printf("pid=%d wait=%d\n", getpid(), pid);
  sleep(1);
  pid = wait(NULL);
  test_hi();
  printf("pid=%d wait=%d\n", getpid(), pid);
  return 0;
}
```
```sh
root# gcc fork.c -o fork-g -O0
root#
root# perf record -a -g ./fork-g
i=0 parent parent=2399658 current=2399662 child=2399671
i=0 child parent=2399662 current=2399671
i=1 parent parent=2399662 current=2399671 child=2399713
i=1 child parent=2399671 current=2399713
i=1 parent parent=2399658 current=2399662 child=2399714
i=1 child parent=2399662 current=2399714
pid=2399713 wait=-1
pid=2399714 wait=-1
pid=2399713 wait=-1
pid=2399714 wait=-1
pid=2399671 wait=2399713
pid=2399662 wait=2399714
pid=2399671 wait=-1
pid=2399662 wait=2399671
[ perf record: Woken up 12 times to write data ]
[ perf record: Captured and wrote 4.391 MB perf.data (25337 samples) ]
root#
root# ls
fork.c  fork-g  perf.data
root#
root# perf report --call-graph none
root#
root# perf report --call-graph none -c fork
root#
root# perf report -i perf.data
```

# 2

【[:star:][`*`]】 用Perf寻找程序中的性能热点 - hugulas的文章 - 知乎 https://zhuanlan.zhihu.com/p/134721612

perf的基本使用方法 https://blog.csdn.net/jasonactions/article/details/109332167 || https://www.coonote.com/vim-note/perf-usage.html

如何用perf工具 https://www.cnblogs.com/mysky007/p/12307642.html
