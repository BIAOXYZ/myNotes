
# 1

How do I use line_profiler (from Robert Kern)? https://stackoverflow.com/questions/23885147/how-do-i-use-line-profiler-from-robert-kern
- https://stackoverflow.com/questions/23885147/how-do-i-use-line-profiler-from-robert-kern/23888912#23888912

## 个人实战

**用法1**：
```sh
# 安装 line_profiler
pip install line_profiler

# 给每个函数加上 @profile 装饰器，并且代码文件里都不需要 import line_profiler 或者 from line_profiler import LineProfiler
vim test_line_profiler.py

# 上面只是加上装饰器后，直接用 kernprof -l -v 运行即可。此时程序运行结束后会打印逐行的时间，并且会生成 xxx.py.lprof 文件
## 注意：不需要在代码里做任何 import，因为 kernprof 会动态修改运行程序的 __builtins__ 命名空间：
## `kernprof will create an instance of LineProfiler and insert it into the __builtins__ namespace with the name profile.`
kernprof -l -v test_line_profiler.py

# 后续也可以使用如下方式，通过生成的性能分析文件 xxx.py.lprof，来看运行的时间
python3 -m line_profiler test_line_profiler.py.lprof
```

**用法2**：
```sh
# 如果安装了一些可视化工具，比如 snakeviz 之类的包
# SnakeViz https://jiffyclub.github.io/snakeviz/
pip install snakeviz

# 则可以不加参数使用 kernprof，此时会生成另外一种后缀的性能分析文件： xxx.py.prof
kernprof test_line_profiler.py

# 可以使用可视化工具展示
snakeviz test_line_profiler.py.lprof
```

### 用法1实战

**`test_line_profiler.py`**:
```py
import pandas as pd 
import numpy as np 
import os
import datetime

same_name_csv = os.path.abspath(__file__)[:-3] + ".csv"
same_name_csv_dir = os.path.dirname(__file__)

def parapre_data():
    try:
        os.remove(same_name_csv)
    except:
        pass
    np.random.seed = 2023
    df_size = 10000 * 1000
    df = pd.DataFrame({
        # 'a': np.random.randint(1000, size=df_size), 
        'row': range(1, df_size+1), 
        'b': np.random.randint(1000, size=df_size), 
        'c': np.random.randint(1000, size=df_size), 
        'd': np.random.randint(1000, size=df_size), 
        'e': np.random.randint(1000, size=df_size)
    }) 
    df.head()
    print(df)
    start = datetime.datetime.now()
    df.to_csv(same_name_csv, index = False)
    end = datetime.datetime.now()
    print(f"We totally prepare [{df_size}] rows of data!")
    print(f"Total time for parapre_data() is {end-start}\n\n")

if __name__ == '__main__':
    parapre_data()
```
```sh
$ python3 test_line_profiler.py
              row    b    c    d    e
0               1  302  193  252  899
1               2  894  560  971  707
2               3  164  782  593  783
3               4  681  164  299  598
4               5  375  345  375  500
...           ...  ...  ...  ...  ...
9999995   9999996  533  485  704  387
9999996   9999997  358  709  711  700
9999997   9999998  550  508   93  129
9999998   9999999  236  834  760   73
9999999  10000000  386  842  538  200

[10000000 rows x 5 columns]
We totally prepare [10000000] rows of data!
Total time for parapre_data() is 0:00:17.677453
```

