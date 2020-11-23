
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
  ```py
  $ pip install virtualenv
  ```
- > Start by making a new directory to work with:
  ```py
  $ mkdir python-virtual-environments && cd python-virtual-environments
  ```
- > Create a new virtual environment inside the directory:
  ```py
  # Python 2:
  $ virtualenv env
  
  # Python 3
  $ python3 -m venv env
  ```
- **How Does a Virtual Environment Work?**
- > To explain how this works, let’s first check out the locations of the different python executables. With the environment “deactivated,” run the following:
  ```py
  $ which python
  /usr/bin/python
  ```
- > Now, activate it and run the command again:
  ```py
  $ source env/bin/activate
  (env) $ which python
  /Users/michaelherman/python-virtual-environments/env/bin/python
  ```
- > Notice the difference between the first path in $PATH before and after the activation:
  ```py
  $ echo $PATH
  /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:
  
  $ source env/bin/activate
  (env) $ echo $PATH
  /Users/michaelherman/python-virtual-environments/env/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:
  ```
- **Managing Virtual Environments With virtualenvwrapper**
- **Using Different Versions of Python**

Managing Multiple Python Versions With pyenv https://realpython.com/intro-to-pyenv/

Python 3 Installation & Setup Guide https://realpython.com/installing-python/
