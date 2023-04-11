
# 1

How to scale Python multiprocessing to a cluster with one line of code https://medium.com/distributed-computing-with-ray/how-to-scale-python-multiprocessing-to-a-cluster-with-one-line-of-code-d19f242f60ff
- > **Step 1: Serial Python**
  ```py
  import math
  import random
  import time

  def sample(num_samples):
      num_inside = 0
      for _ in range(num_samples):
          x, y = random.uniform(-1, 1), random.uniform(-1, 1)
          if math.hypot(x, y) <= 1:
              num_inside += 1
      return num_inside

  def approximate_pi(num_samples):
      start = time.time()
      num_inside = sample(num_samples)
      
      print("pi ~= {}".format((4*num_inside)/num_samples))
      print("Finished in: {:.2f}s".format(time.time()-start))
  ```
- > **Step 2: Parallel on one machine using multiprocessing.Pool**
  ```py
  import math
  import random
  import time

  def sample(num_samples):
      num_inside = 0
      for _ in range(num_samples):
          x, y = random.uniform(-1, 1), random.uniform(-1, 1)
          if math.hypot(x, y) <= 1:
              num_inside += 1
      return num_inside

  def approximate_pi_parallel(num_samples):
      from multiprocessing.pool import Pool
      pool = Pool()
      
      start = time.time()
      num_inside = 0
      sample_batch_size = 100000
      for result in pool.map(sample, [sample_batch_size for _ in range(num_samples//sample_batch_size)]):
          num_inside += result
          
      print("pi ~= {}".format((4*num_inside)/num_samples))
      print("Finished in: {:.2f}s".format(time.time()-start))
  ```
- > **Step 3: Distributed on a 10-node cluster using Ray**
  ```py
  import math
  import random
  import time

  def sample(num_samples):
      num_inside = 0
      for _ in range(num_samples):
          x, y = random.uniform(-1, 1), random.uniform(-1, 1)
          if math.hypot(x, y) <= 1:
              num_inside += 1
      return num_inside

  def approximate_pi_distributed(num_samples):
      from ray.util.multiprocessing.pool import Pool # NOTE: Only the import statement is changed.
      pool = Pool()
          
      start = time.time()
      num_inside = 0
      sample_batch_size = 100000
      for result in pool.map(sample, [sample_batch_size for _ in range(num_samples//sample_batch_size)]):
          num_inside += result
          
      print("pi ~= {}".format((4*num_inside)/num_samples))
      print("Finished in: {:.2f}s".format(time.time()-start))
  ```

## 个人实战

***`approximate_pi.py`***
```py
import math
import random
import time

def sample(num_samples):
    num_inside = 0
    for _ in range(num_samples):
        x, y = random.uniform(-1, 1), random.uniform(-1, 1)
        if math.hypot(x, y) <= 1:
            num_inside += 1
    return num_inside

def approximate_pi(num_samples):
    start = time.time()
    num_inside = sample(num_samples)
    
    print("pi ~= {}".format((4*num_inside)/num_samples))
    print("Finished in: {:.2f}s".format(time.time()-start))

n = 10000 * 1000
approximate_pi(n)
```

***`approximate_pi_parallel.py`***
```py
import math
import random
import time

def sample(num_samples):
    num_inside = 0
    for _ in range(num_samples):
        x, y = random.uniform(-1, 1), random.uniform(-1, 1)
        if math.hypot(x, y) <= 1:
            num_inside += 1
    return num_inside

def approximate_pi_parallel(num_samples):
    from multiprocessing.pool import Pool
    pool = Pool()
    
    start = time.time()
    num_inside = 0
    sample_batch_size = 100000
    for result in pool.map(sample, [sample_batch_size for _ in range(num_samples//sample_batch_size)]):
        num_inside += result
        
    print("pi ~= {}".format((4*num_inside)/num_samples))
    print("Finished in: {:.2f}s".format(time.time()-start))

n = 10000 * 1000
approximate_pi_parallel(n)
```

