
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
