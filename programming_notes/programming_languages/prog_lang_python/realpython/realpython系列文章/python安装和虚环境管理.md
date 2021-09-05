
Python Virtual Environments: A Primer https://realpython.com/python-virtual-environments-a-primer/
- **Why the Need for Virtual Environments?**
- > There are a few different locations where these packages can be installed on your system. For example, most system packages are stored in a child directory of the path stored in `sys.prefix`.
- > On Mac OS X, you can easily find where sys.prefix points to using the Python shell:
  ```py
  >>> import sys
  >>> sys.prefix
  '/System/Library/Frameworks/Python.framework/Versions/3.5'
  ```
- > More relevant to the topic of this article, third party packages installed using `easy_install` or `pip` are typically placed in one of the directories pointed to by `site.getsitepackages`:
  ```py
  >>> import site
  >>> site.getsitepackages()
  [
    '/System/Library/Frameworks/Python.framework/Versions/3.5/Extras/lib/python',
    '/Library/Python/3.5/site-packages'
  ]
  ```
- > Consider the following scenario where you have two projects: ProjectA and ProjectB, both of which have a dependency on the same library, ProjectC. The problem becomes apparent when we start requiring different versions of ProjectC. Maybe ProjectA needs v1.0.0, while ProjectB requires the newer v2.0.0, for example.
  >
  > This is a real problem for Python since it can’t differentiate between versions in the site-packages directory. So both v1.0.0 and v2.0.0 would reside in the same directory with the same name:
  ```console
  /System/Library/Frameworks/Python.framework/Versions/3.5/Extras/lib/python/ProjectC
  ```
- **Using Virtual Environments**
- > To get started, if you’re not using Python 3, you’ll want to install the virtualenv tool with pip:
  ```sh
  $ pip install virtualenv
  ```
- > Start by making a new directory to work with:
  ```sh
  $ mkdir python-virtual-environments && cd python-virtual-environments
  ```
- > Create a new virtual environment inside the directory:
  ```sh
  # Python 2:
  $ virtualenv env
  
  # Python 3
  $ python3 -m venv env
  ```
- **How Does a Virtual Environment Work?**
- > To explain how this works, let’s first check out the locations of the different python executables. With the environment “deactivated,” run the following:
  ```sh
  $ which python
  /usr/bin/python
  ```
- > Now, activate it and run the command again:
  ```sh
  $ source env/bin/activate
  (env) $ which python
  /Users/michaelherman/python-virtual-environments/env/bin/python
  ```
- > Notice the difference between the first path in $PATH before and after the activation:
  ```sh
  $ echo $PATH
  /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:
  
  $ source env/bin/activate
  (env) $ echo $PATH
  /Users/michaelherman/python-virtual-environments/env/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:
  ```
  > In the latter example, our virtual environment’s bin directory is now at the beginning of the path. That means it’s the first directory searched when running an executable on the command line. Thus, the shell uses our virtual environment’s instance of Python instead of the system-wide version.
  >
  > **Note**: Other packages that bundle Python, like [Anaconda](), also tend to manipulate your path when you activate them. Just be aware of this in case you run into problems with your other environments. ***This can become a problem if you start activating multiple environments at once***.
- > This raises the following questions:
  * > What’s the difference between these two executables anyway?
  * > How is the virtual environment’s Python executable able to use something other than the system’s site-packages?
- > This can be explained by how Python starts up and where it is located on the system. There actually isn’t any difference between these two Python executables. **It’s their directory locations that matter**.
  >
  > When Python is starting up, it looks at the path of its binary. In a virtual environment, it is actually just a copy of, or symlink to, your system’s Python binary. It then sets the location of `sys.prefix` and `sys.exec_prefix` based on this location, omitting the bin portion of the path.
  > 
  > The path located in `sys.prefix` is then used for locating the `site-packages` directory by searching the ***relative path*** `lib/pythonX.X/site-packages/`, where `X.X` is the version of Python you’re using.
  > 
  > In our example, the binary is located at `/Users/michaelherman/python-virtual-environments/env/bin`, which means `sys.prefix` would be `/Users/michaelherman/python-virtual-environments/env`, and therefore the `site-packages` directory used would be `/Users/michaelherman/python-virtual-environments/env/lib/pythonX.X/site-packages`. Finally, this path is stored in the `sys.path` array, which contains all of the locations where a package can reside.
