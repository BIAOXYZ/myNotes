
# 读的过程中过滤（且希望最好能用类似迭代器的方式，而不是一下子就全加载到内存里）

How can I filter lines on load in Pandas read_csv function? https://stackoverflow.com/questions/13651117/how-can-i-filter-lines-on-load-in-pandas-read-csv-function
- https://stackoverflow.com/questions/13651117/how-can-i-filter-lines-on-load-in-pandas-read-csv-function/13653490#13653490
  * > There isn't an option to ***filter the rows before the CSV file is loaded into a pandas object***.
  * > You can either load the file and then filter using `df[df['field'] > constant]`, or if you have a very large file and you are worried about memory running out, then use an iterator and apply the filter as you concatenate chunks of your file e.g.:
    ```py
    import pandas as pd
    iter_csv = pd.read_csv('file.csv', iterator=True, chunksize=1000)
    df = pd.concat([chunk[chunk['field'] > constant] for chunk in iter_csv])
    ```
  * > You can vary the `chunksize`` to suit your available memory. See [here](http://pandas.pydata.org/pandas-docs/stable/io.html#iterating-through-files-chunk-by-chunk) for more details.

## 个人实战
