
# pyinstrument

## 官方

pyinstrument -- 🚴 Call stack profiler for Python. Shows you why your code is slow! https://github.com/joerick/pyinstrument

pyinstrument https://pyinstrument.readthedocs.io/en/latest/

# 个人实战1

http://www.coolpython.net/python_senior/third_module/pyinstrument.html
>> //notes：并没有用原文的代码，而是自己想看看为什么这三种构造 list 的方式性能会差这么多。。。 
```py
import datetime

from pyinstrument import Profiler
profiler = Profiler()
profiler.start()

t1 = datetime.datetime.now()
n = 10**8
l1 = list(range(n))

i = 0
l2 = []
while i < n:
    l2.append(l1[i])
    i += 1
t2 = datetime.datetime.now()
print(t2-t1)

l3 = [elem for elem in l1]
t3 = datetime.datetime.now()
print(t3-t2)

l4 = [0] * n
for j in range(n):
    l4[j] = l1[j]
t4 = datetime.datetime.now()
print(t4-t3)

profiler.stop()
print(profiler.output_text(unicode=True, color=True))
```
```sh
$ python3 test1.py 
0:00:40.538651
0:00:03.820554
0:00:12.384084

  _     ._   __/__   _ _  _  _ _/_   Recorded: 08:32:50  Samples:  34715
 /_//_/// /_\ / //_// / //_'/ //     Duration: 56.744    CPU time: 56.724
/   _/                      v4.1.1

Program: test1.py

56.743 <module>  test1.py:1
├─ 42.918 [self]  
├─ 10.004 list.append  <built-in>:0
│     [2 frames hidden]  <built-in>
└─ 3.821 <listcomp>  test1.py:19


$ 
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# py-spy

Python 程序如何定位到 cpu 占用过高的代码呢 https://www.v2ex.com/t/829743
- > https://github.com/emeryberger/scalene
  >> Scalene: a high-performance, high-precision CPU, GPU, and memory profiler for Python https://github.com/plasma-umass/scalene
- > https://github.com/benfred/py-spy
- > dtrace / bpftrace

## 其他

Python 程序性能分析和火焰图 https://xie.infoq.cn/article/74483a0917668dc17324d0313
