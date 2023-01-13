
# `os.getegid()`

# 获取运行 python 脚本的用户

How to determine what user and group a Python script is running as? https://stackoverflow.com/questions/3042304/how-to-determine-what-user-and-group-a-python-script-is-running-as
- https://stackoverflow.com/questions/3042304/how-to-determine-what-user-and-group-a-python-script-is-running-as/3042321#3042321
  * > You can use the following piece of code:
    ```py
    import os
    print(os.getegid())
    ```
