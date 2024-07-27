
# Nix 官方

Nix https://github.com/NixOS/nix

Nix https://nixos.org/
- > **Examples**
- > How Nix Works https://nixos.org/guides/how-nix-works/

# Nix 官方文档

nix.dev https://nix.dev/reference/nix-manual.html

NixOS 中文 https://nixos-cn.org/manual/

# Nix wiki

NixOS Wiki https://nixos.wiki/wiki/

Nix (package manager) https://en.wikipedia.org/wiki/Nix_(package_manager)

# Nix 其他

我的一些 nix 学习经验：安装和打包 https://linux.cn/article-16332-1.html

Nix 与 NixOS 简介 https://nixos-and-flakes.thiscute.world/zh/introduction/
- > 好几年前就听说过 Nix 包管理器，它用 Nix 语言编写配置来管理系统依赖，此外基于 Nix 包管理器设计的 Linux 发行版 NixOS，还能随时将系统回滚到任一历史状态（额实际上这个回滚有些限制，前面提过了）。 虽然听着很牛，但是不仅要多学一门语言，装个包还得写代码，当时觉得太麻烦就没研究。
- > 但是我最近在使用 EndeavourOS 时遇到了一系列麻烦事儿，花了大量的精力去解决，搞得我精疲力尽。我仔细一想，遇到的这些问题归根结底还是系统没有版本控制跟回滚机制，导致出了问题不能还原，就必须得各种查资料找 Bug，手动修复系统状态。
- > 所以我就决定干脆换成 NixOS.
- > 切换到 NixOS 后，我对它那是相当的满意，腰也不疼了，背也不酸了... 最惊艳的是，现在我可以通过仅仅一行命令（sudo nixos-rebuild switch --flake .），就能在一台全新安装的 NixOS 主机上还原我的整个 i3 桌面环境以及所有我的常用软件！
- > NixOS 的回滚能力与可复现能力给了我非常大的底气，我现在再也不用怕把系统搞挂了（挂了直接回滚就恢复了），于是我又在 NixOS 尝试了 Hyprland, Waybar 等等许多新鲜玩意儿~ 在以前 EndeavourOS 上我肯定是不太敢这么玩的，因为万一要是把系统玩出毛病了，就必须手动排查问题、修复系统状态，那可是相当麻烦。
- > 随着我对 NixOS 与 Nix 的使用越来越深入，我发现它还非常适合用于同步管理多台主机的配置。目前我的个人配置 [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config) 同步管理了许多主机的配置：
