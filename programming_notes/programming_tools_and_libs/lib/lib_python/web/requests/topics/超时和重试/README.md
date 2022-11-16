
# requests超时重试

Can I set max_retries for requests.request? https://stackoverflow.com/questions/15431044/can-i-set-max-retries-for-requests-request
- https://stackoverflow.com/questions/15431044/can-i-set-max-retries-for-requests-request/35504626#35504626
- https://stackoverflow.com/questions/15431044/can-i-set-max-retries-for-requests-request/42248509#42248509

python requests 超时与重试 https://www.cnblogs.com/suguangti/p/11950185.html

Handling Retries in Python Requests https://majornetwork.net/2022/04/handling-retries-in-python-requests/

详解Python requests 超时和重试 https://www.jerrycoding.com/article/reqtimeout/

Python Requests.post()请求失败时的retry设置 https://www.jianshu.com/p/f2ea51923a3c

# 个人实战1

## 针对 `requests` 库的同步版本（使用已有的重试相关的参数 `max_retries` —— 可以是简单的一个数，也可以是一个 `Retry` 对象）
```py
# 还有其他比如 time, logging 之类的库省略了，不重要。
import requests
from requests.adapters import HTTPAdapter, Retry

def request_data_sync(self, addr, data_path_dict):
    url = f"http://{addr}/data/table"
    logger.info(f"url is {url}")
    json_request = {
        "sql": data_path_dict["sql"],
        "username": data_path_dict["username"],
        "role": data_path_dict["role"],
        "taskId": generate_random_task_id(), # 随便生成个数就行，不影响下面重试机制的核心代码。这个json里前面的也一样，不用管，只看下面重试机制的代码。
        "dryRun": False
    }
    logger.info(f"json_request is {json_request}")

    sync_mode_timeout = 300
    # 这部分就是 requests 同步式 http 请求的重试机制
    s = requests.Session()
    retries = Retry(total=5,
            allowed_methods=frozenset(['GET', 'POST']),
            backoff_factor=0.1,
            status_forcelist=[500, 502, 503, 504])
    s.mount('http://', HTTPAdapter(max_retries=retries))
    s.mount('https://', HTTPAdapter(max_retries=retries))
    logger.info(f"post for test data start time is {time.strftime('%Y-%m-%d %H:%M:%S')}")
    try:
        r = s.post(url=url, timeout=sync_mode_timeout, json=json_request)
    except requests.exceptions.RequestException as e:
        raise Exception(e)
    logger.info(f"post for test data end time is {time.strftime('%Y-%m-%d %H:%M:%S')}")
    
    if r.status_code != 200:
        raise ValueError(f"after {retries.total} retries, request data in synchronization mode "
                         f"still error, status: {r.status_code}")
    text = r.text
    rt = json.loads(text)
    ...
    ...
    ...
```

## 针对一些异步库（如 `aiohttp`）的版本
>> //notes：异步库好像没有简单的用已有参数的办法，于是自己写了个装饰器。注意：开始时漏掉了装饰器最里层的异步关键词，导致失败。

**参考链接**：
- 一日一技：装饰器如何装饰异步函数 https://cloud.tencent.com/developer/article/1586764
- 异步装饰器装饰协程(异步方法)坑记录 https://blog.csdn.net/qq_42586468/article/details/114363655

```py
# Add retries for asychronization http request functions.
# Default retry times are 3 and default retry time interval are 10s.
def retry_helper(retry_times=3, retry_interval=10):
    def decorator(func):
        @functools.wraps(func)
        # 注意最里层要加 async
        async def wrapper(*args, **kw):
            final_excep = None
            for i in range(retry_times+1):
                if i > 0:
                    time.sleep(retry_interval)
                    print(f"The {i}-th retry for function {func.__qualname__}")
                final_excep = None
                try:
                    # 类似的，被修饰的异步函数 func 前面要加上 await
                    rt = await func(*args, **kw)
                    return rt
                except Exception as e:
                    final_excep = e
                    pass
            if final_excep is not None:
                raise final_excep
        return wrapper
    return decorator

@retry_helper()
def yourself_async_http_func():
    ...
```
```sh
$ python3 test.py 
test start
The 1-th retry for function xClient.request_data()
The 2-th retry for function xClient.request_data()
The 3-th retry for function xClient.request_data()
Traceback (most recent call last):
  File "/Users/biaoxyz/test.py", line 304, in <module>
    test_get_test_data()
  File "/Users/biaoxyz/test.py", line 286, in test_get_test_data
    pdpc.load_to_csv('pdp', test_test_data_path, test_local_csv_path)
  File "/Users/biaoxyz/test.py", line 179, in load_to_csv
    withHeader, rowCount, data, url = asyncio.run(self.request_data(test_data_api_addr, data_path_dict))
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/asyncio/runners.py", line 43, in run
    return loop.run_until_complete(main)
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
    return future.result()
  File "/Users/biaoxyz/test.py", line 79, in wrapper
    raise final_excep
  File "/Users/biaoxyz/test.py", line 73, in wrapper
    rt = await func(*args, **kw)
  File "/Users/biaoxyz/test.py", line 139, in request_data
    async with aiohttp.request("POST",
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/site-packages/aiohttp/client.py", line 1186, in __aenter__
    self._resp = await self._coro
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/site-packages/aiohttp/client.py", line 559, in _request
    await resp.start(conn)
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/site-packages/aiohttp/client_reqrep.py", line 913, in start
    self._continue = None
  File "/Users/biaoxyz/opt/anaconda3/lib/python3.8/site-packages/aiohttp/helpers.py", line 721, in __exit__
    raise asyncio.TimeoutError from None
asyncio.exceptions.TimeoutError
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
