
# 官方

- Installing on Windows https://docs.anaconda.com/anaconda/install/windows/
- Installing on Linux https://docs.anaconda.com/anaconda/install/linux/

Frequently asked questions https://docs.anaconda.com/anaconda/user-guide/faq/
- > **In what folder should I install Anaconda on Windows?**
  * > We recommend installing Anaconda or Miniconda into a directory that contains ***only 7-bit ASCII characters and no spaces***, such as `C:\anaconda`. Do <ins>***not install into paths that contain spaces***</ins> such as `C:\Program Files` or that <ins>***include Unicode characters outside the 7-bit ASCII character set***</ins>. This helps ensure correct operation and no errors when using any open-source tools in either Python 3 or Python 2 conda environments.
- > **Should I add Anaconda to the Windows `PATH`?**
  * > When installing Anaconda, we recommend that you ***do not add Anaconda to the `Windows PATH`*** because this can interfere with other software. Instead, open Anaconda with the `Start Menu` and select `Anaconda Prompt`, or use `Anaconda Navigator` (`Start Menu` - `Anaconda Navigator`).
- > **Should I add Anaconda to the macOS or Linux `PATH`?**
  * > We do not recommend adding Anaconda to the PATH ***manually***. During installation, you will be asked “Do you wish the installer to initialize Anaconda3 by running conda init?” ***We recommend “yes”***. If you enter “no”, then conda will not modify your shell scripts at all. In order to initialize after the installation process is done, first run `source <path to conda>/bin/activate` and then run `conda init`.
  * > Note: Replace `<path-to-anaconda>` with the actual path of your installed Anaconda file.
- > **What is the default path for installing Anaconda?**
  * > If you accept the default option to install Anaconda on the “default path” Anaconda is installed in your user home directory:
    ```console
    Windows 10: C:\Users\<your-username>\Anaconda3\
    macOS: /Users/<your-username>/anaconda3 for the shell install, ~/opt for the graphical install. See installing on macOS.
    Linux: /home/<your-username>/anaconda3
    ```
  * > Note: If your username includes spaces, as is common on Windows systems, you should not accept the default path. See "[In what folder should I install Anaconda on Windows?]()"

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Anaconda general

http://python.jobbole.com/tag/anaconda/
- Anaconda使用总结 http://python.jobbole.com/86236/
- 致Python初学者：Anaconda入门使用指南 http://python.jobbole.com/87522/

<<Anaconda修改国内镜像源>> https://jingyan.baidu.com/article/1876c8527be1c3890a137645.html

<<清华大学开源软件镜像站 - Anaconda>> https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Anaconda问题解决

anaconda没有创建启动快捷方式的解决办法 http://blog.csdn.net/w371500241/article/details/78582403

Python，Pycharm，Anaconda等的关系与安装过程~为初学者跳过各种坑 https://www.cnblogs.com/tq007/p/7281105.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Anaconda安装使用

<<Anaconda介绍、安装及使用教程>> https://zhuanlan.zhihu.com/p/32925500
> 7. 在“Advanced Installation Options”中不要勾选“Add Anaconda to my PATH environment variable.”（“添加Anaconda至我的环境变量。”）。因为如果勾选，则将会影响其他程序的使用。如果使用Anaconda，则通过打开Anaconda Navigator或者在开始菜单中的“Anaconda Prompt”（类似macOS中的“终端”）中进行使用。
>> //notes：补：其实现在想想，也不一定。有的人就推荐勾选这个选项。因为不勾选这个的话，Window下的cmd命令行都没法直接用conda（除非自己配一下）。——当然，**总体还是推荐不勾选的**！因为 ***官方也是这么说的***
>>> https://docs.anaconda.com/anaconda/install/windows/
>>>> 【[:star:][`*`]】 `8. Choose whether to add Anaconda to your PATH environment variable. We recommend not adding Anaconda to the PATH environment variable, since this can interfere with other software. Instead, use Anaconda software by opening Anaconda Navigator or the Anaconda Prompt from the Start Menu.`
>>>>> 另外所谓配置方法其实也就是加Anaconda相关目录到环境变量，主要是如下三个目录`xxx\Anaconda3`、`xxx\Anaconda3\Scripts`、`xxx\Anaconda3\Library\bin`：
```console
C:\Users\<your_windows_username>\Anaconda3
C:\Users\<your_windows_username>\Anaconda3\Scripts
C:\Users\<your_windows_username>\Anaconda3\Library\bin
```

如何在多版本anaconda python环境下转换spyder？ - 知乎 https://www.zhihu.com/question/49144687
- 如何在多版本anaconda python环境下转换spyder？ - 王浩的回答 - 知乎 https://www.zhihu.com/question/49144687/answer/165033340
- 如何在多版本anaconda python环境下转换spyder？ - 知乎 https://www.zhihu.com/question/49144687/answer/192694255

