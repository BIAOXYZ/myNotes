
# 1

《Python开发 - Python库》pyarrow安装与使用（矩阵运算库） https://blog.csdn.net/bruceoxl/article/details/113076837 || https://blog.51cto.com/bruceou/4993647

## 个人实战

```py
import time
from pyarrow import csv
def load_by_arrow(filePath):
    # API :https://arrow.apache.org/docs/python/generated/pyarrow.csv.read_csv.html
    table = csv.read_csv(filePath)
    return table.to_pandas()

import pandas as pd
def load_by_pandas(filePath):
    df = pd.read_csv(filePath)
    return df

if __name__ == "__main__":
    filePath = 'workdf.csv'

    start = time.time()
    pa_df = load_by_arrow(filePath)
    end = time.time()
    print(end-start)

    start = time.time()
    pd_df = load_by_pandas(filePath)
    end = time.time()
    print(end-start)
```

```sh
# 本想生成 5 亿条数据，就执行了下面这行：
$ for ((i=1; i <= 500000000; i++)); do echo $i >> workdf.csv; done
# 但是后来没有耐心，手动 Ctrl + C 终止了。tail 看了一下，大约是 4 亿 5 千万条数据。
$ tail workdf.csv
451478538
451478539
451478540
451478541
451478542
451478543
451478544
451478545
451478546
451478547

# 然后执行了三次文中的程序，发现这个 pyarrow 确实有点东西，比 pandas 读 csv 的接口最少都要快四倍！
$ python3 pyarrow-pandas.py
11.538129806518555
48.19690990447998
$ python3 pyarrow-pandas.py
8.889472007751465
46.31164216995239
$ python3 pyarrow-pandas.py
9.3859224319458
54.53367304801941
```

Pandas vs. PyArrow file reading speed comparison https://github.com/tirthajyoti/Machine-Learning-with-Python/blob/master/Pandas%20and%20Numpy/Read_data_various_sources/Pandas%20CSV%20vs.%20PyArrow%20parquet%20reading%20speed.ipynb

Stop Using Pandas to Read/Write Data — This Alternative is 7 Times Faster https://towardsdatascience.com/stop-using-pandas-to-read-write-data-this-alternative-is-7-times-faster-893301633475

# 2

Pandas : Reading first n rows from parquet file? https://stackoverflow.com/questions/53982871/pandas-reading-first-n-rows-from-parquet-file
- https://stackoverflow.com/questions/53982871/pandas-reading-first-n-rows-from-parquet-file/69888274#69888274
  * > The accepted answer is out of date. It is now possible to read only the first few lines of a parquet file into pandas, though it is a bit messy and backend dependent.
  * > To read using PyArrow as the backend, follow below:
    ```py
    from pyarrow.parquet import ParquetFile
    import pyarrow as pa 

    pf = ParquetFile('file_name.pq') 
    first_ten_rows = next(pf.iter_batches(batch_size = 10)) 
    df = pa.Table.from_batches([first_ten_rows]).to_pandas() 
    ```