**修改后的 `test_line_profiler.py`**:
```py
import pandas as pd 
import numpy as np 
import os
import datetime

same_name_csv = os.path.abspath(__file__)[:-3] + ".csv"
same_name_csv_dir = os.path.dirname(__file__)

@profile
def parapre_data():
    try:
        os.remove(same_name_csv)
    except:
        pass
    np.random.seed = 2023
    df_size = 10000 * 1000
    df = pd.DataFrame({
        # 'a': np.random.randint(1000, size=df_size), 
        'row': range(1, df_size+1), 
        'b': np.random.randint(1000, size=df_size), 
        'c': np.random.randint(1000, size=df_size), 
        'd': np.random.randint(1000, size=df_size), 
        'e': np.random.randint(1000, size=df_size)
    }) 
    df.head()
    print(df)
    start = datetime.datetime.now()
    df.to_csv(same_name_csv, index = False)
    end = datetime.datetime.now()
    print(f"We totally prepare [{df_size}] rows of data!")
    print(f"Total time for parapre_data() is {end-start}\n\n")

if __name__ == '__main__':
    parapre_data()
```
```sh
# 后面的都是 line_profiler 打印的东西。
$ kernprof -l -v test_line_profiler.py 
              row    b    c    d    e
0               1   31  682   84  118
1               2  698  935  890  937
2               3  823  309  803  862
3               4  887  512  489    6
4               5  135  460  985  143
...           ...  ...  ...  ...  ...
9999995   9999996  404  674  282  858
9999996   9999997  314   11  382  433
9999997   9999998  347  519  244  781
9999998   9999999   53  923  532  537
9999999  10000000  512  674  414  718

[10000000 rows x 5 columns]
We totally prepare [10000000] rows of data!
Total time for parapre_data() is 0:00:18.552234


Wrote profile results to test_line_profiler.py.lprof
Timer unit: 1e-06 s

Total time: 19.7926 s
File: test_line_profiler.py
Function: parapre_data at line 9

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     9                                           @profile
    10                                           def parapre_data():
    11         1          0.8      0.8      0.0      try:
    12         1      36188.5  36188.5      0.2          os.remove(same_name_csv)
    13                                               except:
    14                                                   pass
    15         1          7.8      7.8      0.0      np.random.seed = 2023
    16         1          1.8      1.8      0.0      df_size = 10000 * 1000
    17         1          2.4      2.4      0.0      df = pd.DataFrame({
    18                                                   # 'a': np.random.randint(1000, size=df_size), 
    19         1          9.9      9.9      0.0          'row': range(1, df_size+1), 
    20         1     122927.5 122927.5      0.6          'b': np.random.randint(1000, size=df_size), 
    21         1     126711.1 126711.1      0.6          'c': np.random.randint(1000, size=df_size), 
    22         1     123163.5 123163.5      0.6          'd': np.random.randint(1000, size=df_size), 
    23         1     799896.5 799896.5      4.0          'e': np.random.randint(1000, size=df_size)
    24                                               }) 
    25         1        690.6    690.6      0.0      df.head()
    26         1      30584.6  30584.6      0.2      print(df)
    27         1         64.2     64.2      0.0      start = datetime.datetime.now()
    28         1   18552165.4    2e+07     93.7      df.to_csv(same_name_csv, index = False)
    29         1         36.8     36.8      0.0      end = datetime.datetime.now()
    30         1         57.4     57.4      0.0      print(f"We totally prepare [{df_size}] rows of data!")
    31         1         58.0     58.0      0.0      print(f"Total time for parapre_data() is {end-start}\n\n")

$ 

$ python3 -m line_profiler test_line_profiler.py.lprof 
Timer unit: 1e-06 s

Total time: 19.7926 s
File: test_line_profiler.py
Function: parapre_data at line 9

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     9                                           @profile
    10                                           def parapre_data():
    11         1          0.8      0.8      0.0      try:
    12         1      36188.5  36188.5      0.2          os.remove(same_name_csv)
    13                                               except:
    14                                                   pass
    15         1          7.8      7.8      0.0      np.random.seed = 2023
    16         1          1.8      1.8      0.0      df_size = 10000 * 1000
    17         1          2.4      2.4      0.0      df = pd.DataFrame({
    18                                                   # 'a': np.random.randint(1000, size=df_size), 
    19         1          9.9      9.9      0.0          'row': range(1, df_size+1), 
    20         1     122927.5 122927.5      0.6          'b': np.random.randint(1000, size=df_size), 
    21         1     126711.1 126711.1      0.6          'c': np.random.randint(1000, size=df_size), 
    22         1     123163.5 123163.5      0.6          'd': np.random.randint(1000, size=df_size), 
    23         1     799896.5 799896.5      4.0          'e': np.random.randint(1000, size=df_size)
    24                                               }) 
    25         1        690.6    690.6      0.0      df.head()
    26         1      30584.6  30584.6      0.2      print(df)
    27         1         64.2     64.2      0.0      start = datetime.datetime.now()
    28         1   18552165.4    2e+07     93.7      df.to_csv(same_name_csv, index = False)
    29         1         36.8     36.8      0.0      end = datetime.datetime.now()
    30         1         57.4     57.4      0.0      print(f"We totally prepare [{df_size}] rows of data!")
    31         1         58.0     58.0      0.0      print(f"Total time for parapre_data() is {end-start}\n\n")

$ 
```