- **Managing Virtual Environments With virtualenvwrapper**
- > If you would like to be able to use a single tool and switch between Python versions, virtualenv will allow you to do just that. virtualenv has a [parameter]() `-p` that allows you to select which version of Python to use. Combine that with the which command, and we can easily select your preferred version of Python to use in a simple manner. For example, let’s say that we want Python 3 as our preferred version:
  ```sh
  $ virtualenv -p $(which python3) blog_virtualenv
  ```
- **Using Different Versions of Python**
- > Unlike the old `virtualenv` tool, `pyvenv` doesn’t support creating environments with arbitrary versions of Python, which means you’re stuck using the default Python 3 installation for all of the environments you create. While you can upgrade an environment to the latest system version of Python (via the `--upgrade` option), if it changes, you still can’t actually specify a particular version.
- > There are quite a few ways to install Python, but few of them are easy enough or flexible enough to frequently uninstall and re-install different versions of the binary.
  >
  > This is where `pyenv` comes in to play.
  >
  > Despite the similarity in names (`pyvenv` vs `pyenv`), `pyenv` is different in that its focus is to help you switch between Python versions on a system-level as well as a project-level. While the purpose of `pyvenv` is to separate out modules, the purpose of pyenv is to separate Python versions.
  >> //notes：真是服了，不是看到这段，我还以为这俩是一个东西。。。
- > You can start by installing pyenv with either Homebrew (on OS X) or the pyenv-installer project:
  * > Homebrew
    ```sh
    $ brew install pyenv
    ```
  * > pyenv-installer
    ```sh
    $ curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
    ```
  * > **Note**: Unfortunately, `pyenv` does not support Windows. A few alternatives to try are `pywin` and `anyenv`.
- > Once you have pyenv on your system, here are a few of the basic commands you’re probably interested in:
  ```sh
  $ pyenv install 3.5.0   # Install new version
  $ pyenv versions        # List installed versions
  $ pyenv exec python -V  # Execute 'python -V' using pyenv version
  ```
  > In these few lines, we install the 3.5.0 version of Python, ask pyenv to show us all of the versions available to us, and then execute the python `-V` command using the pyenv-specified version.
- > To give you even more control, you can then use any of the available versions for either “global” use or “local” use. Using `pyenv` with the `local` command sets the Python version for a specific project or directory by storing the version number in a local `.python-version` file. We can set the “local” version like this:
  ```sh
  $ pyenv local 2.7.11
  ```
  > This creates the `.python-version` file ***in our current directory***, as you can see here:
  ```sh
  $ ls -la
  total 16
  drwxr-xr-x  4 michaelherman  staff  136 Feb 22 10:57 .
  drwxr-xr-x  9 michaelherman  staff  306 Jan 27 20:55 ..
  -rw-r--r--  1 michaelherman  staff    7 Feb 22 10:57 .python-version
  -rw-r--r--  1 michaelherman  staff   52 Jan 28 17:20 main.py
  ```
  > This file only contains the contents “2.7.11”. Now, when you execute a script using pyenv, it’ll load this file and use the specified version, assuming it’s valid and exists on your system.
