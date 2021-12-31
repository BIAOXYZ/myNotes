
# 官方

gzip --- 对 gzip 格式的支持 https://docs.python.org/zh-cn/3/library/gzip.html

# 其他

# 问题

## `UnicodeDecodeError: 'utf-8' codec can't decode byte 0x8b in position 1: invalid start byte`
>> //notes：背景是碰到了一个从 hdfs 上 `get` 下来的 `example.tsv` 文件，但是用 `cat` 去看是一堆乱码。如果在从 hdfs 获取文件的时候使用 `hdfs dfs -text <some_prefix_dirs>/example.tsv` 就能正确读到文件的内容。所以看起来是 `hdfs` 的 `-text` 参数做了一些动作，但是网上搜了下 + 本地大概看了看 `hdfs` 的内容（这货不是个二进制，就是个脚本而已），没发现啥。后来偶然发现了上述报错信息，网上搜到了。

- UnicodeDecodeError: 'utf-8' codec can't decode byte 0x8b in position 1: invalid start byte解决方法 https://www.jianshu.com/p/04b49fe01c2f
- UnicodeDecodeError: 'utf-8' codec can't decode byte 0x8b in position 1: invalid start byte, while reading csv file in pandas https://stackoverflow.com/questions/44659851/unicodedecodeerror-utf-8-codec-cant-decode-byte-0x8b-in-position-1-invalid

综合了上面两个帖子，大致是这么解决的（用 `readline()` 对大文件比较好，`readlines()` 的话要整个文件都读进内存）：
```py
with open(compressed_file_for_read, 'rb') as fd:
    hdfs_file = gzip.GzipFile(fileobj=fd)
    with open(file_path_for_write, 'w') as out_file:
        line = hdfs_file.readline().decode('utf-8')
        while line:
            out_file.write(line)
            line = hdfs_file.readline().decode('utf-8')
```
