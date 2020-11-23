
Python Virtual Environments: A Primer https://realpython.com/python-virtual-environments-a-primer/
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

Managing Multiple Python Versions With pyenv https://realpython.com/intro-to-pyenv/

Python 3 Installation & Setup Guide https://realpython.com/installing-python/
