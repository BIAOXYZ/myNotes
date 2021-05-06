
# urllib.request 官方

urllib.request — Extensible library for opening URLs https://docs.python.org/3/library/urllib.request.html

HOWTO Fetch Internet Resources Using The urllib Package https://docs.python.org/3/howto/urllib2.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# urllib.request 语法

## `urllib.request.urlretrieve()`

urllib.request.urlretrieve()函数 https://blog.csdn.net/pursuit_zhangyu/article/details/80556275
```py
import os
from six.moves import urllib
import sys

DATA_URL = 'http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2'
filename = DATA_URL.split('/')[-1]

def _progress(block_num, block_size, total_size):
    '''回调函数
       @block_num: 已经下载的数据块
       @block_size: 数据块的大小
       @total_size: 远程文件的大小
    '''
    sys.stdout.write('\r>> Downloading %s %.1f%%' % (filename,
                     float(block_num * block_size) / float(total_size) * 100.0))
    sys.stdout.flush()

filepath, _ = urllib.request.urlretrieve(DATA_URL, filename, _progress)
print()
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# rurllib.request 其他

python使用urlopen/urlretrieve下载文件时出现403 forbidden的解决方法【转载】 https://blog.csdn.net/qq_34309753/article/details/81502529
