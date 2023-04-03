
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