- > Moving on with our example, let’s say we have a simple script called `main.py` in our project directory that looks like this:
  ```py
  import sys
  print('Using version:', sys.version[:5])
  ```
  > All it does is print out the version number of the Python executable being used. Using `pyenv` and the `exec` command, we can run the script with any of the different versions of Python we have installed.
  ```sh
  $ python main.py
  Using version: 2.7.5
  $ pyenv global 3.5.0
  $ pyenv exec python main.py
  Using version: 3.5.0
  $ pyenv local 2.7.11
  $ pyenv exec python main.py
  Using version: 2.7.11
  ```
  > Notice how `pyenv exec` python `main.py` uses our “global” Python version by default, but then it uses the “local” version after one is set for the current directory.
  >
  > This can be very powerful for developers who have lots of projects with varying version requirements. Not only can you easily change the default version for all projects (via `global`), but you can also override it to specify special cases.

Managing Multiple Python Versions With pyenv https://realpython.com/intro-to-pyenv/
- **Using Your New Python**
- > If you try to confirm this using which, you’ll see this:
  ```sh
  $ which python
  /home/realpython/.pyenv/shims/python
  ```
  > This might be surprising, but this is how `pyenv` works. `pyenv` inserts itself into your `PATH` and from your OS’s perspective is the executable that is getting called. If you want to see the actual path, you can run the following:
  ```sh
  $ pyenv which python
  /usr/bin/python
  ```
- > **Pro Tip**: A great way to get peace of mind that the version of Python you just installed is working properly is to run the built-in test suite:
  ```sh
  $ pyenv global 3.8-dev
  $ python -m test
  ```
- **Exploring `pyenv` Commands**
- **Specifying Your Python Version**
- **Virtual Environments and `pyenv`**
- **Working With Multiple Environments**
- > Putting everything you’ve learned together, you can work effectively with multiple environments. Let’s assume you have the following versions installed:
  ```sh
  $ pyenv versions
  * system (set by /home/realpython/.pyenv/version)
    2.7.15
    3.6.8
    3.8-dev
  ```
- > Now you want to work on two different, aptly named, projects:
  * > **project1** supports Python 2.7 and 3.6.
  * > **project2** supports Python 3.6 and experiments with 3.8-dev.
- > You can see that, by default, you are using the system Python, which is indicated by the `*` in the `pyenv versions` output. First, create a virtual environment for the first project:
  ```sh
  $ cd project1/
  $ pyenv which python
  /usr/bin/python
  $ pyenv virtualenv 3.6.8 project1
  ...
  $ pyenv local project1
  $ pyenv which python
  /home/realpython/.pyenv/versions/project1/bin/python
  ```
- > Finally, notice that when you `cd` out of the directory, you default back to the system Python:
  ```sh
  $ cd $HOME
  $ pyenv which python
  /usr/bin/python
  ```
- > You can follow the above steps and create a virtual environment for project2:
  ```sh
  $ cd project2/
  $ pyenv which python
  /usr/bin/python
  $ pyenv virtualenv 3.8-dev project2
  ...
  $ pyenv local 3.8-dev
  $ pyenv which python
  /home/realpython/.pyenv/versions/3.8-dev/bin/python
  ```
- > These are one time steps for your projects. Now, as you cd between the projects, your environments will automatically activate:
  ```sh
  $ cd project2/
  $ python -V
  Python 3.8.0a0
  $ cd ../project1
  $ python -V
  Python 3.6.8
  ```
  > No more remembering to activate environments: you can switch between all your projects, and `pyenv` will take care of automatically activating the correct Python versions and the correct virtual environments.
- **Activating Multiple Versions Simultaneously**

Managing Multiple Python Versions With pyenv https://realpython.com/intro-to-pyenv/

Python 3 Installation & Setup Guide https://realpython.com/installing-python/

# from 其他网站

从零开始，教你如何安装、配置 Python 开发环境 https://mp.weixin.qq.com/s/Mv4GJA433RP9bDKsigiyGg
- > **使用 `venv` 模块搭建虚拟环境**
  * > 一些第三方包如 `virtualenv`、 `pipenv` 等都可以用来创建虚拟环境，而 Python 从 3.3 版本之后，***自带了***可以用于创建虚拟环境的 `venv` 模块，十分方便。我们就以 `venv` 模块为例，来展示 Python 虚拟环境的用法。
