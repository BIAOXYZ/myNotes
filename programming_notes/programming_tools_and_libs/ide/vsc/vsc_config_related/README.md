
vscode中运行多线程代码 https://blog.csdn.net/Hao_jiu/article/details/114930919

# linux下安装

How to Install Visual Studio Code on Ubuntu 20.04 https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-20-04/
- > **Installing Visual Studio Code as a Snap Package**
  ```sh
  sudo snap install --classic code
  ```
- > **Installing Visual Studio Code with `apt`**
  ```sh
  sudo apt install -y software-properties-common apt-transport-https wget
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt install -y code
  ```
- > **Starting Visual Studio Code**
  * > In the `Activities` ***search bar*** type “Visual Studio Code” and click on the icon to launch the application.
>> //notes：这个比[官方的安装攻略](https://code.visualstudio.com/docs/setup/linux)好用感觉。。。
