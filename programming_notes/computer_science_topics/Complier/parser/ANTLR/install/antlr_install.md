
# 新方式（快速方便）

antlr4-tools https://github.com/antlr/antlr4-tools
- > ***Tools to run antlr4 w/o needing to install java or antlr4! The only requirement is Python3***, which is typically installed on all developer machines on all operating systems.
- > **Install**
  ```sh
  $ pip install antlr4-tools
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 旧方式（不够快速，但是生产环境应该还是要用这种）

Getting Started with ANTLR v4 https://github.com/antlr/antlr4/blob/master/doc/getting-started.md
- > **Installation**
  * > **UNIX**
    ```sh
    # 0.Install Java (version 1.7 or higher)
    cd /usr/local/lib
    curl -O https://www.antlr.org/download/antlr-4.9-complete.jar
    export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"
    alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
    alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 纯Python使用的话可以 anaconda 下直接用命令装

antlr4-python3-runtime https://anaconda.org/conda-forge/antlr4-python3-runtime
- > To install this package with conda run one of the following:
  ```sh
  conda install -c conda-forge antlr4-python3-runtime
  conda install -c conda-forge/label/broken antlr4-python3-runtime
  ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
