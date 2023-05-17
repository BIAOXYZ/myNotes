
# 官方

pickle --- Python 对象序列化 https://docs.python.org/zh-cn/3/library/pickle.html || pickle — Python object serialization https://docs.python.org/3/library/pickle.html

# 其他

# 问题

## `EOFError: Ran out of input`

EOFError: Ran out of input https://blog.csdn.net/castle_cc/article/details/78193942

Why do I get "Pickle - EOFError: Ran out of input" reading an empty file? https://stackoverflow.com/questions/24791987/why-do-i-get-pickle-eoferror-ran-out-of-input-reading-an-empty-file

>> //notes：由于我不是以文件为输入进行序列化，而是以字节流为输入（也就是调用的是 `pickle.dumps()`，而不是 `pickle.dump()`）进行序列化。所以我面临的不是文件为空，而是字节流为空（打印出来是 `b''`）。于是面临的一个问题就是：***如何判断一个字节流是空的***。
- Test if byte is empty in python https://stackoverflow.com/questions/40015912/test-if-byte-is-empty-in-python
