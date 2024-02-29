
# 1

HOWTO https://calcite.apache.org/docs/howto.html

```sh
docker run -itd --name test_calcite --net=host ubuntu:20.04 bash
docker exec -it test_calcite bash
```

```sh
apt update

# 安装 jdk11
apt install -y default-jdk git wget unzip
java -version

# 安装 gradle 7.6.1
## apt install -y gradle 的版本太低，因此需要手动去官网下载安装，参考：https://vegastack.com/tutorials/how-to-install-gradle-on-ubuntu-22-04/
wget -c https://services.gradle.org/distributions/gradle-7.6.1-bin.zip -P /tmp
unzip -d /opt/gradle /tmp/gradle-7.6.1-bin.zip
cat << EOF > /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-7.6.1
export PATH=\${GRADLE_HOME}/bin:\${PATH}
EOF
chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle --version
```

```sh
# 选择一
## 如果从 github仓库下载 calcite 源码，则 example/csv 的例子能直接 run
mkdir githubs/
cd githubs/
git clone https://github.com/apache/calcite.git
cd calcite/example/csv/
./sqlline
```
```sh
# 选择二
## 如果源码下载，还需要 build，时间很长。。。
mkdir githubprojs/
cd githubprojs/
wget https://archive.apache.org/dist/calcite/apache-calcite-1.36.0/apache-calcite-1.36.0-src.tar.gz
tar -zxvf apache-calcite-1.36.0-src.tar.gz
cd apache-calcite-1.36.0-src/
gradle build
```
