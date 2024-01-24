
# 官方

Tenacity https://github.com/jd/tenacity

# 其他

Retrying Made Easy with Tenacity in Python https://www.opensourceforu.com/2022/12/retrying-made-easy-with-tenacity-in-python/

Python Tenacity 实现"重试机制" https://www.cnblogs.com/-wenli/p/13361926.html
- > **4. 重试后错误重新抛出**
  * > 当出现异常后，tenacity 会进行重试，若重试后还是失败，默认情况下，往上抛出的异常会变成 `RetryError`，而不是最根本的原因。因此可以加一个参数（`reraise=True`），使得当重试失败后，往外抛出的异常还是原来的那个。
