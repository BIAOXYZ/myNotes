
## `.local()`  

threading.local()使用与原理剖析 https://www.cnblogs.com/Yunya-Cnblogs/p/13222482.html

### 个人实战文章代码

```py
import threading
import time

def operate(name):
    """操作"""
    print("三个月后,{0}忽然想起了自己有件东西放在柜子里，决定取出来".format(name))
    print("最后他从自己的柜子里取出来了:",Locker.article)

def people(article):
    name = threading.current_thread().getName()  # 获取线程名
    Locker.article = article  #  这就表示将私有的的一件物品放在了寄存柜里
    print("{0}将{1}放在了寄存柜里...".format(name,article))
    time.sleep(3)  # 过了三个月，这期间发生了很多事
    operate(name)

if __name__ == '__main__':
    Locker = threading.local()  # 好了寄存柜放在全局了
    t1 = threading.Thread(target=people,args=("一封情书",),name="小王")
    t2 = threading.Thread(target=people,args=("一双臭袜子",),name="小李")
    t1.start()
    t2.start()
    t1.join()
    t2.join()
```
```console
小李将一双臭袜子放在了寄存柜里...
/home/main.py:10: DeprecationWarning: getName() is deprecated, get the name attribute instead
  name = threading.current_thread().getName()  # 获取线程名
小王将一封情书放在了寄存柜里...
三个月后,小李忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一双臭袜子
三个月后,小王忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一封情书
```

```py
import threading
import time

Locker = {}  # 好了寄存柜放在全局了
"""
{
线程id:{"article":"存放的具体物品"}，
线程id:{"article":"存放的具体物品"}，
线程id:{"article":"存放的具体物品"}，
}
"""

def operate(name):
    """操作"""
    print("三个月后,{0}忽然想起了自己有件东西放在柜子里，决定取出来".format(name))
    ident = threading.get_ident()  # 获取线程ID
    print("最后他从自己的柜子里取出来了:",Locker[ident]["article"])

def people(article):
    name = threading.current_thread().getName()  # 获取线程名
    ident = threading.get_ident()  # 获取线程ID
    Locker[ident] = {}  # 创建了一个寄存柜的小格子
    Locker[ident]["article"] = article  # 这就表示将私有的的一件物品放在了寄存柜里
    print("{0}将{1}放在了寄存柜里...".format(name,article))
    time.sleep(3)  # 过了三个月，这期间发生了很多事
    operate(name)

if __name__ == '__main__':
    t1 = threading.Thread(target=people,args=("一封情书",),name="小王")
    t2 = threading.Thread(target=people,args=("一双臭袜子",),name="小李")
    t1.start()
    t2.start()
    t1.join()
    t2.join()
```
```console
小李将一双臭袜子放在了寄存柜里...
/home/main.py:20: DeprecationWarning: getName() is deprecated, get the name attribute instead
  name = threading.current_thread().getName()  # 获取线程名
小王将一封情书放在了寄存柜里...
三个月后,小李忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一双臭袜子
三个月后,小王忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一封情书
```

```py
import threading
import time

class MyLocker(object):
    cabinet = {}  # 柜子
    """
    {
    线程id:{"article":"存放的具体物品"}，
    线程id:{"article":"存放的具体物品"}，
    线程id:{"article":"存放的具体物品"}，
    }
    """

    def __getattr__(self, item):
        """当访问属性不存在时触发"""
        ident = threading.get_ident()
        return MyLocker.cabinet[ident][item]

    def __setattr__(self, key, value):
        """试图用 . 去设置属性时触发"""
        ident = threading.get_ident()
        if ident in MyLocker.cabinet:  # 如果在柜子里这重新赋值
            MyLocker.cabinet[ident][key] = value
        else:
            MyLocker.cabinet[ident] = {key: value}  # 如果不在则做一个小格子，并且把物件存放进来

def operate(name):
    """操作"""
    print("三个月后,{0}忽然想起了自己有件东西放在柜子里，决定取出来".format(name))
    print("最后他从自己的柜子里取出来了:", Locker.article)

def people(article):
    name = threading.current_thread().getName()  # 获取线程名
    Locker.article = article  # 这就表示将私有的的一件物品放在了寄存柜里
    print("{0}将{1}放在了寄存柜里...".format(name, article))
    time.sleep(3)  # 过了三个月，这期间发生了很多事
    operate(name)

if __name__ == '__main__':
    Locker = MyLocker()  # 好了寄存柜放在全局了
    t1 = threading.Thread(target=people, args=("一封情书",), name="小王")
    t2 = threading.Thread(target=people, args=("一双臭袜子",), name="小李")
    t1.start()
    t2.start()
    t1.join()
    t2.join()
```
```console
/home/main.py:33: DeprecationWarning: getName() is deprecated, get the name attribute instead
  name = threading.current_thread().getName()  # 获取线程名
小王将一封情书放在了寄存柜里...
小李将一双臭袜子放在了寄存柜里...
三个月后,小王忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一封情书
三个月后,小李忽然想起了自己有件东西放在柜子里，决定取出来
最后他从自己的柜子里取出来了: 一双臭袜子
```
