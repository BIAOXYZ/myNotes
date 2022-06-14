
# 1

Python threading. How do I lock a thread? https://stackoverflow.com/questions/10525185/python-threading-how-do-i-lock-a-thread
- https://stackoverflow.com/questions/10525185/python-threading-how-do-i-lock-a-thread/10525433#10525433

## 个人实战该部分

```py
import threading
import time
import inspect

class Thread(threading.Thread):
    def __init__(self, t, *args):
        threading.Thread.__init__(self, target=t, args=args)
        self.start()

count = 0
lock = threading.Lock()

def incre():
    global count
    caller = inspect.getouterframes(inspect.currentframe())[1][3]
    print "Inside %s()" % caller
    print "Acquiring lock"
    with lock:
        print "Lock Acquired"
        count += 1  
        time.sleep(2)  

def bye():
    while count < 5:
        incre()

def hello_there():
    while count < 5:
        incre()

def main():    
    hello = Thread(hello_there)
    goodbye = Thread(bye)


if __name__ == '__main__':
    main()
```

两种输出都是有可能的：
```console
$ python main.py
Inside hello_there()Inside bye()
Acquiring lock

Lock Acquired
Acquiring lock
Lock Acquired
Inside bye()
Acquiring lock
Lock Acquired
Inside hello_there()
Acquiring lock
Lock Acquired
Inside bye()
Acquiring lock
Lock Acquired
Inside hello_there()
Acquiring lock
Lock Acquired
```
```console
$ python main.py
Inside hello_there()Inside bye()
Acquiring lock

Lock Acquired
Acquiring lock
Lock Acquired
Inside hello_there()
Acquiring lock
Lock Acquired
Inside bye()
Acquiring lock
Lock Acquired
Inside hello_there()
Acquiring lock
Lock Acquired
Inside bye()
Acquiring lock
Lock Acquired
```

# 2

python学习之路--threading Lock对象 https://blog.csdn.net/Mybigkid/article/details/78375529

## 个人实战文章里的例子

```py
import threading
ticket_lock = threading.Lock()
ticket_nums = 20

class SaleTicketThread(threading.Thread):
    def __init__(self, name):
        threading.Thread.__init__(self)
        self.name = name
        print "init thread:%s" % self.name

    def run(self):
        global ticket_nums
        while ticket_nums > 0:
            ticket_lock.acquire()

            ticket_nums = ticket_nums - 1
            print "%s sell a ticket and %s tickets left" % (self.name, ticket_nums)
            ticket_lock.release()

thread_names_list = ["Thread-1", "Thread-2"]
threads = []

for name in thread_names_list:
    thread = SaleTicketThread(name)
    threads.append(thread)

for thread in threads:
    thread.start()

for thread in threads:
    thread.join()

print "Exit main thread"
```
```console
init thread:Thread-1
init thread:Thread-2
Thread-1 sell a ticket and 19 tickets left
Thread-1 sell a ticket and 18 tickets left
Thread-1 sell a ticket and 17 tickets left
Thread-1 sell a ticket and 16 tickets left
Thread-1 sell a ticket and 15 tickets left
Thread-1 sell a ticket and 14 tickets left
Thread-1 sell a ticket and 13 tickets left
Thread-2 sell a ticket and 12 tickets left
Thread-2 sell a ticket and 11 tickets left
Thread-2 sell a ticket and 10 tickets left
Thread-2 sell a ticket and 9 tickets left
Thread-2 sell a ticket and 8 tickets left
Thread-2 sell a ticket and 7 tickets left
Thread-2 sell a ticket and 6 tickets left
Thread-2 sell a ticket and 5 tickets left
Thread-2 sell a ticket and 4 tickets left
Thread-2 sell a ticket and 3 tickets left
Thread-2 sell a ticket and 2 tickets left
Thread-2 sell a ticket and 1 tickets left
Thread-2 sell a ticket and 0 tickets left
Thread-1 sell a ticket and -1 tickets left
Exit main thread
```
>> //notes：每次run的结果不一定相同，也可能是下面的输出：
```console
init thread:Thread-1
init thread:Thread-2
Thread-1 sell a ticket and 19 tickets left
Thread-1 sell a ticket and 18 tickets left
Thread-1 sell a ticket and 17 tickets left
Thread-1 sell a ticket and 16 tickets left
Thread-1 sell a ticket and 15 tickets left
Thread-1 sell a ticket and 14 tickets left
Thread-2 sell a ticket and 13 tickets left
Thread-2 sell a ticket and 12 tickets left
Thread-2 sell a ticket and 11 tickets left
Thread-2 sell a ticket and 10 tickets left
Thread-2 sell a ticket and 9 tickets left
Thread-1 sell a ticket and 8 tickets left
Thread-1 sell a ticket and 7 tickets left
Thread-2 sell a ticket and 6 tickets left
Thread-2 sell a ticket and 5 tickets left
Thread-2 sell a ticket and 4 tickets left
Thread-2 sell a ticket and 3 tickets left
Thread-2 sell a ticket and 2 tickets left
Thread-1 sell a ticket and 1 tickets left
Thread-1 sell a ticket and 0 tickets left
Thread-2 sell a ticket and -1 tickets left
Exit main thread
```
