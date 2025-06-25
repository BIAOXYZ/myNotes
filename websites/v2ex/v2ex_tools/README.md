
推荐一下大伙用过的免费好用的服务 https://www.v2ex.com/t/1140599
```console
Github Pages：免费托管静态网站
Cloudflare CDN：免费 CDN 服务
Cloudflare Pages：免费托管静态网站
Cloudflare R2：对象存储服务，免费 10GB 存储
Vercel：支持 Serverless Functions ，尤其是跟 Next.js 配合更是天衣无缝，可以免费实现一些动态服务
Supabase：免费一个 PostgreSQL 数据库
ClawCloud：容器云平台，每月免费 5$
```
- > 昨天刚找到一个免费资源的项目分享. https://mp.weixin.qq.com/s/QEPwV_Gupis2Yhw4I_qZ_Q
- > 腾讯出的 cnb.cool 挺不错的，最近小 Demo 都用它那个在线 IDE （ VSCode ）
- > https://github.com/ripienaar/free-for-dev

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

[CodeGraph] 这样的代码可视化插件, 是你想要的吗? https://www.v2ex.com/t/1062942
```console
不知道大家在看代码的时候是否有过这样的困扰?

看代码的时候忘记从哪里跳转过来的? 也不知道看了哪些部分? 需要反反复复倒退几遍才能有点印象
分析复杂函数时, 需要仔细浏览一遍代码才能找到关键调用链路?
当查看方法被哪些函数调用时, 好不容易把所有调用关系点了一遍, 发现还是脑子很乱, 还得再来一遍?

为了解决上述这些困扰, 我开发了一款名为 code graph 的 jetbrains 插件, 可以实现将代码之间的调用关系可视化, 帮助我们更快更简单的阅读和理解代码.

安装
在 Intellij IDEA 的插件市场搜索 “CodeGraph” 即可安装 注意：目前仅支持 2022.3 及之后的版本

用法
找到需要生成调用关系图的方法, 点击鼠标右键, 选择 "Code Graph / Show Callee Graph For 'xxx'".
```
- > 这个说白了就是 idea 的 hierarchy 可视化了。其实直接用 ctrl+alt+H 打开 hierarchy 效果也差不多。建议一个我个人觉得有用的功能，支持隐藏某些方法（右键-隐藏），因为很多方法并不是很重要。隐藏了之后把主链路的方法调用导出，可以作为文章的配图

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

# 性能测试

Linux 下测试硬件稳定性有什么软件推荐？ https://www.v2ex.com/t/1079487
- > `stress-ng`, `fio`, `memtester`, `gpu-burn`
