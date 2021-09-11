
# `pyenv`

有不少内容在 [《CentOS环境搭建》](../../../../../../tech_essay/practice_CentOS下基础开发环境搭建.md) 和 [《Ubuntu环境搭建》](../../../../../../tech_essay/Ubuntu基础开发环境.md) 那里，目前还不知道怎么整理。

# `pyenv-virtualenv`

pyenv-virtualenv https://github.com/pyenv/pyenv-virtualenv

README.md https://github.com/pyenv/pyenv-virtualenv/blob/582b693c112ba2ab450228f84831a3d206b00d7a/README.md
- > **Installation**
  * > This will install the latest development version of pyenv-virtualenv into the `$(pyenv root)/plugins/pyenv-virtualenv` directory.  
  * > (OPTIONAL) **Add pyenv virtualenv-init to your shell** to enable auto-activation of virtualenvs. This is entirely optional but pretty useful. See "Activate virtualenv" below.
    ```sh
    $ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    ```
    > Restart your shell to enable pyenv-virtualenv
    ```sh
    $ exec "$SHELL"
    ```
- > **Usage**
  * > virtualenv and venv
    + > There is a [venv](https://docs.python.org/3/library/venv.html) module available for CPython 3.3 and newer. It provides an executable module `venv` which is ***the successor of*** `virtualenv` and distributed by default.
    + > `pyenv-virtualenv` uses `python -m venv` if it is available and the `virtualenv` command is not available.
