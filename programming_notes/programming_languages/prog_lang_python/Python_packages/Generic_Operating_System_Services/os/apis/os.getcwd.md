
# `os.getcwd()`

os.getcwd() vs os.path.abspath(os.path.dirname(__file__)) https://stackoverflow.com/questions/11274040/os-getcwd-vs-os-path-abspathos-path-dirname-file
- https://stackoverflow.com/questions/11274040/os-getcwd-vs-os-path-abspathos-path-dirname-file/11274226#11274226
  * > `os.getcwd()` does a bit more than returning the current working directory. It defaults to `$PWD` in your env. ***It's not where the script is located but where you were when you executed the script***.
  * > Being in `/home/user` and doing `python manage.py`, `os.getcwd()` will return `/home/user`
  * > Being in `/home/` and doing `python user/manage.py`, `os.getcwd()` will return `/home`
