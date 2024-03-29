
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

The fastest way to read a CSV in Pandas https://pythonspeed.com/articles/pandas-read-csv-fast/
- > **Reading a CSV, the default way**
  * > I happened to have a 850MB CSV lying around with the local transit authority’s bus delay data, as one does. Here’s the default way of loading it with Pandas:
    ```py
    import pandas as pd
    df = pd.read_csv("large.csv")
    ```
  * > Here’s how long it takes, by running our program using the time utility:
    ```console
    $ time python default.py 

    real    0m13.245s
    user    0m11.808s
    sys     0m1.378s
    ```
- > **Reading a CSV with PyArrow**
  * > In Pandas `1.4`, released in January 2022, there is a new backend for CSV reading, relying on the Arrow library’s CSV parser. It’s still marked as experimental, and it doesn’t support all the features of the default parser—but it is faster. Here’s how we use it:
    ```py
    import pandas as pd
    df = pd.read_csv("large.csv", engine="pyarrow")
    ```
  * > And when we run it:
    ```console
    $ time python arrow.py 

    real    0m2.707s
    user    0m4.945s
    sys     0m1.527s
    ```
  * > Now, parallelism may or may not be a benefit, depending on how you ran your code. If you previously only ran it on a single core, that’s a free performance improvement. But if you were already manually utilizing multiple cores, for example by loading multiple CSV files in parallel, adding parallelism here won’t speed things up, and [potentially could slow things down a little](https://pythonspeed.com/articles/parallelism-slower/).
  * > However, given that the PyArrow backend is also inherently faster, seeing as the total CPU time was cut in half, it’s likely to provide meaningful speedups even if you already had parallelism.
- > **Rethinking the problem**
  * > **Instead of reading in a CSV, you could read in some other file format that is faster to process**. Let’s see an example, using the Parquet data format. Parquet files are designed to be read quickly: you don’t have to do as much parsing as you would with CSV. And unlike CSV, where the column type is not encoded in the file, in Parquet the columns have types stored in the actual file.
  * > First, we’ll convert the CSV file to a Parquet file; we disable compression so we’re doing a more apples-to-apples comparison with the CSV. Of course, if you’re the one generating the file in the first place, you don’t need a conversion step, you can just write your data straight to Parquet.
- > **The best CSV is no CSV**

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

【未实战】 Pyarrow iter_batches as python native iterable https://gist.github.com/grantmwilliams/143fd60b3891959a733d0ce5e195f71d
```py
import s3fs
import pyarrow as pa
import pyarrow.parquet as pq

from itertools import chain
from typing import Tuple, Any

def iter_parquet(s3_uri: str, columns = None, batch_size=1_000) -> Tuple[Any]:

    # create file system for file interface objects from S3
    fs = s3fs.S3FileSystem()

    # open a file interface object
    with fs.open(s3_uri) as fp:

        # convert the python file object into a ParquetFile object for iterating
        parquet_file = pq.ParquetFile(fp)

        # an iterator of pyarrow.RecordBatch
        record_batches = parquet_file.iter_batches(batch_size=batch_size, columns=columns)

        # convert from columnar format of pyarrow arrays to a row format of python objects (yields tuples)
        yield from chain.from_iterable(zip(*map(lambda col: col.to_pylist(), batch.columns)) for batch in record_batches)
```
