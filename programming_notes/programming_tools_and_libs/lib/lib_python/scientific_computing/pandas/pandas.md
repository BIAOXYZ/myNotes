
# pandas语法

Pandas速查手册中文版 - 笑虎的文章 - 知乎 https://zhuanlan.zhihu.com/p/25630700
- > **数据选取**
  * > `df.iloc[0,0]`：返回第一列的第一个元素

【[:star:][`*`]】 Pandas中loc和iloc函数用法详解（源码+实例） https://blog.csdn.net/W_weiying/article/details/81411257

## 获取行数、列数

如何获取Dataframe的行数和列数 https://blog.csdn.net/lwgkzl/article/details/80988126
```console
返回列数：df.shape[1]
返回行数：df.shape[0] 或者：len(df)
```

## 添加行、列

小蛇学python（15）pandas之数据合并 https://www.jianshu.com/p/18a7b6bd15cb

Python Pandas 向DataFrame中添加一行/一列 https://www.jianshu.com/p/936ad27d9865
- > 在Pandas的DataFrame中添加一行或者一列，添加行有`df.loc[]`以及`df.append()`这两种方法，添加列有`df[]`和`df.insert()`两种方法，下面对这几种方法的使用进行简单介绍。

DataFrame 新增列的五种方法 https://blog.csdn.net/qq_35318838/article/details/102720553

### 个人实战1

```py
import pandas as pd
from pandas import DataFrame
import csv
 
data1 = pd.read_csv("./left.csv")
data2 = pd.read_csv("./right.csv")
print(type(data1))
print(data1)
print(data2)
print("length of data2 is: ", len(data2))

print("****************************************************************************************************\n")

length = data1.shape[1]
incr = 1
for col in data2.columns:
    incr += 1
    print(type(col), data2[col])
    data1[str(length+incr)] = data2[col]

print("****************************************************************************************************\n")

print(data1)

print("****************************************************************************************************\n")

# 这个megerd办法不太不符合要求
# frames = [data1, data2]
# merged = pd.concat(frames)
# print(merged)

data1.to_csv("./merged.csv", index=0)


"""
# 自己随便编了个 left.csv 和 right.csv

# left.csv
1, 2, 3
0.1, 0.2, 0.3
0.11, 0.22, 0.33
0.111, 0.222, 0.333
0.1111, 0.2222, 0.3333

# right.csv
1, 2
0.4, 0.5
0.44, 0.55
0.444, 0.555
0.4444, 0.5555
"""
```

## 读取数据时，没有列名或者分隔符是不规则的空格；存储时拆分数据等

How to make separator in pandas read_csv more flexible wrt whitespace, for irregular separators? https://stackoverflow.com/questions/15026698/how-to-make-separator-in-pandas-read-csv-more-flexible-wrt-whitespace-for-irreg || 对于不规则的分隔符，如何使pandas read_csv中的分隔符更灵活wrt空格？ https://qastack.cn/programming/15026698/how-to-make-separator-in-pandas-read-csv-more-flexible-wrt-whitespace-for-irreg
- > From the documentation, you can use either a regex or `delim_whitespace`:
- > `pd.read_csv("whitespace.csv", header=None, delim_whitespace=True)`

pandas系列 read_csv 与 to_csv 方法各参数详解（全，中文版） https://blog.csdn.net/u010801439/article/details/80033341

python读取csv文件并添加索引 https://www.cnblogs.com/btc1996/p/11006318.html

Pandas在读取csv时如何设置列名--常用方法集锦 - CC思SS的文章 - 知乎 https://zhuanlan.zhihu.com/p/44503744

### 个人实战

```py
import pandas as pd
from pandas import DataFrame
import csv
 
# 对于没有列名的数据读入时，设置 header 为None
data1 = pd.read_csv("./left2.csv", header=None)
data2 = pd.read_csv("./right2.csv", header=None)
print(data1)
print(data2)

# 这个是不对的，自动插入的列名应该用数字，也就是 0 而不是 "0"。
# print(data2["0"])  
print(data2[0])

# 在第0个位置（也就是最左边），插入列名为 -1，内容为 data2[0] 的一列。
data1.insert(0, -1, data2[0])
print(data1)

# 这样写入保证只保留数据，没有行号和列名
data1.to_csv("./merge-no-split.csv", header=0, index=0)

length = data1.shape[1]
split_position = 2

data1.to_csv("./merge-and-split1.csv", header=0, index=0, columns=range(-1, split_position))
data1.to_csv("./merge-and-split2.csv", header=0, index=0, columns=range(split_position, length-1))


"""
# 自己随便编了个 left2.csv 和 right2.csv，主要特点是去掉了 left.csv 和 right.csv 本身就有的列名。

# left2.csv
0.1, 0.2, 0.3
0.11, 0.22, 0.33
0.111, 0.222, 0.333
0.1111, 0.2222, 0.3333

# right2.csv
0.4, 0.5
0.44, 0.55
0.444, 0.555
0.4444, 0.5555
"""
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 遍历

第17篇：Pandas-遍历DataFrame对象 - 铁甲万能狗的文章 - 知乎 https://zhuanlan.zhihu.com/p/339744795
- > 按行遍历 <br> 通过for迭代df.iterrows接口，idx是输出DataFrame内部的索引值,data输出每行单元格的值
  ```py
  for idx,data in df.iterrows():
      print("[{}]: {}".format(idx,data))
  ```

### 个人实战（通过遍历每一行，统计第一列的0和1的个数，根据和0.5的关系来做判断）
```py
import pandas as pd
import csv
 
