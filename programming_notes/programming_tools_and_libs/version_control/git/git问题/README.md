
# `fatal: detected dubious ownership in repository at '/githubs/libsnark-playground'`

## 问题原因和症状

容器里挂载某个宿主机上的git目录时，一旦执行git相关命令就会提示下面的错误：
```console
# git status
fatal: detected dubious ownership in repository at '/githubs/libsnark-playground'
To add an exception for this directory, call:

	git config --global --add safe.directory /githubs/libsnark-playground
```
最简单的解决方法就是 `git config --global safe.directory '*'`，参见这个帖子（[How to correct `git` reporting `detected dubious ownership in repository` without adding `safe.directory` when using WSL?](https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou/73488472#73488472)）的回答。也可更改git仓库的所有者，但是不如这种一句命令的方式方便。

How to correct `git` reporting `detected dubious ownership in repository` without adding `safe.directory` when using WSL? https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou

git fatal: detected dubious ownership in repository 解决方法 https://blog.csdn.net/tcjy1000/article/details/127129224
