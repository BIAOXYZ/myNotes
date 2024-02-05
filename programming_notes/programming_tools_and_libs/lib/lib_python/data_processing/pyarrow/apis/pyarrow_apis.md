
# 官方

`open_input_file(self, path)` https://arrow.apache.org/docs/python/generated/pyarrow.fs.HadoopFileSystem.html#pyarrow.fs.HadoopFileSystem.open_input_file
- > Open an input file for random access reading.
  >> //notes：对比 `open_input_stream()`，是不是这个接口在线打开一个远端 hdfs 上的 csv 文件的时候能够支持比如快速统计总行数、快速跳行（skiprows）之类的操作啊？

`open_input_stream(self, path, compression='detect', buffer_size=None)` https://arrow.apache.org/docs/python/generated/pyarrow.fs.HadoopFileSystem.html#pyarrow.fs.HadoopFileSystem.open_input_stream
- > Open an input stream for sequential reading.

# 其他

How to list HDFS subfolders and files recursively using pyarrow https://stackoverflow.com/questions/66873553/how-to-list-hdfs-subfolders-and-files-recursively-using-pyarrow
>> //notes：主要就是要用到 `fs.FileSelector`。

PyArrow: How to copy files from local to remote using new filesystem interface? https://stackoverflow.com/questions/68559318/pyarrow-how-to-copy-files-from-local-to-remote-using-new-filesystem-interface
