
Shell脚本获取自身路径的方法 https://www.jianshu.com/p/7b4576eb3655
- > 可以看出，pwd 获取的『当前工作目录』可能并不是『脚本文件所在目录』。因此我们可以用以下方法获取脚本文件所在目录的绝对路径：
```sh
MYDIR=`dirname $0`
```

shell 当前工作目录的绝对路径 https://www.jianshu.com/p/7b4576eb3655
- > 编写脚本中，需要获取执行脚本的绝对路径，今天写脚本的时候不小心踩了个坑，记录下。那个坑的脚本大概是这样的：
```sh
#!/bin/bash

work_path=$(dirname $0)
cd ~/${work_path}
## blblbl
cd /home/lcd/
cp ./something ${work_path}
```