data = pd.read_csv("./xxx.csv")
print("The (0,0) item is: ", data.iloc[0,0])
print("The row number is: ", data.shape[0])
print("The column number is: %d" % (data.shape[1]))

n_one = 0
n_zero = 0
for rowInd, row in data.iterrows():
    if row[0] < 0.5:
        n_zero += 1
    else:
        n_one += 1
print (n_zero, n_one)
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 打印时不打印行号/index

How to print pandas DataFrame without index https://stackoverflow.com/questions/24644656/how-to-print-pandas-dataframe-without-index
- https://stackoverflow.com/questions/24644656/how-to-print-pandas-dataframe-without-index/32662331#32662331
  * > `print(df.to_string(index=False))`

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Dataframe

Pandas Tutorial: DataFrames in Python https://www.datacamp.com/community/tutorials/pandas-tutorial-dataframe-python

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Series

Pandas DataFrame: How to print single row horizontally? https://stackoverflow.com/questions/40622796/pandas-dataframe-how-to-print-single-row-horizontally
- https://stackoverflow.com/questions/40622796/pandas-dataframe-how-to-print-single-row-horizontally/40625100#40625100
  * > use the `to_frame` method then transpose with `T`
    ```py
    df = pd.DataFrame([[100,200,300],[400,500,600]])
    for index, row in df.iterrows():
        print(row.to_frame().T)

         0    1    2
    0  100  200  300
         0    1    2
    1  400  500  600
    ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 下标和索引

Pandas中loc和iloc函数用法详解（源码+实例） https://blog.csdn.net/W_weiying/article/details/81411257 || https://www.cnblogs.com/Summer-skr--blog/p/13707213.html
- > `loc`函数：通过行索引 "Index" 中的具体值来取行数据（如取"Index"为"A"的行）
- > `iloc`函数：通过行号来取行数据（如取第二行的数据）

Pandas中at、iat函数详解 https://blog.csdn.net/W_weiying/article/details/84787423

How are iloc, ix and loc different? https://stackoverflow.com/questions/31593201/how-are-iloc-ix-and-loc-different

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## csv相关

Python pandas read CSV into DataFrame https://pynative.com/python-pandas-read-csv/

史上最全！用Pandas读取CSV，看这篇就够了 https://mp.weixin.qq.com/s/ANAjNm-sRvXupX1XOxLYFw

使用 Python 读写 CSV 文件（三） - Helperhaps的文章 - 知乎 https://zhuanlan.zhihu.com/p/40946024
- Pandas 的 Cheat Sheet（中文版） - Helperhaps的文章 - 知乎 https://zhuanlan.zhihu.com/p/39845663

【[:star:][`*`]】 pandas的to_csv()使用方法 https://blog.csdn.net/toshibahuai/article/details/79034829 || https://segmentfault.com/a/1190000015326653
- > 1.首先查询当前的工作路径：
  ```py
  import os  
  os.getcwd() #获取当前工作路径  
  ```
- > 2.方法：
  ```py
  to_csv()是DataFrame类的方法，read_csv()是pandas的方法
  ```
- > 是否保留列名 header: Whether to write out the column names (default True)
  ```py
  dt.to_csv('C:/Users/think/Desktop/Result.csv',header=0) #不保存列名
  ```
- > 是否保留行索引 index: whether to write row (index) names (default True)
  ```py
  dt.to_csv('C:/Users/think/Desktop/Result1.csv',index=0) #不保存行索引
  
  # 注：index=0 也可以换成 index=None
  ```

Pandas read in table without headers https://stackoverflow.com/questions/29287224/pandas-read-in-table-without-headers
- https://stackoverflow.com/questions/29287224/pandas-read-in-table-without-headers/29287549#29287549
  * > In order to read a csv in that doesn't have a header and for only certain columns you need to pass params `header=None` and `usecols=[3,6]` for the `4th` and `7th` columns:
    ```py
    df = pd.read_csv(file_path, header=None, usecols=[3,6])
    ```
    > See the docs: https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html

Pandas 基础 (4) - 读 / 写 Excel 和 CSV 文件 https://learnku.com/articles/25093

python-csv文件删除行或者删除列 https://blog.csdn.net/weixin_40446557/article/details/103372497
- > 1. `data.drop([1,2,3,4])`  #删除1,2,3,4行的整行数据
- > 2. `data.drop(["列名"]，axis=1)`  or  `data.drop(columns=["列名"])`
```py
import pandas as pd
import csv

data = pd.read_csv("./betting.csv")
data_new=data.drop([128,129,130]) #删除128，129，130行数据
data_new=data.drop(["title"]，axis=1) #删除title这列数据

#、、、、对于data进行多次操作，如果想要连续操作，记得都将.号之前的主语改成同一pandas对象，
#比如前来两个操作，第二个主语需要改成data_new对象。如果想要保存新的csv文件，则为：
data_new.to_csv("./betting_new.csv",index=0)
```
