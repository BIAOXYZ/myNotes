
Developing inside a Container https://code.visualstudio.com/docs/remote/containers

# 个人总结1

***两个关键插件***：
- `【1】` Remote - Containers https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
- `【2】` Docker https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
- 补充：`【1】`肯定装在vsc的本地插件部分；`【2】`也是在vsc的本地插件部分装的，但是似乎远程也可以直接用。不过无所谓，到时候如果不行就都本地、远程都装一下。

一般意义上认为：`【1】`是关键插件，因为`【1】`其实就是 [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) 的容器版本。而`【2】`只是个方便写Dockerfile的插件而已，在检测到你正在vsc里编写Dockerfile时会弹出提示问你安装不安装，安装了写Dockerfile有高亮之类的，方便一些。但是我偶然间发现，`【1】`和`【2】`结合能达到更强大的效果！

***场景如下***：只有本地（Mac或Windows）有图形界面，所以只有本地安装了vsc。然后有一台远程的Linux做开发机器。代码仓库在远程Linux机器上。

## 仅使用`【1】`来实现标准功能：本地vsc连接本地container

如果这里用的插件是 [Remote - SSH]()，那啥也不用说了，就是vs code远程开发最基本的做法。

如果是用 [Remote - Containers]()，那么注意：***实际上这里还不涉及那台Linux机器***。在本地打包好开发环境相关的镜像（镜像里一定要有各种依赖，但是对于代码仓库本身来说，可以打进镜像里也可以不包含代码仓库，这里 ***<ins>推荐把代码仓库也作为镜像的一部分</ins>***，参考Docker部分的[`笔记`](../../../../new_trends/Docker/articles/article1.md)），从镜像启动容器。然后跟操作 `remote ssh` 类似，点击vsc左下角，会弹出很多连容器的选项，选择 `Remote-Containers: Attach to Running Container`，接着会显示当前有哪些容器在运行，直接点击想连接的容器即可。连接上去后，就可以用vscode修改容器里的代码（所以推荐要把代码仓库也打到制作的镜像里！），进行开发、编译、测试之类的。本质上，***这里container起到的作用就是台Linux***！

然而，如果容器必须在Linux开发机器上启动怎么办？想利用 [Remote - Containers]() 直接attch到容器是不行的，因为只能看到本地的容器！

## 使用 `【1】` + `【2】` 实现增强功能：本地vsc通过 [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) 连接远程机器后，还能连接该远程机器上的container

解决前面困境的方法就是：
- 首先在远程Linux开发机上打好镜像，启动容器。
- 用 [Remote - SSH]() 连接到远程Linux开发机，点击左侧插件栏的 ***鲸鱼🐳图标***，也就是 [Docker]() 插件的图标，会发现可以识别出当前机器（***也就是远程Linux开发机***）上的容器！
- 两种方法连接到该容器，推荐后一种！
  * 或者 ***左键点击*** 该容器下的 `Files`，直接在当前vs code的界面（也就是远程Linux的界面）打开容器里的文件进行编辑，但是坏处是文件改动git显示不了，并且其实编辑还是稍有些麻烦（当然，总比自己开发机上写完，再手动 `docker cp` 粘贴进容器里要好）
  * 或者 ***右键点击*** 该容器，选择 `Attach Visual Studio Code`，会自动打开一个新的vsc窗口，里面就是各种可以用的状态，美滋滋！PS：如果不安装 [Remote - Containers]()，那么右键点击是没有 `Attach Visual Studio Code` 这个选项的。不过鲸鱼docker插件倒是自带了一个 `Attach Shell`，能打开容器里的命令行，但是效果也一般，跟 `Attach Visual Studio Code` 没得比。
