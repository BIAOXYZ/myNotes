
# `icecream` 官方

icecream https://github.com/gruns/icecream
- > **Import Tricks**
  * > To make `ic()` available in every file without needing to be imported in every file, you can `install()` it. For example, in a root `A.py`:
    ```python
    #!/usr/bin/env python3
    # -*- coding: utf-8 -*-

    from icecream import install
    install()

    from B import foo
    foo()
    ```
    > and then in `B.py`, which is imported by `A.py`, just call `ic()`:
    ```python
    # -*- coding: utf-8 -*-

    def foo():
        x = 3
        ic(x)
    ```
    > ***`install()` adds `ic()` to the [builtins](https://docs.python.org/3.8/library/builtins.html) module, which is shared amongst all files imported by the interpreter***. Similarly, `ic()` can later be `uninstall()`ed, too.
  * > `ic()` can also be imported in a manner that fails gracefully if IceCream isn't installed, like in production environments (i.e. not development). To that end, this fallback import snippet may prove useful:
    ```python
    try:
        from icecream import ic
    except ImportError:  # Graceful fallback if IceCream isn't installed.
        ic = lambda *a: None if not a else (a[0] if len(a) == 1 else a)  # noqa
    ```
- > **Inspect Execution**
  * > Have you ever used `print()` to determine which parts of your program are executed, and in which order they're executed? For example, if you've ever added print statements to debug code like
    ```python
    def foo():
        print(0)
        first()

        if expression:
            print(1)
            second()
        else:
            print(2)
            third()
    ```
  * > then `ic()` helps here, too. Without arguments, `ic()` inspects itself and prints the calling filename, line number, and parent function.
    ```python
    from icecream import ic

    def foo():
        ic()
        first()

        if expression:
            ic()
            second()
        else:
            ic()
            third()
    ```
    > Prints
    ```console
    ic| example.py:4 in foo()
    ic| example.py:11 in foo()
    ```
    > Just call `ic()` and you're done. Simple.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `icecream` 其他

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
