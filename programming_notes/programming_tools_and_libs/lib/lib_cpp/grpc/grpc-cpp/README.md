
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# C++ 下 gRPC 安装
>> //notes：其他语言的 gRPC 库，用那个语言的包管理器比较好装（比如python就用pip）

***参考链接***：
- 【两个官方链接的安装方法】：
  * gRPC C++ - Building from source https://github.com/grpc/grpc/blob/v1.40.0/BUILDING.md
  * Quick start https://grpc.io/docs/languages/cpp/quickstart/
- Linux 系统编译安装基于 C++ 的 gRPC https://blog.towind.fun/2021/04/21/linux-docker-install-grpc/ 【这个基本是完全按照官方教程来的，我觉得唯一不好的一点就是需要自己指定一个目录，安装到指定目录中。然后把该目录下的子目录 `bin` 添加到 `PATH`。***但是最终还是按照这个来了***，唯一一点区别就是直接 `make` 没有 `make -j`，因为后者在编译过程中有BUG，这个之前在别的编译中也遇到过。】
- Get started with gRPC in C++ https://medium.com/@shradhasehgal/get-started-with-grpc-in-c-36f1f39367f4 【这个指出了并行编译会有bug，此外这个是直接安装到默认路径的——我也想这么搞，但是官方也说了按默认安装不好卸载，还是算了。】
  * > The official documentation suggests running `make -j` instead of just `make`. This make the process faster as the `-j` flag runs multiple jobs simultaneously, but my system hung multiple times when I tried it, so approach it with caution.
- 【两个不用 cmake 而是用仓库自带的 Makefile 来安装的例子，但是现在不推荐了，所以也没试】：
  * gRPC 编译安装总结 https://segmentfault.com/a/1190000020812273
  * Ubuntu安装GRPC https://blog.csdn.net/MOU_IT/article/details/79846066

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# grpc and CMake

`grpc/examples/cpp/helloworld/CMakeLists.txt` https://github.com/grpc/grpc/blob/8aff94558c/examples/cpp/helloworld/CMakeLists.txt

## could not find `/usr/local/lib/cmake/grpc/gRPCTargets.cmake`

CMake with gRPC cannot find gRPCTargets.cmake https://stackoverflow.com/questions/57413975/cmake-with-grpc-cannot-find-grpctargets-cmake
- https://stackoverflow.com/questions/57413975/cmake-with-grpc-cannot-find-grpctargets-cmake/57426973#57426973
  * > Or just force everything with the command-line linked in the issue:
    ```sh
    cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DgRPC_PROTOBUF_PROVIDER=package -DgRPC_ZLIB_PROVIDER=package -DgRPC_CARES_PROVIDER=package -DgRPC_SSL_PROVIDER=package -DCMAKE_BUILD_TYPE=Release ../.. 
    ```

## Could not find a package configuration file provided by "c-ares" with any of the following names: `c-aresConfig.cmake` `c-ares-config.cmake`

Building grpc from source using preinstalled packages https://stackoverflow.com/questions/50875144/building-grpc-from-source-using-preinstalled-packages
- https://stackoverflow.com/questions/50875144/building-grpc-from-source-using-preinstalled-packages/54819108#54819108

grpc使用记录(一) gRPC编译(mscv/gcc) https://www.cnblogs.com/oloroso/p/11121922.html 【最终还是用这个帖子的方法解决了，不需要下载了，直接去grpc的third_party目录下用cmake再编译安装一遍即可。】
- > 2、编译安装c-ares
  ```sh
  git clone https://github.com/c-ares/c-ares.git
  cd c-ares
  # 可以不下载，直接  cd grpc/third_party/cares/cares
  cmake3 . -DCMAKE_INSTALL_PREFIX=/usr
  make && make install
  ```
