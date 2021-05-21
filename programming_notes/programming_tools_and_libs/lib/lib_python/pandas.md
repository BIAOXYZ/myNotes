
# pandas官方

Pandas https://github.com/pandas-dev/pandas || https://pandas.pydata.org/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 官方文档

User Guide https://pandas.pydata.org/pandas-docs/stable/user_guide/index.html
- Indexing and selecting data https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html
- Merge, join, and concatenate https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pandas源码

Pandas Cookbook 带注释源码 https://github.com/apachecn/pandas-cookbook-code-notes

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pandas系列教程

Pandas中文教程 https://github.com/datawhalechina/joyful-pandas

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pandas语法

## 获取行、列

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
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Dataframe

Pandas Tutorial: DataFrames in Python https://www.datacamp.com/community/tutorials/pandas-tutorial-dataframe-python

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Series

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 下标和索引

How are iloc, ix and loc different? https://stackoverflow.com/questions/31593201/how-are-iloc-ix-and-loc-different

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## csv相关

使用 Python 读写 CSV 文件（三） - Helperhaps的文章 - 知乎 https://zhuanlan.zhihu.com/p/40946024
- Pandas 的 Cheat Sheet（中文版） - Helperhaps的文章 - 知乎 https://zhuanlan.zhihu.com/p/39845663

pandas的to_csv()使用方法 https://segmentfault.com/a/1190000015326653
- > 1.首先查询当前的工作路径：
  ```py
  import os  
  os.getcwd() #获取当前工作路径  
  ```
- > 2.方法：
  ```py
  to_csv()是DataFrame类的方法，read_csv()是pandas的方法
  ```
- > 是否保留行索引 index: whether to write row (index) names (default True)
  ```py
  dt.to_csv('C:/Users/think/Desktop/Result1.csv',index=0) #不保存行索引
  
  # 注：index=0 也可以换成 index=None
  ```

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
