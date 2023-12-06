
# 1

Python 3 Asynchronous Programming异步编程入门 https://www.youtube.com/playlist?list=PLfQqWeOCIH4ClkdjqvTuc9hnCnagSlBHE

asyncio demo https://github.com/xiaopeng163/asyncio-demo
- https://github.com/xiaopeng163/asyncio-demo/blob/master/print_msg.py
- https://github.com/xiaopeng163/asyncio-demo/blob/master/task.py
- https://github.com/xiaopeng163/asyncio-demo/blob/master/async_main.py


## 1.1

`4. 自己实现一个task manager` https://www.youtube.com/watch?v=0t0RD9H_80s

**`print_msg.py`**
```py
import time
from datetime import datetime

def print_message_periodical(interval_seconds, message='keep alive'):
    while True:
        print(f'{datetime.now()} - {message}')
        start = time.time()
        end = start + interval_seconds
        while True:
            yield
            now = time.time()
            if now >= end:
                break

if __name__ == "__main__":
    a = print_message_periodical(3, 'three')
    b = print_message_periodical(10, 'ten')
    stack = [a, b]
    while True:
        for task in stack:
            next(task)
```
```console
2023-12-06 17:16:53.419078 - three
2023-12-06 17:16:53.419162 - ten
2023-12-06 17:16:56.419164 - three
2023-12-06 17:16:59.419224 - three
2023-12-06 17:17:02.419282 - three
2023-12-06 17:17:03.419312 - ten
2023-12-06 17:17:05.419347 - three
2023-12-06 17:17:08.419409 - three
2023-12-06 17:17:11.419473 - three
2023-12-06 17:17:13.419365 - ten
...
...
...
```

**`task.py`（同时也需要上面的`print_msg.py`）**
```py
from queue import deque
from print_msg import print_message_periodical

class Task:

    next_id = 0

    def __init__(self, routine):
        self.id = Task.next_id
        Task.next_id += 1
        self.routine = routine

class Scheduler:

    def __init__(self):
        self.runnable_tasks = deque()
        self.completed_task_results = {}
        self.failed_task_errors = {}
    
    def add(self, routine):
        task = Task(routine)
        self.runnable_tasks.append(task)
        return task.id
    
    def run_to_completion(self):
        while len(self.runnable_tasks) !=0:
            task = self.runnable_tasks.popleft()
            try:
                yielded = next(task.routine)
            except StopIteration as stopped:
                print(f'completed with result: {stopped.value}')
                self.completed_task_results[task.id] = stopped.value
            except Exception as e:
                print(f'failed with exception: {e}')
                self.failed_task_errors[task.id] = e
            else:
                assert yielded is None
                self.runnable_tasks.append(task)

if __name__ == "__main__":
    sch = Scheduler()
    sch.add(print_message_periodical(3, 'three'))
    sch.add(print_message_periodical(10, 'ten'))
    sch.run_to_completion()
```
```console
2023-12-06 17:19:44.076496 - three
2023-12-06 17:19:44.076548 - ten
2023-12-06 17:19:47.076551 - three
2023-12-06 17:19:50.076615 - three
2023-12-06 17:19:53.076677 - three
2023-12-06 17:19:54.076560 - ten
2023-12-06 17:19:56.076738 - three
2023-12-06 17:19:59.076801 - three
2023-12-06 17:20:02.076865 - three
2023-12-06 17:20:04.076622 - ten
...
...
...
```

## 1.2

`5. asyncio的基本语法` https://www.youtube.com/watch?v=AGStfu7o-7I

```py
import asyncio
import time
from math import sqrt
from datetime import datetime

async def print_message_periodical(interval_seconds, message='keep alive'):
    while True:
        print(f'{datetime.now()} - {message}')
        start = time.time()
        end = start + interval_seconds
        while True:
            await asyncio.sleep(0)
            now = time.time()
            if now >= end:
                break

if __name__ == "__main__":
    scheduler = asyncio.get_event_loop()
    scheduler.create_task(
        print_message_periodical(3, 'three')
    )
    scheduler.create_task(
        print_message_periodical(10, 'ten')
    )
    scheduler.run_forever()
```
```console
/home/main.py:18: DeprecationWarning: There is no current event loop
  scheduler = asyncio.get_event_loop()
2023-12-06 17:29:40.741057 - three
2023-12-06 17:29:40.741101 - ten
2023-12-06 17:29:43.741097 - three
2023-12-06 17:29:46.741146 - three
2023-12-06 17:29:49.741192 - three
2023-12-06 17:29:50.741114 - ten
2023-12-06 17:29:52.741229 - three
2023-12-06 17:29:55.741281 - three
2023-12-06 17:29:58.741326 - three
2023-12-06 17:30:00.741167 - ten
...
...
...
```
