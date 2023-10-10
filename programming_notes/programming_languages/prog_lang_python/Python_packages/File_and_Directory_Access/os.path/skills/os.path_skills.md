
## 如果文件存在，就追加写入（且不包含header），否则就创建并写入

How to add pandas data to an existing csv file? https://stackoverflow.com/questions/17530542/how-to-add-pandas-data-to-an-existing-csv-file
- https://stackoverflow.com/questions/17530542/how-to-add-pandas-data-to-an-existing-csv-file/17975690#17975690
  * > You can specify a python write mode in the pandas [to_csv](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.to_csv.html) function. For append it is `'a'`.
  * > In your case:
    ```py
    df.to_csv('my_csv.csv', mode='a', header=False)
    ```
  * > The default mode is `'w'`.
  * > 【[:star:][`*`]】 If the file initially might be missing, you can make sure the header is printed at the first write using this variation:
    ```py
    output_path='my_csv.csv'
    df.to_csv(output_path, mode='a', header=not os.path.exists(output_path))
    ```

## 以同名文件作为 csv 文件的名字，不需要在代码里复制路径之类的

```py
# 如果假定python程序文件为： /home/biaoxyz/tmptest/test.py
# 变量 same_name_csv 对应的 csv 文件为： /home/biaoxyz/tmptest/test.csv
# 变量 same_name_csv_dir 对应的目录为： /home/biaoxyz/tmptest
# 变量 data_csv 对应的 csv 文件为： /home/biaoxyz/tmptest/data.csv

same_name_csv = os.path.abspath(__file__)[:-3] + ".csv"
same_name_csv_dir = os.path.dirname(__file__)
data_csv = os.path.join(same_name_csv_dir, "data.csv")
```