How To Install the Anaconda Python Distribution on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-the-anaconda-python-distribution-on-debian-9 || 如何在Debian 9上安装Anaconda Python发行版 https://cloud.tencent.com/developer/article/1360739
- > **Installing Anaconda**
  * > The best way to install Anaconda is to download the latest ***Anaconda installer bash script***, verify it, and then run it.
  * > Find the latest version of Anaconda for Python 3 at the **Downloads page** accessible via the [Anaconda home page](https://www.anaconda.com/). At the time of writing, the latest version is 5.2, but you should use a later stable version if it is available.
    ```sh
    cd /tmp
    sudo apt install curl
    curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
    bash Anaconda3-5.2.0-Linux-x86_64.sh
    ```
    ```sh
    # 个人实战用的语句也差不多：
    mkdir packages && cd packages/
    wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
    bash Anaconda3-2021.05-Linux-x86_64.sh
    
    # 此外，虽然官方推荐 Linux 环境下自动让 anaconda 改 PATH，但是还是选了 no，
    # 然后自己手动把 /home/<your_user_name>/anaconda3/bin 添加到了 PATH，感觉这样灵活性更高。
    
    # 这句添加进 ~/.bashrc
    export PATH=$PATH:/home/<your_user_name>/anaconda3/bin
    # 想切换的时候必须先额外执行这个才能让命令行前面有 anaconda 的环境名字
    source ~/anaconda3/bin/activate
        
    # 然后就可以自由切换环境了，比如 root 用户下过程是这样的（注意命令提示符的变化）：
    $ source /root/anaconda3/bin/activate
    (base) $ 
    (base) $ conda activate py2
    (py2) $ 
    (py2) $ conda deactivate
    (base) $ conda deactivate
    $     
    ```
    >> //notes：安装过程中有一步还是比较关键的，就是要把 `conda` 添加到 `PATH`（如果window，官方推荐是***不添加***；Linux和MAC，官方推荐的是***添加***，但是***不要手动添加***。并且官方给出了在这一步万一因为填错或者因为超时自动填 `no` 时的解决办法，参见官方FAQ部分吧）
- > **Updating Anaconda**
  * > You should regularly ensure that Anaconda is up-to-date so that you are working with all the latest package releases. To do this, you should first update the conda utility:
    ```console
    conda update conda
    ```
    > When prompted to do so, type `y` to proceed with the update.
  * > Once the update of conda is complete, you can update the Anaconda distribution:
    ```console
    conda update anaconda
    ```
    > Again when prompted to do so, type `y` to proceed. This will ensure that you are using the latest releases of conda and Anaconda.
- > **Uninstalling Anaconda**
  * > If you are no longer using Anaconda and find that you need to uninstall it, you should start with the `anaconda-clean` module, which will remove configuration files for when you uninstall Anaconda.
    ```console
    conda install anaconda-clean
    ```
    > Type `y` when prompted to do so.
  * > Once it is installed, you can run the following command. You will be prompted to answer `y` before deleting each one. If you would prefer not to be prompted, add `--yes` to the end of your command:
    ```console
    anaconda-clean
    ```
    > This will also create a backup folder called `.anaconda_backup` in your home directory:
    ```console
    Output
    Backup directory: /home/sammy/.anaconda_backup/2018-09-06T183049
    ```
  * > You can now remove your entire Anaconda directory by entering the following command:
    ```sh
    rm -rf ~/anaconda3
    ```
  * > Finally, you can remove the `PATH` line from your `.bashrc` file that Anaconda added. To do so, first open a text editor such as `nano`:
    ```sh
    nano ~/.bashrc
    ```
    > Then scroll down to the end of the file (if this is a recent install) or type `CTRL + W` to search for Anaconda. Delete or comment out the `export PATH` line:
    ```sh
    # /home/sammy/.bashrc
    
    ...
    ...
    ...
    # added by Anaconda3 installer
    export PATH="/home/sammy/anaconda3/bin:$PATH"
    ```
    > When you’re done editing the file, type `CTRL + X` to exit and `y` to save changes.
  * > Anaconda is now removed from your server.

## old

<<Pycharm，Anaconda的安装，集成开发环境，包安装>> https://www.jianshu.com/p/98b2fbb3a45c

<<python 科学计算 发行版 Anaconda安装使用教程>> http://blog.csdn.net/bitcarmanlee/article/details/51917642

<<最省心的Python版本和第三方库管理——初探Anaconda>> https://zhuanlan.zhihu.com/p/25198543

<<python anaconda 怎么安装？>> https://www.zhihu.com/question/30123965 

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Anaconda常用语句

Managing environments https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html

```sh
# 环境管理
conda create -n <your_env_name> python=3.6  # 例：conda create -n py27 python=2.7 // -n 等于 --name
conda env remove -n <your_env_name>  # 例：conda env remove --name bio-env // 等于 conda remove -n bio-env --all
conda env list
conda info --envs  # 似乎等于上面那个语句，反正差不多吧
conda info -e  # 也等于上面那句
conda activate <your_env_name>
conda deactivate

# 包管理
conda list  # 查看（当前环境里）已经安装的包
conda list -n <your_env_name>  # 查看某个环境里已经安装的包
conda install <package_name>  # 在当前环境中安装某个包
conda install --name <your_env_name> <package_name>  # 在指定环境中安装某个包
conda remove <package_name>  # 删除当前环境中的某个包
conda remove -n <your_env_name> <package1> <package2>  # 例：conda remove --name bio-env toolz boltons
conda remove -n <your_env_name> --all  # 例：conda remove -n bio-env --all // 这句会直接把这个虚环境给删掉，等于前面的 conda env remove --name bio-env
```

anaconda修改国内源 https://www.cnblogs.com/yuvejxke/p/13169172.html

conda国内镜像修改（最新版） - Python与算法社区的文章 - 知乎 https://zhuanlan.zhihu.com/p/95100538

```
# 添加国内源（以中科大源为例）

(base) C:\Users\LiangLiu>conda config --show channels
channels:
  - defaults

(base) C:\Users\LiangLiu>conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
(base) C:\Users\LiangLiu>
(base) C:\Users\LiangLiu>conda config --show channels
channels:
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
  - defaults

```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
