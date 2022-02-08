
# 官方

json --- JSON 编码和解码器 https://docs.python.org/zh-cn/3/library/json.html 【官方文档的例子就很好，已经足够了。】
- > [json](https://docs.python.org/zh-cn/3/library/json.html#module-json) 提供了与标准库 [marshal](https://docs.python.org/zh-cn/3/library/marshal.html#module-marshal) 和 [pickle](https://docs.python.org/zh-cn/3/library/pickle.html#module-pickle) 相似的API接口。
- > 对基本的 Python 对象层次结构进行编码：
  ```py
  >>> import json
  >>> json.dumps(['foo', {'bar': ('baz', None, 1.0, 2)}])
  '["foo", {"bar": ["baz", null, 1.0, 2]}]'
  >>> print(json.dumps("\"foo\bar"))
  "\"foo\bar"
  >>> print(json.dumps('\u1234'))
  "\u1234"
  >>> print(json.dumps('\\'))
  "\\"
  >>> print(json.dumps({"c": 0, "b": 0, "a": 0}, sort_keys=True))
  {"a": 0, "b": 0, "c": 0}
  >>> from io import StringIO
  >>> io = StringIO()
  >>> json.dump(['streaming API'], io)
  >>> io.getvalue()
  '["streaming API"]'
  ```
- > 紧凑编码：
  ```py
  >>> import json
  >>> json.dumps([1, 2, 3, {'4': 5, '6': 7}], separators=(',', ':'))
  '[1,2,3,{"4":5,"6":7}]'
  ```
- > 美化输出：
  ```py
  >>> import json
  >>> print(json.dumps({'4': 5, '6': 7}, sort_keys=True, indent=4))
  {
      "4": 5,
      "6": 7
  }
  ```
- > JSON解码：
  ```py
  >>> import json
  >>> json.loads('["foo", {"bar":["baz", null, 1.0, 2]}]')
  ['foo', {'bar': ['baz', None, 1.0, 2]}]
  >>> json.loads('"\\"foo\\bar"')
  '"foo\x08ar'
  >>> from io import StringIO
  >>> io = StringIO('["streaming API"]')
  >>> json.load(io)
  ['streaming API']
  ```
- > 从命令行使用 [`json.tool`](https://docs.python.org/zh-cn/3/library/json.html#module-json.tool) 来验证并美化输出：
  ```sh
  $ echo '{"json":"obj"}' | python -m json.tool
  {
      "json": "obj"
  }
  $ echo '{1.2:3.4}' | python -m json.tool
  Expecting property name enclosed in double quotes: line 1 column 2 (char 1)
  ```

# 其他

Python List to JSON https://pythonexamples.org/python-list-to-json/

Python JSON to List https://pythonexamples.org/python-json-to-list/
