
# devtoolset + scl

Developer Toolset 7 by Software Collections https://www.softwarecollections.org/en/scls/rhscl/devtoolset-7/

CentOS/RHEL 开发环境之 devtoolset http://blog.fungo.me/2016/03/centos-development-env/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# apk (for [Alpine Linux](https://en.wikipedia.org/wiki/Alpine_Linux))

```
$ apk --help
apk-tools 2.10.3, compiled for x86_64.

Installing and removing packages:
  add       Add PACKAGEs to 'world' and install (or upgrade) them, while ensuring that all dependencies are met
  del       Remove PACKAGEs from 'world' and uninstall them

System maintenance:
  fix       Repair package or upgrade it without modifying main dependencies
  update    Update repository indexes from all remote repositories
  upgrade   Upgrade currently installed packages to match repositories
  cache     Download missing PACKAGEs to cache and/or delete unneeded files from cache

Querying information about packages:
  info      Give detailed information about PACKAGEs or repositories
  list      List packages by PATTERN and other criteria
  dot       Generate graphviz graphs
  policy    Show repository policy for packages

Repository maintenance:
  index     Create repository index file from FILEs
  fetch     Download PACKAGEs from global repositories to a local directory
  verify    Verify package integrity and signature
  manifest  Show checksums of package contents

Use apk <command> --help for command-specific help.
Use apk --help --verbose for a full command listing.

This apk has coffee making abilities.
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pacman (for [Arch Linux](https://en.wikipedia.org/wiki/Arch_Linux))

pacman (简体中文) https://wiki.archlinux.org/index.php/Pacman_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

# aurman (这个从github repo来看极其小众，本来官方的pacman就已经够小众，这个就更不用说了。)

```
//来源：https://github.com/zeit/hyper

Hyper is available in the AUR. Use an AUR package manager like aurman

aurman -S hyper
```

Package Details: aurman 2.19.1-1 https://aur.archlinux.org/packages/aurman/

aurman https://github.com/polygamma/aurman

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# pkg

**//又从[hub](https://github.com/github/hub)项目知道`FreeBSD`下的包管理工具`pkg`**。。。

The `hub` executable has no dependencies, but since it was designed to wrap
`git`, it's recommended to have at least **git 1.7.3** or newer.

platform | manager | command to run
---------|---------|---------------
macOS, Linux | [Homebrew](https://docs.brew.sh/Installation) | `brew install hub`
Windows | [Scoop](http://scoop.sh/) | `scoop install hub`
Windows | [Chocolatey](https://chocolatey.org/) | `choco install hub`
Fedora Linux | [DNF](https://fedoraproject.org/wiki/DNF) | `sudo dnf install hub`
Arch Linux | [pacman](https://wiki.archlinux.org/index.php/pacman) | `sudo pacman -S hub`
FreeBSD | [pkg(8)](http://man.freebsd.org/pkg/8) | `pkg install hub`
Debian | apt | `sudo apt install hub`
Ubuntu | [Snap](https://snapcraft.io) | `snap install hub --classic`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

Comparison of major Linux package management systems https://linuxconfig.org/comparison-of-major-linux-package-management-systems
- `aptitude`
- [Portage] (https://wiki.gentoo.org/wiki/Portage)
  * `emerge`

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Windows下包管理general

软件包管理工具选Scoop还是Chocolatey？看完这篇就知道了 https://www.cnbeta.com/articles/tech/874537.htm

Windows 系统的包管理器 https://davidsheh.github.io/2017/09/09/windows-chocolatey-scoop/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Chocolatey

About Chocolatey https://chocolatey.org/about
> "Chocolatey is a package manager for Windows (like apt-get or yum but for Windows). It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your door, err computer."
>> 非常巧合地发现了这个Windows下的包管理软件————因为偶然在看[TikZiT](https://github.com/tikzit/tikzit)的README.md，里面提到在Windows下装`flex/bison`的话可以用`WinFlexBison`或者用`Chocolatey`————不过回头有时间再试试好了。
>>> "In addition to Qt itself, TikZiT needs flex/bison, Poppler (with Qt bindings), and OpenSSL. For flex/bison, the simplest way to install this is to download WinFlexBison, then make sure both are in your %Path% so the build tools can find them. Altflex/bisonernatively, you can install it via Chocolatey, via: `choco install winflexbison`"

## Chocolatey安装个人实战

### 参考链接：

- Installing Chocolatey https://chocolatey.org/install
- PowerShell 脚本执行策略 https://www.cnblogs.com/sparkdev/p/7460518.html

### 主要步骤：

1. `Win+X` --> `Windows PowerShell (管理员)(A)`
2. 官网安装链接里的第二步“Install with powershell.exe”
  - With PowerShell, you must ensure `Get-ExecutionPolicy` is not Restricted. We suggest using `Bypass` to bypass the policy to get things installed or `AllSigned` for quite a bit more security.
  - Run `Get-ExecutionPolicy`. If it returns `Restricted`, then run `Set-ExecutionPolicy AllSigned` or `Set-ExecutionPolicy Bypass -Scope Process`.
  - Now run the following command:
    + `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
