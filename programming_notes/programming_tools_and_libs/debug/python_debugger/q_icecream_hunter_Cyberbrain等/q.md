
# `q` 官方

q https://github.com/zestyping/q || https://pypi.org/project/q/
- > Quick and dirty debugging output for tired programmers. ⛺
- > Install `q` with `pip install -U q`.
- > All output goes to `/tmp/q` (or on Windows, to `$HOME/tmp/q`). You can watch the output with this shell command while your program is running:
  ```sh
  tail -f /tmp/q
  ```
- > To trace a function (showing its arguments, return value, and running time), insert this above the `def`:
  ```py
  import q
  @q
  ```
- > To start an interactive console at any point in your code, call `q.d()`:
  ```py
  import q; q.d()
  ```
- > **Other projects inspired by this one**
  * [`q` for golang](https://github.com/y0ssar1an/q)
  * [`qq` for elixir](https://github.com/mandarvaze/q)
  * ***[`ic` for Python](https://github.com/gruns/icecream) - Similar library for Python, inspired by `q`***.
    >> 【[:star:]】//notes：但是 `icecream` 仓库里没有提到这一点。。。
- > The following [Lightning Talk](http://pyvideo.org/video/1858/sunday-evening-lightning-talks#t=25m15s) shows how powerful using q can be.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `q` 其他

In python, is there a way to automatically log information any time you create a variable? https://stackoverflow.com/questions/62844130/in-python-is-there-a-way-to-automatically-log-information-any-time-you-create-a
- https://stackoverflow.com/questions/62844130/in-python-is-there-a-way-to-automatically-log-information-any-time-you-create-a/62844789#62844789

How does q work? https://www.pythoninsight.com/2018/05/how-does-q-work/

How to log a variable's name and value? https://stackoverflow.com/questions/19317770/how-to-log-a-variables-name-and-value
- https://stackoverflow.com/questions/19317770/how-to-log-a-variables-name-and-value/19318417#19318417
  * > If the tool you need is only for developing and debugging, there's a useful package called [q](https://github.com/zestyping/q).
  * > It has been submitted to pypi, it can be installed with `pip install q` or `easy_install q`.
    ```py
    import q; q(foo)

    # use @q to trace a function's arguments and return value
    @q
    def bar():
       ...

    # to start an interactive console at any point in your code:
    q.d()
    ```
  * > The results are output to the file `/tmp/q` (or any customized paths) by default, so they won't be mixed with stdout and normal logs. You can check the output with `tail -f /tmp/q`. The output is highlighted with different colors.
  * > The author introduced his library in a lightning talk of PyconUS 2013. The video is [here](https://youtu.be/OL3De8BAhME), begins at [25:15](https://www.youtube.com/watch?v=OL3De8BAhME&t=1515s).

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
