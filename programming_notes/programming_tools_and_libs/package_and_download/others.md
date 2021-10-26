
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

Windows统一开发环境的基础-Chocolatey - 陈龙的文章 - 知乎 https://zhuanlan.zhihu.com/p/53421288
- > 文件名称随意，但是扩展名必须是.config。通过.config的方式，就可以配置一个团队统一的开发环境，软件和版本都可以统一。这样可以为开发带来很多好处，避免由于开发环境不一样引起的各种不同错误。
- > 通过传统方式安装软件，如果配置了环境变量，例如JAVA_HOME,PATH等等，都需要重启命令行工具，甚至要等一会才能生效。Chocolatey提供了一个refreshenv命令，可以快速生效环境变量。
  >> // notes：这个我记得windows也有吧。。。我在windows_related.md里总结过。
- > 评论区很多人提到scoop，并且很多反应Chocolatey无法修改安装路径。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Chocolatey

About Chocolatey https://chocolatey.org/about
> "Chocolatey is a package manager for Windows (like apt-get or yum but for Windows). It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your door, err computer."
>> 非常巧合地发现了这个Windows下的包管理软件————因为偶然在看[TikZiT](https://github.com/tikzit/tikzit)的README.md，里面提到在Windows下装`flex/bison`的话可以用`WinFlexBison`或者用`Chocolatey`————不过回头有时间再试试好了。
>>> "In addition to Qt itself, TikZiT needs flex/bison, Poppler (with Qt bindings), and OpenSSL. For flex/bison, the simplest way to install this is to download WinFlexBison, then make sure both are in your %Path% so the build tools can find them. Altflex/bisonernatively, you can install it via Chocolatey, via: `choco install winflexbison`"

## Chocolatey常用命令总结

```powershell
choco search <package_name>

# 类似Linux下的包管理，也可以加上 -y 免得需要确认
choco install <package_name> --version <version_number>

choco list --local-only
```

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

## Chocolatey使用个人实战

>> notes：本来就想借着在windows上安装node.js的契机试试Chocolatey，结果最后的结果有点醉：说没安装成功吧，windows上有node.js了，用`choco list --local-only`也看到node.js了。但是安装过程中确实也报错了。。。
>>> 呃，写完上面那段又仔细瞅了一眼，明白了：是我冤枉了Chocolatey。我那个安装语句`choco install nodejs-lts 12.16.3`，它把`12.16.3`直接当成另外一个软件包了。。。

```powershell
Windows PowerShell
版权所有 (C) Microsoft Corporation。保留所有权利。

尝试新的跨平台 PowerShell https://aka.ms/pscore6

PS C:\WINDOWS\system32> choco search node.js
Chocolatey v0.10.15
nodejs-lts 12.16.3 [Approved]
nodejs 14.3.0 [Approved]
visualstudio2019-workload-node 1.0.0 [Approved]
visualstudio2017-workload-node 1.2.2 [Approved]
visualstudio2017-workload-nodebuildtools 1.0.1 [Approved]
visualstudio2019-workload-nodebuildtools 1.0.0 [Approved]
nodejs.install 14.3.0 [Approved]
nvm 1.1.5 [Approved]
nvm.portable 1.1.7 [Approved] Downloads cached for licensed users
LightTable 0.8.1 [Approved] Downloads cached for licensed users
nodejs.commandline 6.11.0 [Approved]
nodist 0.9.1 [Approved]
gnvm 0.2.0 [Approved] Downloads cached for licensed users
flattenpackages 1.1.14 [Approved] Downloads cached for licensed users
markdownlint-cli 0.23.1 [Approved]
bower 1.8.8 [Approved]
typescript 3.9.3 [Approved]
balena-cli 11.35.5 [Approved]
konversation 1.1.0 [Approved]
gulp-cli 2.2.1 [Approved]
heroku-cli 7.41.1.0 [Approved]
etcher 1.5.91 [Approved] Downloads cached for licensed users
picassio 0.12.0 [Approved] Downloads cached for licensed users
hyperspace-desktop 1.1.0 [Approved] Downloads cached for licensed users
vscodium.portable 1.45.1 [Approved] Downloads cached for licensed users
RubyMine 2020.1.1 [Approved] Downloads cached for licensed users
vscodium 1.45.1 [Approved]
vscodium.install 1.45.1 [Approved]
28 packages found.
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32> choco install nodejs-lts 12.16.3
Chocolatey v0.10.15
Installing the following packages:
nodejs-lts;12.16.3
By installing you accept licenses for the packages.
Progress: Downloading nodejs-lts 12.16.3... 100%

nodejs-lts v12.16.3 [Approved]
nodejs-lts package files install completed. Performing other installation steps.
The package nodejs-lts wants to run 'chocolateyinstall.ps1'.
Note: If you don't run this script, the installation will fail.
Note: To confirm automatically next time, use '-y' or consider:
choco feature enable -n allowGlobalConfirmation
Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint): y

Installing 64 bit version
Installing nodejs-lts...
nodejs-lts has been installed.
  nodejs-lts may be able to be automatically uninstalled.
Environment Vars (like PATH) have changed. Close/reopen your shell to
 see the changes (or in powershell/cmd.exe just type `refreshenv`).
 The install of nodejs-lts was successful.
  Software installed as 'MSI', install location is likely default.
12.16.3 not installed. The package was not found with the source(s) listed.
 Source(s): 'https://chocolatey.org/api/v2/'
 NOTE: When you specify explicit sources, it overrides default sources.
If the package version is a prerelease and you didn't specify `--pre`,
 the package may not be found.
Please see https://chocolatey.org/docs/troubleshooting for more
 assistance.

Chocolatey installed 1/2 packages. 1 packages failed.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Failures
 - 12.16.3 - 12.16.3 not installed. The package was not found with the source(s) listed.
 Source(s): 'https://chocolatey.org/api/v2/'
 NOTE: When you specify explicit sources, it overrides default sources.
If the package version is a prerelease and you didn't specify `--pre`,
 the package may not be found.
Please see https://chocolatey.org/docs/troubleshooting for more
 assistance.

Did you know the proceeds of Pro (and some proceeds from other
 licensed editions) go into bettering the community infrastructure?
 Your support ensures an active community, keeps Chocolatey tip top,
 plus it nets you some awesome features!
 https://chocolatey.org/compare
PS C:\WINDOWS\system32>
PS C:\WINDOWS\system32> choco list --local-only
Chocolatey v0.10.15
chocolatey 0.10.15
nodejs-lts 12.16.3
2 packages installed.
PS C:\WINDOWS\system32>
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

Permission denied error when running apps installed as snap packages - Ubuntu 17.04 https://askubuntu.com/questions/930437/permission-denied-error-when-running-apps-installed-as-snap-packages-ubuntu-17
- > Same happens in Ubuntu 18.04. If the user home directory is not under the `/home` (or `/`) mount, it not possible to work with snap. My HOMEDIR was on another local SSD disk, but since it was not mounted under `/home`, every package installed by snap was failing.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他C/CPP包管理工具

C++ 有没有像 pip、npm、gem 一样的包管理工具？ - 知乎 https://www.zhihu.com/question/26117075
- > linux的包管理工具，比如ubuntu 的apt-get , centos的yum, opensuse的zypper, 其实很大意义上就是c/c++的包管理工具。各种lib header dev包可以通过其安装的
- > 最近发现一个c++包管理工具: Conan. 
  * > Conan - The open-source C/C++ package manager https://github.com/conan-io/conan
- > 补充一下，用Visual Studio的话，有NuGet。
- > xmake v2.2.2, 让C/C++拥有包依赖自动构建 可以看下这个，xmake内置c/c++包管理和跨平台构建了
