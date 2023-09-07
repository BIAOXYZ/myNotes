
# `.iloc[]`

pandas.DataFrame.iloc https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.iloc.html

Pandas `iloc[]` Usage with Examples https://sparkbyexamples.com/pandas/pandas-iloc-usage-with-examples/
- > **1 `pandas.DataFrame.iloc[]` Syntax & Usage**
  * > `DataFrame.iloc[]` is an **index-based to select rows and/or columns** in pandas. It accepts a single index, multiple indexes from the list, indexes by a range, and many more.
  * > One of the main advantages of DataFrame is its ease of use. You can see this yourself when you use `loc[]` or `iloc[]` attributes to select or filter DataFrame rows or columns. These are mostly used attributes in DataFrame.
  * > `df.iloc[START:STOP:STEP, START:STOP:STEP]` <br> ![](https://sparkbyexamples.com/wp-content/uploads/2021/09/pandas-different-between-loc-vs-iloc-2.png)
  * > Some point to note about `iloc[]`.
    + > By not providing a start index, `iloc[]` selects from the first row/column.
    + > By not providing stop, `iloc[]` selects all rows/columns from the start index.
    + > Providing both start and stop, selects all rows/columns in between.

# `.append()`

How do I combine two dataframes? https://stackoverflow.com/questions/12850345/how-do-i-combine-two-dataframes
- https://stackoverflow.com/questions/12850345/how-do-i-combine-two-dataframes/12850453#12850453
  * > Use `append`:
    ```py
    df_merged = df1.append(df2, ignore_index=True)
    ```
    > And to keep their indexes, set `ignore_index=False`.
- https://stackoverflow.com/questions/12850345/how-do-i-combine-two-dataframes/30557040#30557040
  * > Use `pd.concat` to join multiple dataframes:
    ```py
    df_merged = pd.concat([df1, df2], ignore_index=True, sort=False)
    ```
- https://stackoverflow.com/questions/12850345/how-do-i-combine-two-dataframes/39634150#39634150
  * > Merge across rows:
    ```py
    df_row_merged = pd.concat([df_a, df_b], ignore_index=True)
    ```
  * > Merge across columns:
    ```py
    df_col_merged = pd.concat([df_a, df_b], axis=1)
    ```

Pandas DataFrame concat vs append https://stackoverflow.com/questions/15819050/pandas-dataframe-concat-vs-append
- https://stackoverflow.com/questions/15819050/pandas-dataframe-concat-vs-append/51436106#51436106
  * > Pandas concat vs append vs join vs merge
    + > Concat gives the flexibility to join based on the axis(all rows or all columns)
    + > Append is the specific case(`axis=0, join='outer'`) of concat (being deprecated use concat)
    + > Join is based on the indexes (set by set_index) on how variable = `['left','right','inner','couter']`
    + > Merge is based on any particular column each of the two dataframes, this columns are variables on like `'left_on', 'right_on', 'on'`

# `.apply()`

pandas apply() 函数用法 https://www.jianshu.com/p/4fdd6eee1b06

# `.groupby()`

pandas GroupBy: Your Guide to Grouping Data in Python https://realpython.com/pandas-groupby/

Pandas教程 | 超好用的Groupby用法详解 - 易执的文章 - 知乎 https://zhuanlan.zhihu.com/p/101284491

pandas.MultiIndex.droplevel https://pandas.pydata.org/docs/reference/api/pandas.MultiIndex.droplevel.html

https://stackoverflow.com/questions/53414028/pandas-how-to-create-multiple-columns-in-groupby-with-conditional

https://stackoverflow.com/questions/43172970/python-pandas-groupby-aggregate-on-multiple-columns-then-pivot

# `.agg()`

pandas.DataFrame.aggregate https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.aggregate.html

如何使用agg函数对数据进行分组聚合 - 弦桐韵韵的文章 - 知乎 https://zhuanlan.zhihu.com/p/109820274

Pandas .agg() convert to list but skip nans https://stackoverflow.com/questions/70650545/pandas-agg-convert-to-list-but-skip-nans
- https://stackoverflow.com/questions/70650545/pandas-agg-convert-to-list-but-skip-nans/70650565#70650565

# `isin()`

pandas中isin()函数及其逆函数使用 https://blog.csdn.net/lzw2016/article/details/80472649

Pandas isin() function – A Complete Guide https://www.askpython.com/python-modules/pandas/pandas-isin
