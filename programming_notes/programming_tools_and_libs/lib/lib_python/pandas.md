
# pandas官方

Pandas https://github.com/pandas-dev/pandas || https://pandas.pydata.org/

## 官方文档

User Guide https://pandas.pydata.org/pandas-docs/stable/user_guide/index.html
- Indexing and selecting data https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html
- Merge, join, and concatenate https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html

# pandas源码

Pandas Cookbook 带注释源码 https://github.com/apachecn/pandas-cookbook-code-notes

# pandas系列教程

# pandas语法

## Dataframe

Pandas Tutorial: DataFrames in Python https://www.datacamp.com/community/tutorials/pandas-tutorial-dataframe-python

## Series

## 下标和索引

How are iloc, ix and loc different? https://stackoverflow.com/questions/31593201/how-are-iloc-ix-and-loc-different

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
