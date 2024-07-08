
收集下各位 Linux 下所使用的那些好用的工具 https://www.v2ex.com/t/1055592
```console
我目前已经记录的有：

ag: 文件内容搜索
axel：多线程下载
inxi： 硬件查看神器
asciinema： 终端记录神器
dbcli：数据库命令客户端，可以实现自动命令不全，仓库包含 mycli、pgcli 、litecli
sysdig: 系统性能监控和故障诊断工具
```
- > https://kkovacs.eu/cool-but-obscure-unix-tools/
- > https://github.com/agarrharr/awesome-cli-apps  `vim/neovim/yazi/zoxide/lazygit/fzf/bat/ripgrep/btop/hyperfine/hexyl/fd`
- > https://github.com/ibraheemdev/modern-unix

Linux 下有没有简单的可视化工具？ https://www.v2ex.com/t/864318
- > https://github.com/aristocratos/btop
  >> NIUBILITY ，好像就是我要找的东西！！！
- > htop ，bashtop ，各种 top
- > htop <br> s-tui https://github.com/amanusk/s-tui

# Windows tools

Windows 上有哪些实用的小工具？ https://www.v2ex.com/t/916516

# 开发环境配置

有没有什么思路可以实现自动配置开发环境 https://www.v2ex.com/t/1029392
- > 我是写了个 bash script 丢在 gcs 上 适配常用的 macOS 和 ubuntu 系统 每台新的机器只要运行一下然后等就行 `bash -c "$(wget -qLO - xxxxx)"`
  >> 那如果是 windows 呢，安装包这种怎么处理， 方便分享一些代码吗， 学习下思路
  >>> windows 用 wsl2+wslg ，创建好环境后把 vhdx 复制出来就能到处用了
- > 用 docker 把基础镜像都构建好呢，***到时候 volume 代码进去***，直接启动
- > nix
- > PowerShell + WinGet <br> WinGet Configure （我没用过） <br> Docker + Dev Container + VSCode
- > https://docs.github.com/zh/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers <br> https://code.visualstudio.com/docs/devcontainers/create-dev-container
- > nix,全环境直接生成
- > dev container
- > https://github.com/version-fox/vfox <br> win 可以用 vfox，其它系统可以用 nix，不过要是想一键搭建 docker 是最方便的
- > 你是否在找 mise https://github.com/jdx/mise 及 direnv https://github.com/direnv/direnv 上述两者可以做到设置 文件夹级别 的开发环境及环境变量
- > 有一个新出的工具，vfox 跨平台的兼容 linux windows ，刚切过来，感觉还不错 https://vfox.lhan.me/
