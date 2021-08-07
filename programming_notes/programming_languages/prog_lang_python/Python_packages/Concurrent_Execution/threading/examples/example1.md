
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
