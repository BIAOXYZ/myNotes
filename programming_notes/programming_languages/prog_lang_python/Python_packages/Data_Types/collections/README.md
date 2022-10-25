
# 官方

collections --- 容器数据类型 https://docs.python.org/zh-cn/3.7/library/collections.html || collections — Container datatypes https://docs.python.org/3.7/library/collections.html

8.3. collections — High-performance container datatypes https://docs.python.org/zh-cn/2.7/library/collections.html || 8.3. collections — High-performance container datatypes https://docs.python.org/2.7/library/collections.html

# 其他

12. Collections https://book.pythontips.com/en/latest/collections.html

Python库的实用技巧专栏 https://juejin.cn/post/6844903992904908813
- > **`Counter`**
    ```py
    from collections import Counter
    test_list = [1, 2, 3, 3, 2, 1, 1, 1, 2, 2, 3, 1, 2, 1, 1]
    
    counter = Counter(test_list)
    # 返回值: Counter({1: 7, 2: 5, 3: 3})
    
    value = counter[2]
    # 返回值: 5
    
    # 实际上以上引入等价于以下代码:
    counter = {i: test_list.count(i) for i in set(test_list)}
    # 返回值: {1: 7, 2: 5, 3: 3}
    ```
