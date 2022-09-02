
# 1

python logging模块使用教程 https://www.jianshu.com/p/feb86c06c4f4

## 个人例子

```py
import logging
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
