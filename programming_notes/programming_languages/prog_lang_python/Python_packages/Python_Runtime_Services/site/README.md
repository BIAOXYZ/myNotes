
# 官方

site —— 指定域的配置钩子 https://docs.python.org/zh-cn/3/library/site.html

# 其他

【[:ok:][:star:][`*`]】 How does python find packages? https://leemendelowitz.github.io/blog/how-does-python-find-packages.html
- > I just ran into a situation where ***I compiled and installed Python 2.7.9 from source on Ubuntu, but Python could not find the packages I had previously installed***. This naturally raises the question - how does Python know where to find packages when you call `import`? This post applies specifically to Python 2.7.9, but I'm guessing Python 3x works very similarly.
- > In this post I first describe how Python finds packages, and then I'll finish with the discovery I made regarding the default Python that ships with Ubuntu and how it differs from vanilla Python in how it finds packages.
- > **`sys.path`**
  * > Python imports work by searching the directories listed in `sys.path`.
  * > Using my default Ubuntu 14.04 Python:
    ```py
    >>> import sys
    >>> print '\n'.join(sys.path)

    /usr/lib/python2.7
    /usr/lib/python2.7/plat-x86_64-linux-gnu
    /usr/lib/python2.7/lib-tk
    /usr/lib/python2.7/lib-old
    /usr/lib/python2.7/lib-dynload
    /usr/local/lib/python2.7/dist-packages
    /usr/lib/python2.7/dist-packages
    ```
