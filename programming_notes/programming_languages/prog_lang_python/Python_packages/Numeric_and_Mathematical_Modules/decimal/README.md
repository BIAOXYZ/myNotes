
# 官方

decimal --- 十进制定点和浮点运算 https://docs.python.org/zh-cn/3/library/decimal.html

# 其他

Python中保留两位小数的几种方法 https://blog.csdn.net/Jerry_1126/article/details/85009810
- > **方法三: 使用decimal模块**
  ```py
  >>> from decimal import Decimal
  >>> a = 12.345
  >>> Decimal(a).quantize(Decimal("0.00"))
  Decimal('12.35')
  ```

# LeetCode相关题目
- 【第 295 场周赛】 `6079. 价格减免` https://leetcode.cn/contest/weekly-contest-295/problems/apply-discount-to-prices/
