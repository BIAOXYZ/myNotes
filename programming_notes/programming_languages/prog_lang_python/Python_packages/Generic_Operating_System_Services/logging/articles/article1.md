
# 1

python logging模块使用教程 https://www.jianshu.com/p/feb86c06c4f4

## 个人例子

```py
import logging
# 这句使得日志文件的位置和当前程序文件位于同一目录。
logger_path = os.path.join(os.path.split(__file__)[0], "storage.log")
logger_format = "%(asctime)-15s %(levelname)s %(filename)s %(lineno)d %(process)d %(message)s"
logging.basicConfig(level=logging.DEBUG, filename=logger_path, format=logger_format)
logger = logging.getLogger("storage")

# 下方为具体的代码逻辑，省略。
```
单次运行后大概长这样（跟代码逻辑紧密相关，这里主要是展示下格式。。。）：
```console
2022-09-02 08:43:08,904 DEBUG sqlite_manager.py 35 2294580 echo '.mode csv\n.import ./input_data.csv t1' | sqlite3 ./12345
2022-09-02 08:43:08,915 DEBUG sqlite_manager.py 61 2294580 create table t_input_data (col1, col2, col3);
2022-09-02 08:43:08,923 DEBUG sqlite_manager.py 35 2294580 echo '.mode csv\n.import ./input_data.csv t_input_data' | sqlite3 ./12345
2022-09-02 08:43:08,933 DEBUG sqlite_manager.py 74 2294580 echo '.header off\n.mode csv\n.once ./output_data.csv\nselect * from t_input_data;' | sqlite3 ./12345
```
```console
# 更推荐在合适的地方加上中括号之类，更容易看，比如上面设置格式那句可以这么写：
# logger_format = "[%(asctime)-15s %(levelname)s %(filename)s %(lineno)d %(process)d] %(message)s"
# 打印效果更好：

[2022-09-02 08:55:23,481 DEBUG sqlite_manager.py 35 2301177] echo '.mode csv\n.import ./input_data.csv t1' | sqlite3 ./12345
[2022-09-02 08:55:23,492 DEBUG sqlite_manager.py 61 2301177] create table t_input_data (col1, col2, col3);
[2022-09-02 08:55:23,501 DEBUG sqlite_manager.py 35 2301177] echo '.mode csv\n.import ./input_data.csv t_input_data' | sqlite3 ./12345
[2022-09-02 08:55:23,511 DEBUG sqlite_manager.py 74 2301177] echo '.header off\n.mode csv\n.once ./output_data.csv\nselect * from t_input_data;' | sqlite3 ./12345
```

## 其他配置和例子

```py
logging.basicConfig(level=logging.INFO,
                    format="%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s",\
                    datefmt="%a, %d %b %Y %H:%M:%S",\
                    filename="test_program.log",\
                    filemode="w")
```
```console
Tue, 18 Oct 2022 11:04:01 test_program.py[line:84] INFO xxxxxxx
Tue, 18 Oct 2022 11:04:01 test_program.py[line:41] INFO xxxxxxx
Tue, 18 Oct 2022 11:04:01 test_program.py[line:42] INFO xxxxxxx
Tue, 18 Oct 2022 11:04:01 test_program.py[line:43] INFO xxxxxxx
Tue, 18 Oct 2022 11:04:01 test_program.py[line:44] INFO xxxxxxx
Tue, 18 Oct 2022 11:04:52 test_program.py[line:86] INFO xxxxxxx
```