- > **How `sys.path` gets populated**
  * > As the [docs](https://docs.python.org/2/library/sys.html#sys.path) explain, `sys.path` is populated using ***`the current working directory`***, followed by directories listed in your ***`PYTHONPATH` environment variable***, followed by ***`installation-dependent default paths`***, which are controlled by the ***`site` module***.
    >> 【[:star:][`*`]】 //notes：系统依次从三个地方获取路径值作为 `sys.path`：1.当前目录、2.`PYTHONPATH` 环境变量、3.安装Python时设置的默认目录，由 `site` 模块控制。
  * > Assuming your `PYTHONPATH` environment variable is not set, `sys.path` will consist of the current working directory plus any manipulations made to it by the `site` module.
  * > The `site` module is automatically imported when you start Python, you can read more about how it manipulates your `sys.path` in the [Python docs](https://docs.python.org/2/library/site.html#module-site).
- > **You can manipulate `sys.path`**
  * > You can manipulate `sys.path` during a Python session and this will change how Python finds modules. For example:
    ```py
    import sys, os
    
    # This won't work - there is no hi module
    import hi 
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    ImportError: No module named hi
    
    # Create a hi module in your home directory.
    home_dir = os.path.expanduser("~")
    my_module_file = os.path.join(home_dir, "hi.py")
    with open(my_module_file, 'w') as f:
      f.write('print "hi"\n')
      f.write('a=10\n')
    
    # Add the home directory to sys.path
    sys.path.append(home_dir)
    
    # Now this works, and prints hi!
    import hi 
    print hi.a
    ```
- > **The module `__file__` attribute**
  * > When you import a module, you usually can check the `__file__` attribute of the module to see where the module is in your filesystem:
    ```py
    >>> import numpy
    >>> numpy.__file__
    '/usr/local/lib/python2.7/dist-packages/numpy/__init__.pyc'
    ```
  * > However, the [Python docs](https://docs.python.org/2/reference/datamodel.html#the-standard-type-hierarchy) state that: `The file attribute is not present for C modules that are statically linked into the interpreter; for extension modules loaded dynamically from a shared library, it is the pathname of the shared library file.`
  * > So, for example this doesn't work:
    ```py
    >>> import sys
    >>> sys.__file__
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: 'module' object has no attribute '__file__'
    ```
  * > It makes sense that the `sys` module is ***statically linked*** to the interpreter - it is essentially ***part of the interpreter***!
    >> 【[:star:][`*`]】 //notes：所以 `sys` 这个包是静态链接到python解释器的。
- > **The `imp` module**
  * > Python exposes the entire *import system* through the [`imp`](https://docs.python.org/2.7/library/imp.html) module. That's pretty cool that all of this stuff is exposed for us to abuse, if we wanted to.
  * > `imp.find_module` can be used to find a module:
    ```py
    >>> import imp
    >>> imp.find_module('numpy')
    (None, '/usr/local/lib/python2.7/dist-packages/numpy', ('', '', 5))
    ```
  * > You can also ***import an arbitrary Python source as a module*** using `imp.load_source`. ***This is the same example before, except imports our module using `imp` instead of by manipulating `sys.path`***:
    ```py
    import sys, os, imp
    
    # Create a hi module in your home directory.
    home_dir = os.path.expanduser("~")
    my_module_file = os.path.join(home_dir, "hi.py")
    with open(my_module_file, 'w') as f:
      f.write('print "hi"\n')
      f.write('a=10\n')
    
    # Load the hi module using imp
    hi = imp.load_source('hi', my_module_file)
    
    # Now this works, and prints hi!
    import hi 
    print hi.a # a is 10!
    print type(hi) # it's a module!
    ```
    > Passing 'hi' to `imp.load_source` simply sets the `__name__` attribute of the module.
- > **Ubuntu Python**
  * > Now back to the issue of ***missing packages after installing a new version of Python compiled from source***. By comparing the `sys.path` from both the Ubuntu Python, which resides at `/usr/bin/python`, and the newly installed Python, which resides at `/usr/local/bin/python`, I could sort things out:
  * > **Ubuntu Python (`/usr/bin/python`)**:
    ```py
    >>> import sys
    >>> print '\n'.join(sys.path)
    
    /usr/lib/python2.7
    /usr/lib/python2.7/plat-x86_64-linux-gnu
    /usr/lib/python2.7/lib-tk
    /usr/lib/python2.7/lib-old
    /usr/lib/python2.7/lib-dynload
    /usr/local/lib/python2.7/dist-packages
    /usr/lib/python2.7/dist-packages
    ```
  * > **Python compiled from source (`/usr/local/bin/python`)**:
    ```py
    >>> import sys
    >>> print '\n'.join(sys.path)
     
    /usr/local/lib/python27.zip
    /usr/local/lib/python2.7
    /usr/local/lib/python2.7/plat-linux2
    /usr/local/lib/python2.7/lib-tk
    /usr/local/lib/python2.7/lib-old
    /usr/local/lib/python2.7/lib-dynload
    /usr/local/lib/python2.7/site-packages
    ```
  * > Turns out what mattered for me was `dist-packages` vs. `site-packages`. Using Ubuntu's Python, my packages were installed to `/usr/local/lib/python2.7/dist-packages`, whereas the new Python I installed expects packages to be installed to `/usr/local/lib/python2.7/site-packages`. I just had to ***manipulate the `PYTHONPATH` environment variable to point to `dist-packages` in order to gain access to the previously installed packaged*** with the newly installed version of Python.
    >> 【[:star:][`*`]】 //notes：核心就在这里了，既解释清楚了原因，也给了最简单的解决方法。那么当然也可以通过在python文件里把 `dist-packages` 对应的目录贴到 `sys.path` 里来解决。
- > **How did Ubuntu manipulate the `sys.path`?**
  * > So how does the Ubuntu distribution of Python know to use `/usr/local/lib/python2.7/dist-packages` in `sys.path`? It's ***hardcoded into their `site` module***! First, find where the `site` module code lives:
    ```py
    >>> import site
    >>> site.__file__
    '/usr/lib/python2.7/site.pyc'
    ```
  * > Here is an excerpt from Ubuntu Python's `site.py`, which I peeked by opening `/usr/lib/python2.7/site.py` in a text editor. First, a comment at the top: `For Debian and derivatives, this sys.path is augmented with directories for packages distributed within the distribution. Local addons go into /usr/local/lib/python/dist-packages, Debian addons install into /usr/{lib,share}/python/dist-packages. /usr/lib/python/site-packages is not used.`
    >> 【[:star:][`*`]】 //notes：这个可能只是 Debian 系才会有的现象，怀疑 RedHat 系没有这个问题。
    >>> What's the difference between dist-packages and site-packages? https://stackoverflow.com/questions/9387928/whats-the-difference-between-dist-packages-and-site-packages
    >>>> 【[:star:][`*`]】 //notes：总结下上面这个回答，原因就是 Debian 系的 OS 发行版把 `Debian package manager` （比如 `apt`）安装的和Python有关的包（比如 `pip`、`easy_install`）放到 `dist-packages` 目录里。但是用 `pip` 去装的Python的包，跟系统包管理器就没啥关系了，所以是（按Python的规定）在 `site-packages` 里。
  * > OK so there you have it. They explain how ***the Debian distribution of Python is different***.
  * > And now, for the code that implementes this change:
    ```py
    def getsitepackages():
        """Returns a list containing all global site-packages directories
        (and possibly site-python).
    
        For each directory present in the global ``PREFIXES``, this function
        will find its `site-packages` subdirectory depending on the system
        environment, and will return a list of full paths.
        """
        sitepackages = []
        seen = set()
    
        for prefix in PREFIXES:
            if not prefix or prefix in seen:
                continue
            seen.add(prefix)
    
            if sys.platform in ('os2emx', 'riscos'):
                sitepackages.append(os.path.join(prefix, "Lib", "site-packages"))
            elif os.sep == '/':
                sitepackages.append(os.path.join(prefix, "local/lib",
                                            "python" + sys.version[:3],
                                            "dist-packages"))
                sitepackages.append(os.path.join(prefix, "lib",
                                            "python" + sys.version[:3],
                                            "dist-packages"))
            else:
                sitepackages.append(prefix)
                sitepackages.append(os.path.join(prefix, "lib", "site-packages"))
            if sys.platform == "darwin":
                # for framework builds *only* we add the standard Apple
                # locations.
                from sysconfig import get_config_var
                framework = get_config_var("PYTHONFRAMEWORK")
                if framework:
                    sitepackages.append(
                            os.path.join("/Library", framework,
                                sys.version[:3], "site-packages"))
        return sitepackages
    ```
  * > It's all there, if you are crazy enough to dig this deep.
- 回复里的：
  * > Just want to say that `imp` is now deprecated in favor of `importlib` :) (since `Python 3.4`)
    + > https://docs.python.org/3.5/library/imp.html
    + > I'm using `importlib.util.find_spec` instead of `imp.find_module` but it will not work on `Python 2`!
  * > `export PYTHONPATH="/usr/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:/usr/local/lib/python2.7/dist-packages"`
  * > Good article. Also be aware that `easy_install` has a bad habit of putting `eggs` it installs ***at the highest import priority***, before the earliest items in the `PYTHONPATH`. Yet another reason to not like `easy_install`.
  * > What path does python use to find and load a ***C extension `.dll`***? All I ever get is "ImportError: No module named 'foo'". I have tried adding my folder to the `sys.path` and see that it is there when I print `sys.path`. I have also tried putting my `.dll` into the python 3.5 folder which is also on the `sys.path`.
    >> Not sure if this question has not been answered yet, but python does not seem to load `dll` from `sys.path`. It loads dlls from `os.environ['Path']`.
    >>> 【[:star:][`*`]】 //notes：其实还有可能是因为动态库文件名字和模块名字不匹配吧。。。之前用 `pybind11` 时碰到过，动态库的名字不能随便取- -。

Python 是如何寻找包的？ https://blog.windrunner.me/python/find-pkg.html
