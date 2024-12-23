
# 官方

git-clone - Clone a repository into a new directory https://git-scm.com/docs/git-clone

git-clone - 克隆一个仓库到新目录 https://git-scm.com/docs/git-clone/zh_HANS-CN

# 参数解析

## `--depth <depth>`
> Create a shallow clone with a history truncated to the specified number of commits. Implies `--single-branch` unless `--no-single-branch` is given to fetch the histories near the tips of all branches. If you want to clone submodules shallowly, also pass `--shallow-submodules`.

***最常见的用法（尤其是仓库比较大的时候）***：
```bash
# 首先进行浅克隆，只克隆最近的一些提交
git clone --depth=1 <repository_url>
# 然后进行全量克隆
cd <repository_directory>
git fetch --unshallow
```

# 问题


