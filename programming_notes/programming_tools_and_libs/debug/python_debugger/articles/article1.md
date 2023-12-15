
# 1

Python debugging tools https://blog.ionelmc.ro/2013/06/05/python-debugging-tools/
- > **Tracing**
  * > Sometimes it's better to see what gets executed. You could run step-by-step using some IDE's debugger but you would need to know what you're looking for, otherwise the process will be very slow.
  * > In the stdlib there's a trace module which can print all the executed lines amongst other this (like making coverage reports)
    ```py
    python -mtrace --trace script.py
    ```
  * > This will make lots of output (every line executed will be printed so you might want to pipe it through grep to only see the interesting modules). Eg:
    ```py
    python -mtrace --trace script.py | egrep '^(mod1.py|mod2.py)'
    ```
  * > **Alternatives**
    + > Grepping for relevant output is not fun. Plus, the trace module doesn't show you any variables.
    + > [Hunter](https://pypi.python.org/pypi/hunter) is a flexible alternative that allows filtering and even shows variables of your choosing. Just pip install hunter and run:
      ```sh
      PYTHON_HUNTER="F(module='mod1'),F(module='mod2')" python script.py
      ```
    * > Take a look at the [project page](https://github.com/ionelmc/python-hunter) for more examples.
- > **Having segfaults? faulthandler**
  * > Just do this and you'll get at least an idea of what's causing the segmentation fault. Just add this in some module that's always imported:
    ```py
    import faulthandler
    faulthandler.enable()
    ```
  * > This won't work in `PyPy` unfortunately. If you can't get interactive (e.g.: use `gdb`) you can just set this environment variable (GNU libc only, [details](http://blog.andrew.net.au/2007/08/15/)):
    ```sh
    export LD_PRELOAD=/lib/x86_64-linux-gnu/libSegFault.so
    ```
  * > Make sure the path is correct - otherwise it won't have any effect (e.g.: run `locate libSegFault.so`).
- > **Memory leaks**
- > **Memory usage**
