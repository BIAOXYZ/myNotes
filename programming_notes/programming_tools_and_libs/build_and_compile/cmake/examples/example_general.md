
# 编译debug版本

cmake 管理debug release - spiritsaway的文章 - 知乎 https://zhuanlan.zhihu.com/p/116953293
- > `CMAKE_BUILD_TYPE` 只能指定 `single configuration` 类型的项目配置， 无法指定 `multi configuration` 的项目配置。`multi configuration`的项目配置是在使用者手动指定的时候修改的，默认都是`Debug`。但是对于`multi configuration`的项目，我们可以在触发编译的时候指定是`Debug`还是`Release`:

如何使用Cmake生成debug版本和release版本的程序 https://blog.csdn.net/a794226986/article/details/18605903

## 个人实战1
```sh
cmake . -DCMAKE_BUILD_TYPE=Debug
```

# 清除cmake缓存

cmake清除缓存的操作（类似 make clean） https://blog.csdn.net/daijingxin/article/details/111826612
- > 通过查看cmake命令的help发现可以通过创建一个额外的文件夹的方式实现：
  ```sh
  cmake -S . -B build
  ```
  > 之后每次操作直接删除掉build文件就可以了。
>> //notes：这两个参数分别是指源的路径和构建文件生成的路径。PS：不过最常用的还是新建个目录，然后进到这个目录里去 cmake 生成 Makefile 然后 build。比如个人习惯就是project的根目录下建两个目录，分别叫`build` 和 `debugbuild`，然后每次都在这两个目录里分别：`cmake .. -DCMAKE_BUILD_TYPE=Release` 或者 `cmake .. -DCMAKE_BUILD_TYPE=Debug`，最后 `make -j` 即可。
```console
  -S <path-to-source>          = Explicitly specify a source directory.
  -B <path-to-build>           = Explicitly specify a build directory.
```

Looking for a 'cmake clean' command to clear up CMake output https://stackoverflow.com/questions/9680420/looking-for-a-cmake-clean-command-to-clear-up-cmake-output
