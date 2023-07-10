
# 已实践

## pandas打印时不省略

```py
import pandas as pd
pd.set_option('display.max_columns', None)  # 显示所有列
pd.set_option('display.max_rows', None)     # 显示所有行
pd.set_option('display.expand_frame_repr', False)  # 不自动换行
```
