
# 官方

# 其他

Python all() https://www.programiz.com/python-programming/methods/built-in/all
- > **`all()` Syntax**
  * > The syntax of the `all()` function is:
    ```py
    all(iterable)
    ```
- > **`all()` Parameters**
  * > The all() function takes a single parameter: iterable - any iterable (`list`, `tuple`, `dictionary`, etc.) which contains the elements
- > **`all()` Return Value**
  * > **True** - If all elements in an iterable are true
  * > **False** - If any element in an iterable is false

    | When | Return Value |
    |--|--|
    | All values are true  | True |
    | All values are false | False |
    | One value is true (others are false) | False |
    | One value is false (others are true) | False |
    | Empty Iterable | True |

>> //notes：说白了，`all(iterable)` 返回 `True` 的条件就是：
- 1.要么 iterable 参数里面的元素全为“真”（比如某个 List 里全是非零的数字，这个条件很自然）。
- 2.要么这个 iterable 里面没有元素（比如 iterable 参数是一个空的 List，***这个条件不是很自然***）。
