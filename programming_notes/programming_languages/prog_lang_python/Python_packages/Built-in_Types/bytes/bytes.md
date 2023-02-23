
# 官方

bytes 对象 https://docs.python.org/zh-cn/3.8/c-api/bytes.html

# 其他

python bytes和bytearray、编码和解码 https://www.cnblogs.com/f-ck-need-u/p/10185965.html

python3: bytes vs bytearray, and converting to and from strings https://stackoverflow.com/questions/62903377/python3-bytes-vs-bytearray-and-converting-to-and-from-strings

Python bytes类型及用法 http://c.biancheng.net/view/2175.html
- > `bytes` 只负责以字节序列的形式（二进制形式）来存储数据，至于这些数据到底表示什么内容（字符串、数字、图片、音频等），完全由程序的解析方式决定。如果采用合适的字符编码方式（字符集），字节串可以恢复成字符串；反之亦然，字符串也可以转换成字节串。
- > 说白了，`bytes` 只是简单地记录内存中的原始数据，至于如何使用这些数据，`bytes` 并不在意，你想怎么使用就怎么使用，`bytes` 并不约束你的行为。
- > `bytes` 类型的数据非常适合在互联网上传输，可以用于网络通信编程；`bytes` 也可以用来存储图片、音频、视频等二进制格式的文件。
- > 字符串和 `bytes` 存在着千丝万缕的联系，我们可以通过字符串来创建 `bytes` 对象，或者说将字符串转换成 `bytes` 对象。有以下三种方法可以达到这个目的：
  * > ***如果字符串的内容都是 `ASCII` 字符，那么直接在字符串前面添加`b前缀`就可以转换成 `bytes`***。
  * > `bytes` 是一个类，调用它的构造方法，也就是 `bytes()`，可以将字符串按照指定的字符集转换成 `bytes`；如果不指定字符集，那么默认采用 `UTF-8`。
  * > 字符串本身有一个 `encode()` 方法，该方法专门用来将字符串按照指定的字符集转换成对应的字节串；如果不指定字符集，那么默认采用 `UTF-8`。
- > 【实例】使用不同方式创建 `bytes` 对象：
  ```py
  #通过构造函数创建空 bytes
  b1 = bytes()
  #通过空字符串创建空 bytes
  b2 = b''
  #通过b前缀将字符串转换成 bytes
  b3 = b'http://c.biancheng.net/python/'
  print("b3: ", b3)
  print(b3[3])
  print(b3[7:22])
  #为 bytes() 方法指定字符集
  b4 = bytes('C语言中文网8岁了', encoding='UTF-8')
  print("b4: ", b4)
  #通过 encode() 方法将字符串转换成 bytes
  b5 = "C语言中文网8岁了".encode('UTF-8')
  print("b5: ", b5)
  ```
  > 运行结果：
  ```console
  b3:  b'http://c.biancheng.net/python/'
  112
  b'c.biancheng.net'
  b4:  b'C\xe8\xaf\xad\xe8\xa8\x80\xe4\xb8\xad\xe6\x96\x87\xe7\xbd\x918\xe5\xb2\x81\xe4\xba\x86'
  b5:  b'C\xe8\xaf\xad\xe8\xa8\x80\xe4\xb8\xad\xe6\x96\x87\xe7\xbd\x918\xe5\xb2\x81\xe4\xba\x86'
  ```
- > 从运行结果可以发现，***<ins>对于非 ASCII 字符，`print` 输出的是它的字符编码值（十六进制形式），而不是字符本身</ins>***。非 ASCII 字符一般占用两个字节以上的内存，而 `bytes` 是按照单个字节来处理数据的，所以不能一次处理多个字节。
- > `bytes` 类也有一个 `decode()` 方法，通过该方法可以将 `bytes` 对象转换为字符串。紧接上面的程序，添加以下代码：
  ```py
  #通过 decode() 方法将 bytes 转换成字符串
  str1 = b5.decode('UTF-8')
  print("str1: ", str1)
  ```
  > 输出结果：
  ```console
  str1:  C语言中文网8岁了
  ```