```sh
$ python3 approximate_pi.py 
pi ~= 3.1417872
Finished in: 6.47s
$ python3 approximate_pi_parallel.py 
pi ~= 3.1407948
Finished in: 0.36s
$ 
$ python3 approximate_pi.py 
pi ~= 3.1415004
Finished in: 6.69s
$ python3 approximate_pi_parallel.py 
pi ~= 3.14152
Finished in: 0.35s
$ 
$ python3 approximate_pi.py 
pi ~= 3.1414748
Finished in: 6.62s
$ python3 approximate_pi_parallel.py 
pi ~= 3.1411876
Finished in: 0.34s
```

# 2

python分布式多进程框架 Ray https://blog.csdn.net/luanpeng825485697/article/details/88242020
- > **有效的使用聚合函数**
- > **三、核心操作**
  * > **2. `ray.put()`**
    + > 使用 `ray.put()` 可以将Python对象存入本地 ObjectStore，并且异步返回一个唯一的 `ObjectID`。通过该ID，Ray可以访问集群中任一个节点上的对象（远程对象通过查阅Master的对象表获得）。
    + > ***对象一旦存入 ObjectStore 便不可更改***，Ray的 `remote` 函数可以将直接将该对象的ID作为参数传入。***使用 ObjectID 作为 `remote` 函数参数，可以有效地减少函数参数的写 ObjectStore 的次数***。 
  * > **3. `ray.get()`**
    + > 使用 `ray.get()` 可以通过ObjectID获取ObjectStore内的对象并将之转换为Python对象。***对于数组类型的对象，Ray使用共享内存机制减少数据的拷贝成本***。而对于其它对象则需要将数据从ObjectStore拷贝到进程的堆内存中。
    + > 如果调用ray.get()操作时，对象尚未创建好，则get操作会阻塞，直到对象创建完成后返回。get操作的关键流程如下：
      ```console
      1. Driver或者Worker进程首先到ObjectStore内请求ObjectID对应的对象数据。
      2. 如果本地ObjectStore没有对应的对象数据，本地对象管理器Plasma会检查Master上的对象表查看对象是否存储其它节点的ObjectStore。
      3. 如果对象数据在其它节点的ObjectStore内，Plasma会发送网络请求将对象数据拉到本地ObjectStore。
      4. 如果对象数据还没有创建好，Master会在对象创建完成后通知请求的Plasma读取。
      5. 如果对象数据已经被所有的ObjectStore移除（被LRU策略删除），本地调度器会根据任务血缘关系执行对象的重新创建工作。
      6. 一旦对象数据在本地ObjectStore可用，Driver或者Worker进程会通过共享内存的方式直接将对象内存区域映射到自己的进程地址空间中，并反序列化为Python对象。
      ```
    + > 另外，`ray.get()` 可以一次性读取多个对象的数据：
      ```py
      result_ids = [ray.put(i) for i in range(10)]
      ray.get(result_ids)  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      ```
  * > **4. `@ray.remote`**
    + > Ray中使用注解 `@ray.remote` 可以声明一个remote function。remote函数时Ray的基本任务调度单元，***remote函数定义后会立即被序列化存储到RedisServer中，并且分配了一个唯一的ID，这样就保证了集群的所有节点都可以看到这个函数的定义***。
    + > 不过，这样对remote函数定义有了一个潜在的要求，即remote函数内如果调用了其它的用户函数，则必须提前定义，否则remote函数无法找到对应的函数定义内容。
    + > remote函数内也可以调用其它的remote函数，Driver和Slave每次调用remote函数时，其实都是向集群提交了一个计算任务，从这里也可以看到Ray的分布式计算的自由性。
    + > Ray中调用remote函数的关键流程如下：
      ```console
      1. 调用remote函数时，首先会创建一个任务对象，它包含了函数的ID、参数的ID或者值（Python的基本对象直接传值，复杂对象会先通过ray.put()操作存入ObjectStore然后返回ObjectID）、函数返回值对象的ID。
      2. 任务对象被发送到本地调度器。
      3. 本地调度器决定任务对象是在本地调度还是发送给全局调度器。如果任务对象的依赖（参数）在本地的ObejctStore已经存在且本地的CPU和GPU计算资源充足，那么本地调度器将任务分配给本地的WorkerProcess执行。否则，任务对象被发送给全局调度器并存储到任务表（TaskTable）中，全局调度器根据当前的任务状态信息决定将任务发给集群中的某一个本地调度器。
      4. 本地调度器收到任务对象后（来自本地的任务或者全局调度分配的任务），会将其放入一个任务队列中，等待计算资源和本地依赖满足后分配给WorkerProcess执行。
      5. Worker收到任务对象后执行该任务，并将函数返回值存入ObjectStore，并更新Master的对象表（ObjectTable）信息。
      ```
    + > `@ray.remote` 注解有一个参数 `num_return_vals` 用于声明remote函数的返回值个数，基于此实现remote函数的多返回值机制。
      ```py
      @ray.remote(num_return_vals=2)
      def f():
          return 1, 2

      x_id, y_id = f.remote()
      ray.get(x_id)  # 1
      ray.get(y_id)  # 2
      ```
    + > `@ray.remote` 注解的另一个参数 `num_gpus` 可以为任务指定GPU的资源。使用内置函数 `ray.get_gpu_ids()` 可以获取当前任务可以使用的GPU信息。
  * > **5. `ray.wait()`**
    + > `ray.wait()` 操作支持批量的任务等待，基于此可以实现一次性获取多个ObjectID对应的数据。
      ```py
      # 启动5个remote函数调用任务
      results = [f.remote(i) for i in range(5)]
      # 阻塞等待4个任务完成，超时时间为2.5s
      ready_ids, remaining_ids = ray.wait(results, num_returns=4, timeout=2500)
      ```
    + > 上述例子中，results包含了5个ObjectID，***使用 `ray.wait` 操作可以一直等待有4个任务完成后返回，并将完成的数据对象放在第一个list类型返回值内，未完成的ObjectID放在第二个list返回值内***。如果设置了超时时间，那么在超时时间结束后仍未等到预期的返回值个数，则已超时完成时的返回值为准。
  * > **6. `ray.error_info()`**
  * > **7. Actor**
    + > Ray的remote函数只能处理无状态的计算需求，***有状态的计算需求需要使用Ray的Actor实现***。在Python的class定义前使用 `@ray.remote` 可以声明Actor。
      ```py
      @ray.remote
      class Counter(object):
          def __init__(self):
              self.value = 0

          def increment(self):
              self.value += 1
              return self.value
      ```
    + > 使用如下方式创建Actor对象。
      ```py
      a1 = Counter.remote()
      a2 = Counter.remote()
      ```
    + > Ray创建Actor的流程为：
      ```console
      1. Master选取一个Slave，并将Actor创建任务分发给它的本地调度器。
      2. 创建Actor对象，并执行它的构造函数。
      ```
      > ***从流程可以看出，Actor对象的创建是并行的***。
    + > 通过调用Actor对象的方法使用Actor。
      ```py
      a1.increment.remote()  # ray.get returns 1
      a2.increment.remote()  # ray.get returns 1
      ```
    + > 调用Actor对象的方法的流程为：
      ```console
      1. 首先创建一个任务。
      2. 该任务被Driver直接分配到创建该Actor对应的本地执行器执行，这个操作绕开了全局调度器（Worker是否也可以使用Actor直接分配任务尚存疑问）。
      3. 返回Actor方法调用结果的ObjectID。
      ```
      > ***为了保证Actor状态的一致性，对同一个Actor的方法调用是串行执行的***。
- > **参考资料**
  * > Ray论文：Real-Time Machine Learning: The Missing Pieces
  * > Ray开发手册：http://ray.readthedocs.io/en/latest/index.html
  * > Ray源代码：https://github.com/ray-project/ray
