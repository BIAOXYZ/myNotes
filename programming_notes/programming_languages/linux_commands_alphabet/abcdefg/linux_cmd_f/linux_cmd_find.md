
爹地，我找到了!, 15个极好的Linux find命令示例 https://www.oschina.net/translate/15-practical-unix-linux-find-command-examples-part-2
```
test@cloudsec1 ~ $ touch 123
test@cloudsec1 ~ $ find . -mmin 1
.
./123

//一分钟过去后，但是两分钟不到
test@cloudsec1 ~ $ find . -mmin 1
test@cloudsec1 ~ $ find . -mmin 2
.
./123

//修改文件也能察觉到
test@cloudsec1 ~ $ echo asd > 123
test@cloudsec1 ~ $ find . -mmin 2
.
test@cloudsec1 ~ $ find . -mmin 1
./123
```
>> notes：这个`-mmin 1`不好的地方就在于，只能是1分钟以内，超过了就不行。也就是这个命令有时效性。可以通过增加条件来解决，回头再试试并总结。