```powershell
Windows PowerShell
版权所有 (C) Microsoft Corporation。保留所有权利。

尝试新的跨平台 PowerShell https://aka.ms/pscore6

PS C:\WINDOWS\system32> Get-ExecutionPolicy
Restricted
PS C:\WINDOWS\system32> Set-ExecutionPolicy AllSigned

执行策略更改
执行策略可帮助你防止执行不信任的脚本。更改执行策略可能会产生安全风险，如 https:/go.microsoft.com/fwlink/?LinkID=135170
中的 about_Execution_Policies 帮助主题所述。是否要更改执行策略?
[Y] 是(Y)  [A] 全是(A)  [N] 否(N)  [L] 全否(L)  [S] 暂停(S)  [?] 帮助 (默认值为“N”): n
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32> Get-ExecutionPolicy
Restricted
PS C:\WINDOWS\system32> Set-ExecutionPolicy Bypass -Scope Process

执行策略更改
执行策略可帮助你防止执行不信任的脚本。更改执行策略可能会产生安全风险，如 https:/go.microsoft.com/fwlink/?LinkID=135170
中的 about_Execution_Policies 帮助主题所述。是否要更改执行策略?
[Y] 是(Y)  [A] 全是(A)  [N] 否(N)  [L] 全否(L)  [S] 暂停(S)  [?] 帮助 (默认值为“N”): n
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32> Get-ExecutionPolicy
Restricted
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32>


// 因为怕改错了啥，所以上面的两个语句`Set-ExecutionPolicy AllSigned`和`Set-ExecutionPolicy Bypass -Scope Process`
// 我都没执行- -后来查了下发现其实两个语句应该都还好，于是决定不执行它俩，而直接执行官网的
// 安装语句试试。结果直接就安装成功了。
PS C:\WINDOWS\system32> Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Getting latest version of the Chocolatey package for download.
Getting Chocolatey from https://chocolatey.org/api/v2/package/chocolatey/0.10.15.
Downloading 7-Zip commandline tool prior to extraction.
Extracting C:\Users\LiangLiu\AppData\Local\Temp\chocolatey\chocInstall\chocolatey.zip to C:\Users\LiangLiu\AppData\Local\Temp\chocolatey\chocInstall...
Installing chocolatey on this machine
Creating ChocolateyInstall as an environment variable (targeting 'Machine')
  Setting ChocolateyInstall to 'C:\ProgramData\chocolatey'
WARNING: It's very likely you will need to close and reopen your shell
  before you can use choco.
Restricting write permissions to Administrators
We are setting up the Chocolatey package repository.
The packages themselves go to 'C:\ProgramData\chocolatey\lib'
  (i.e. C:\ProgramData\chocolatey\lib\yourPackageName).
A shim file for the command line goes to 'C:\ProgramData\chocolatey\bin'
  and points to an executable in 'C:\ProgramData\chocolatey\lib\yourPackageName'.

Creating Chocolatey folders if they do not already exist.

WARNING: You can safely ignore errors related to missing log files when
  upgrading from a version of Chocolatey less than 0.9.9.
  'Batch file could not be found' is also safe to ignore.
  'The system cannot find the file specified' - also safe.
chocolatey.nupkg file not installed in lib.
 Attempting to locate it from bootstrapper.
PATH environment variable does not have C:\ProgramData\chocolatey\bin in it. Adding...
警告: Not setting tab completion: Profile file does not exist at
'C:\Users\LiangLiu\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
Chocolatey (choco.exe) is now ready.
You can call choco from anywhere, command line or powershell by typing choco.
Run choco /? for a list of functions.
You may need to shut down and restart powershell and/or consoles
 first prior to using choco.
Ensuring chocolatey commands are on the path
Ensuring chocolatey.nupkg is in the lib folder
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32> choco -v
0.10.15
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Scoop

「一行代码」搞定软件安装卸载，用 Scoop 管理你的 Windows 软件 https://sspai.com/post/52496

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GoFish

```
//来源：https://github.com/helm/helm -- Install

