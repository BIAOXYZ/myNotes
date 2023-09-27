
# 打印 dataframe 列的类型

**打印一列的类型：**
```py
import pandas as pd
import numpy as np

# 创建示例数据
df = pd.DataFrame({'a': [1, '1', 2.0, '2.0', '3.14', np.nan]})

# 定义一个函数，对每个元素进行类型判断，并返回相应的标识符
def get_value_type(value):
    if isinstance(value, (int, np.integer)):
        return 'int'
    elif isinstance(value, (float, np.floating)):
        return 'float'
    elif isinstance(value, str):
        return 'str'
    elif pd.isna(value):
        return 'nan'
    else:
        return 'unknown'

# 也可以用下面这个一行的 lambda 函数版本，方面复制
"""
get_val_type = lambda x: 'int' if isinstance(x, (int, np.integer)) else 'float' if isinstance(x, (float, np.floating)) else 'str' if isinstance(x, str) else 'nan' if pd.isna(x) else 'unknown'
"""

# 对 a 列应用该函数，返回每个元素的类型标识符
value_types = df['a'].apply(get_value_type)

# 输出结果
print(value_types)
```
```console
0      int
1      str
2    float
3      str
4      str
5    float
Name: a, dtype: object
```

**打印所有列的类型：**
```py
import pandas as pd
import numpy as np

# 创建示例数据
df = pd.DataFrame({'a': [1, '1', 2.0, '2.0', '3.14', np.nan], 'b': ['x', 'y', 'z', np.nan, 1, 2.0]})

# 定义一个函数，对每个元素进行类型判断，并返回相应的标识符
def get_value_type(value):
    if isinstance(value, (int, np.integer)):
        return 'int'
    elif isinstance(value, (float, np.floating)):
        return 'float'
    elif isinstance(value, str):
        return 'str'
    elif pd.isna(value):
        return 'nan'
    else:
        return 'unknown'

# 对整个 DataFrame 应用该函数，返回每个元素的类型标识符
value_types = df.applymap(get_value_type)

# 输出结果
print(value_types)
```
```console
       a      b
0    int    str
1    str    str
2  float    str
3    str  float
4    str    int
5  float  float
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