If you want to use a package manager:
  - Homebrew users can use brew install kubernetes-helm.
  - Chocolatey users can use choco install kubernetes-helm.
  - Scoop users can use scoop install helm.
  - GoFish users can use gofish install helm.
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Snappy

```
//来源：https://helm.sh/docs/using_helm/ -- INSTALLING THE HELM CLIENT -- From Snap (Linux)
//忍不住吐个槽，这个Helm花样还挺多的，并且和包管理杠上了。。。自己就是个“包管理”（只不过是k8s平台的包管理）
//    软件，然后还可以通过一堆各种各样的包管理软件来装。。。

The Snap package for Helm is maintained by Snapcrafters.
$ sudo snap install helm --classic
```

Snappy (package manager) https://en.wikipedia.org/wiki/Snappy_(package_manager)

Snapcraft: The app store for Linux - Publish your app for Linux users — for desktop, cloud, and Internet of Things. https://snapcraft.io/

Installing snapd https://snapcraft.io/docs/installing-snapd

使用 Snapcraft 构建、测试并发布 Snap 软件包 https://linux.cn/article-8788-1.html

What is the classic mode of snap, and why do some snaps not install without it (e.g. MS Visual Studio)? https://askubuntu.com/questions/917049/what-is-the-classic-mode-of-snap-and-why-do-some-snaps-not-install-without-it

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vcpkg

C++ Library Manager for Windows, Linux, and MacOS https://github.com/microsoft/vcpkg

如何看待 Windows 的 C++ 包管理器 vcpkg？ - 知乎 https://www.zhihu.com/question/263416411

## 其他C/CPP包管理工具

C++ 有没有像 pip、npm、gem 一样的包管理工具？ - 知乎 https://www.zhihu.com/question/26117075
- > linux的包管理工具，比如ubuntu 的apt-get , centos的yum, opensuse的zypper, 其实很大意义上就是c/c++的包管理工具。各种lib header dev包可以通过其安装的
- > 最近发现一个c++包管理工具: Conan. 
  * > Conan - The open-source C/C++ package manager https://github.com/conan-io/conan
- > 补充一下，用Visual Studio的话，有NuGet。
- > xmake v2.2.2, 让C/C++拥有包依赖自动构建 可以看下这个，xmake内置c/c++包管理和跨平台构建了

# pip, pipenv and others

Python包管理器-pip https://juejin.im/post/5beb92e7e51d454fbd6b4bc4

最全的 pip 使用指南，50% 你可能没用过 https://juejin.im/post/5dc2bdabf265da4d4216bd29

Pipenv – 超好用的 Python 包管理工具 https://juejin.im/post/5b31ba8851882574e808e555

如何安装PIP来管理Linux中的Python包 https://www.howtoing.com/install-pip-in-linux/
```sh
在openSUSE上安装PIP

# zypper install python-pip	  #Python 2
# zypper install python3-pip	#Python 3
```
>> 类似net-tools。。。不能直接`XXX install pip`。。。
