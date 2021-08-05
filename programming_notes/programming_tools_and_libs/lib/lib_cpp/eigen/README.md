
# 官方

eigen https://gitlab.com/libeigen/eigen
- > Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.
- > For more information go to http://eigen.tuxfamily.org/

https://github.com/eigenteam/eigen-git-mirror
- > THIS MIRROR IS DEPRECATED -- New url: https://gitlab.com/libeigen/eigen

Publications https://eigen.tuxfamily.org/index.php?title=Publications
- > Eigen tutorial @ [Eurographics/CGLibs](). Pisa, June 3rd, 2013. [slides](http://downloads.tuxfamily.org/eigen/eigen_CGLibs_Giugno_Pisa_2013.pdf), [demos.tgz]()
  * > A three hour an half tutorial introducing Eigen in the context of computer graphics. Content:

# 官方文档

https://eigen.tuxfamily.org/index.php?title=Main_Page
- **Documentation**
  * Getting started https://eigen.tuxfamily.org/dox/GettingStarted.html
  * The Matrix class https://eigen.tuxfamily.org/dox/group__TutorialMatrixClass.html
    + Eigen::Matrix< _Scalar, _Rows, _Cols, _Options, _MaxRows, _MaxCols > Class Template Reference https://eigen.tuxfamily.org/dox/classEigen_1_1Matrix.html
      - > **Fixed-size versus dynamic-size**:
        * > Fixed-size means that the numbers of rows and columns are known are compile-time. In this case, Eigen allocates the array of coefficients as a fixed-size array, as a class member. This makes sense for very small matrices, typically up to 4x4, sometimes up to 16x16. ***Larger matrices should be declared as dynamic-size even if one happens to know their size at compile-time***.
  * Quick reference guide https://eigen.tuxfamily.org/dox/group__QuickRefPage.html

Chapters https://eigen.tuxfamily.org/dox/modules.html
- Dense matrix and array manipulation https://eigen.tuxfamily.org/dox/group__DenseMatrixManipulation__chapter.html
  * Matrix and vector arithmetic https://eigen.tuxfamily.org/dox/group__TutorialMatrixArithmetic.html || https://github.com/qixianyu-buaa/EigenChineseDocument/blob/master/Eigen/Chapter1_DenseMatrixAndArrary/Section2_MatrixAndVectorArithmetic.hpp
  * The Array class and coefficient-wise operations https://eigen.tuxfamily.org/dox/group__TutorialArrayClass.html
  * Block operations https://eigen.tuxfamily.org/dox/group__TutorialBlockOperations.html || https://github.com/qixianyu-buaa/EigenChineseDocument/blob/master/Eigen/Chapter1_DenseMatrixAndArrary/Section4_BlockOperations.hpp
  * Alignment issues https://eigen.tuxfamily.org/dox/group__DenseMatrixManipulation__Alignement.html
    + Using STL Containers with Eigen https://eigen.tuxfamily.org/dox/group__TopicStlContainers.html
    + 【[:star:][`*`]】 Passing Eigen objects by value to functions https://eigen.tuxfamily.org/dox/group__TopicPassingByValue.html
      - > ***Passing objects by value is almost always a very bad idea in C++, as this means useless copies, and one should pass them by reference instead***.
      - > With Eigen, this is even more important: passing fixed-size vectorizable Eigen objects by value is ***not only inefficient, it can be illegal or make your program crash!*** And the reason is that these Eigen objects have alignment modifiers that aren't respected when they are passed by value.
      - > So for example, a function like this, where `v` is passed by value:
        ```cpp
        void my_function(Eigen::Vector2d v);
        ```
      - > needs to be rewritten as follows, passing `v` by reference:
        ```cpp
        void my_function(const Eigen::Vector2d& v);
        ```
      - > Note that on the other hand, there is ***no problem with functions that return objects by value***.

Common pitfalls https://eigen.tuxfamily.org/dox/TopicPitfalls.html
- > **Pass-by-value**
  * > If you don't know why passing-by-value is wrong with Eigen, read this [page](https://eigen.tuxfamily.org/dox/group__TopicPassingByValue.html) first.
  * > Using Eigen types with other third party libraries or even the STL can present the same problem. `boost::bind` for example uses pass-by-value to store arguments in the returned functor. This will of course be a problem.
  * > There are at least two ways around this:
    + > If the value you are passing is guaranteed to be around for the life of the functor, you can use `boost::ref()` to wrap the value as you pass it to `boost::bind`. Generally this is not a solution for values on the stack as if the functor ever gets passed to a lower or independent scope, the object may be gone by the time it's attempted to be used.
    + > The other option is to make your functions take a reference counted pointer like `boost::shared_ptr` as the argument. This avoids needing to worry about managing the lifetime of the object being passed.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Eigen库源码相关

C++性能之战（2）--double VS float https://blog.csdn.net/u013834525/article/details/103847759
- > `4. Eigen矩阵运算`
  * Eigen的速度为什么这么快？ - 知乎 https://www.zhihu.com/question/28571059

Eigen的速度为什么这么快？ - 知乎 https://www.zhihu.com/question/28571059
- Eigen的速度为什么这么快？ - 叶洪舟的回答 - 知乎 https://www.zhihu.com/question/28571059/answer/132951347
  * > 我 google 了一下，在 StackOverflow 上（[《***How to speed up Eigen library's matrix product?***》](https://stackoverflow.com/questions/14783219/how-to-speed-up-eigen-librarys-matrix-product)）有人讨论说是 MATLAB 内部自动会调用多线程版的 mkl 里的矩阵乘法，而 Eigen 在通常状态下是单线程的，需要在编译时加上 `-fopen` 参数使用 `openmp` 开启多线程。我在自己的 Mac 上尝试了一下，在线程数为 4 的情况下，时间缩短为 0.57 秒，但相比 MATLAB 的肉眼不可察觉还是有差距。
  * > P.S.: 最开始的单线程版本我使用的是 OS X 自带的 `g++` 编译器，优化参数为 `-Ofast`. 测试过加上 `-msse2` 没有明显区别。这个 `g++` 实际上是Apple 封装后的 `clang++`，很可惜的是不支持 `openmp`. 所以为了开启多线程我安装了 GNU `g++` 编译器。其它编译参数不变。
  * > 刚才又上 StackOverflow 上看了别人的几个帖子（[《***Eigen vs Matlab: parallelized Matrix-Multiplication***》](https://stackoverflow.com/questions/28284986/eigen-vs-matlab-parallelized-matrix-multiplication)）学习了一下，发现了几个新的 trick：
    + > 1.首先之前线程数我设置错误了。我的 CPU physically 应该只有两个核，四线程是 hyper－thread 的结果，多出来的两个线程并不能加速。我把 `OMP_NUM_THREADS` 改为 2 以后，速度变为 0.55s 左右；
    + > 2.如果计算矩阵乘法，使用 $B.noalias() = A^{T}A$ 是个不错的 trick，它可以避免生成 temporary 的矩阵存储中间结果。使用这个后缩短为 0.50s 左右；
    + > 3.对 Eigen 3.3 或以上的版本可以加上 `-mavx` 和 `-mfma` 两个参数，进一步缩短为 0.40s 左右。
  * > 经评论区提醒 Ofast 进行了一些 unsafe 的数学优化所以可能牺牲精度，在极端情况下甚至出错。参考如下 stackoverflow 链接的讨论：[《***G++ optimization beyond -O3/-Ofast***》](https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast)
    >> //notes：这个帖子（[《***G++ optimization beyond -O3/-Ofast***》](https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast)）里的[置顶回答](https://stackoverflow.com/questions/14492436/g-optimization-beyond-o3-ofast/38511897#38511897)牛出天际！详见性能优化部分（也可能未来会放到GCC部分）的笔记。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Eigen性能提升技巧

How to speed up Eigen library's matrix product? https://stackoverflow.com/questions/14783219/how-to-speed-up-eigen-librarys-matrix-product
- https://stackoverflow.com/questions/14783219/how-to-speed-up-eigen-librarys-matrix-product/14796261#14796261
  * > First of all, when doing performance comparison, makes sure you disabled ***turbo-boost*** (TB). On my system, using gcc 4.5 from macport and without turbo-boost, I get 3.5s, that corresponds to 8.4 GFLOPS while the theoretical peak of my 2.3 core i7 is 9.2GFLOPS, so not too bad.
  * > MatLab is based on Intel MKL, and seeing the reported performance, it clearly uses a multithreaded version. It is unlikely that an small library as Eigen can beat Intel on its own CPU!
  * > Numpy can uses any BLAS library, Atlas, MKL, OpenBLAS, eigen-blas, etc. I guess that in your case it was using Atlas which is fast too.
  * > Finally, here is how you can get better performance: enable multi-threading in Eigen by compiling with `-fopenmp`. By default Eigen uses for the number of the thread the default number of thread defined by OpenMP. Unfortunately this number corresponds to the number of logic cores, and not physical cores, so make sure hyper-threading is disabled or define the `OMP_NUM_THREADS` environment variable to the physical number of cores. Here I get 1.25s (without TB), and 0.95s with TB.
  * 回复里的：
    + > Good call on the multithreading: Matlab multithreading seems to explain most of the difference. When I use the "`-singleCompThread`" command line option, Matlab clocks in at ~2.4 sec, same as Eigen.
    + > I can't think of any good reason why you would set `OMP_NUM_THREADS` to anything but the number of logical cores in this case. If you set it to the number of physical cores with HT enabled you'll just be idling 50% of the CPU...
      >> Basically, HT permits to hide memory latencies and enhance instruction pipelining by running two threads on the same physical core. However, a well implemented matrix product routine as in Eigen already occupies nearly 100% of the arithmetic units meanings pipelining is already perfect and memory latencies are already well hidden. In this context, HT can only destroy the performance. For instance, the two threads will concurrently access the same L1 cache resource thus cancelling the benefit of L1 cache.
    + > Last I checked Eigen only used SSE and MKL used AVX. That's a factor of two loss. Since them Haswell has come out with FMA. I don't know if MKL supports FMA but if it does then that's potentially another factor of two loss (four total). My own GEMM code I have written is over twice as fast as Eigen using OpenMP and FMA.

Eigen vs Matlab: parallelized Matrix-Multiplication https://stackoverflow.com/questions/28284986/eigen-vs-matlab-parallelized-matrix-multiplication
- https://stackoverflow.com/questions/28284986/eigen-vs-matlab-parallelized-matrix-multiplication/28286298#28286298
  * > set `OMP_NUM_THREADS` to the true number of cores, not number of hyper-threads. (4 in your case)
  * > your CPU supports `AVX` and `FMA` that are only supported by the devel branch of Eigen (will become 3.3), so use the devel branch and enable them with the `-mavx` and `-mfma` compiler options (about x3.5 speed up compared to `SSE` only)

Worse performance using Eigen than using my own class https://stackoverflow.com/questions/6193546/worse-performance-using-eigen-than-using-my-own-class
- https://stackoverflow.com/questions/6193546/worse-performance-using-eigen-than-using-my-own-class/6193829#6193829
  * > Which version of Eigen are you using? They recently released 3.0.1, which is supposed to be faster than 2.x. Also, make sure you play a bit with the compiler options. For example, make sure `SSE` is being used in Visual Studio: `C/C++ --> Code Generation --> Enable Enhanced Instruction Set`
- https://stackoverflow.com/questions/6193546/worse-performance-using-eigen-than-using-my-own-class/6193862#6193862
  * > If you're using Eigen's `MatrixXd` types, those are dynamically sized. You should get much better results from using the fixed size types e.g `Matrix4d`, `Vector4d`.
  * > Also, make sure you're compiling such that the code can get vectorized; see the [relevant Eigen documentation](http://eigen.tuxfamily.org/index.php?title=FAQ#Vectorization).
- https://stackoverflow.com/questions/6193546/worse-performance-using-eigen-than-using-my-own-class/6323862#6323862
  * > Make sure to have compiler optimization switched on (e.g. at least `-O2` on gcc). Eigen is heavily templated and will not perform very well if you don't turn on optimization.
- https://stackoverflow.com/questions/6193546/worse-performance-using-eigen-than-using-my-own-class/19469577#19469577
  * > I hope this isn't insulting, but are you compiling in Release or Debug? Eigen is very slow in debug builds, because it uses lots of trivial templated functions that are optimized out of release but remain in debug.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 较有用攻略

Eigen Tutorial 中文文档(c++版) - IQIT的文章 - 知乎 https://zhuanlan.zhihu.com/p/87613088
- Eigen教程 https://github.com/qixianyu-buaa/EigenChineseDocument

Eigen 简明教程 https://juejin.cn/post/6844904094713249800
- > **Which should I choose: matrix or array**
  * > 在 Python（NumPy）中，你可以用 `np.matrix` 创建矩阵，`np.array` 创建数组，但是官方推荐用 `np.array`，原因是：
  * > 由于 NumPy 的便利性，我们通常用 `np.array` 也能够完成线性代数相关的任务，进一步导致 `np.matrix` 存在感很弱。
  * > 但在 Eigen 中 `matrix` 与 `array` 是有明确区别的，总的来说，Eigen 中的 `matrix` 与线性代数息息相关，它设计的初衷就是为了解决线性代数问题，例如解线性方程组、求矩阵特征值、矩阵的秩、QR分解等等。而 `array` 则负责系数运算，例如所有系数加上一个常数或者两个 `array` 系数相乘。
  * > 因此，如果你需要线性代数的操作时，请使用 matrix；如果你需要系数操作时，请使用 array。但有时候事情不会那么简单，你可能需要同时使用 matrix 和 array，这种情况下，你需要对 matrix 和 array 进行相互转换。一个 matrix 通过 `.array()` 来得到一个 array 表达式；相似的，一个 array 通过 `.matrix()` 来得到一个 matrix 表达式。`.array()` 和 `.matrix()` 不会有任何运行时开销，它们是在编译期完成的。

Eigen学习记录 - 月光亲了城的文章 - 知乎 https://zhuanlan.zhihu.com/p/42718881

Matrix Manipulations in C++ using Eigen Library https://iamfaisalkhan.com/matrix-manipulations-using-eigen-cplusplus/

Cheat sheet for the linear algebra library Eigen https://gist.github.com/gocarlos/c91237b02c120c6319612e42fa196d77

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 比较一般的攻略

C++矩阵计算库Eigen3之：矩阵的基本操作和运算 https://blog.csdn.net/hanss2/article/details/78822955

C++ Eigen3使用详细教程 https://blog.csdn.net/wwxy1995/article/details/84996437

Eigen使用方法 https://blog.csdn.net/u012686154/article/details/88061647

C++矩阵处理工具——Eigen https://blog.csdn.net/abcjennifer/article/details/7781936

C++Eigen库的配置和基本使用 https://blog.csdn.net/wangxue_1231/article/details/90256026

Eigen: C++开源矩阵计算工具——Eigen的简单用法 https://blog.csdn.net/Augusdi/article/details/12907341

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gdb里debug这个库看不到具体信息

Using GDB with Eigen C++ library https://stackoverflow.com/questions/25085465/using-gdb-with-eigen-c-library
- > You have to install a gdb extension that you can find in [eigen/debug/gdb/](https://gitlab.com/libeigen/eigen/-/blob/master/debug/gdb/printers.py). The comment at the beginning of the file explains how to install it.
- > One trick you can use is the .data() member, it gives you a pointer to the raw array that contains the data. With that you can print it in GDB like so:
  ```sh
  print *X.data()@Length_X
  ```
  > where X is the eigen variable and Length_X is the product of its rows and columns.

Debugging Eigen in VSCode https://stackoverflow.com/questions/58464867/debugging-eigen-in-vscode

如何使用gdb打印Eigen中的变量 https://blog.csdn.net/tony_513/article/details/72937692

How to debug with gdb with eigen math library https://stackoverflow.com/questions/27180589/how-to-debug-with-gdb-with-eigen-math-library

## （结合上面几篇）个人实战在gdb中打印Eigen矩阵

```sh
mkdir eigen_configuration && cd eigen_configuration/
# 官方源文件地址在这里（过去 bitbucket 上的不能用了）：https://gitlab.com/libeigen/eigen/-/blob/master/debug/gdb/printers.py
wget https://gitlab.com/libeigen/eigen/-/raw/master/debug/gdb/printers.py
touch __init__.py

cat << EOF >> ~/.gdbinit
# This is for Eigen print
python
import sys
sys.path.insert(0,'/home/<YOUR_USER_NAME>/eigen_configuration')
from printers import register_eigen_printers
register_eigen_printers (None)
end
EOF
```
>> //notes：然后注意就是启动gdb后如果没有自动 `source` 文件 `.gdbinit` 的话，需要在 gdb 界面里手动 `source` 下。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 在 cmake 中使用 Eigen

Find package Eigen3 for CMake https://stackoverflow.com/questions/12249140/find-package-eigen3-for-cmake

https://github.com/zhongjingjogy/use-eigen-with-cmake/blob/master/CMakeLists.txt

https://sites.google.com/site/alexeyvakimov/mini-tutorials/programming-boost-python-c/cmake-tutorial
- > Now, before we go to "build" and "install" the code, we do a simple trick. Go to CMakeLists.txt file and add the following piece of code:
  ```sh
  # My customization!!!
  set (CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/_install)
  ```
  > This will tell the installer to create an "_install" directory in the Eigen root directory and install all stuff there. Like I said, we use underscore to facilitate sorting of the directories  and to yield the best organized filesystem.
- > Now it is time to do standard stuff:
  ```sh
  $ mkdir _build
  $ cd _build
  $ cmake ..
  $ make
  $ make install
  ```
  > When you go back to your Eigen root directory, you will see that the "_install" directory has been created.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Eigen and multi-thread

Eigen and multi-threading https://eigen.tuxfamily.org/dox/TopicMultiThreading.html

TensorFlow源码分析（6）：Eigen的Simple Thread Pool实现原理 https://blog.csdn.net/hedan2013/article/details/103807170

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 排序

利用标准库std::sort()对Eigen库的向量进行排序 https://blog.csdn.net/X_And_Y/article/details/83383520

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `.rows()` 和 `.cols()`

How to get the number of rows and columns of an Eigen::MatrixXd? https://stackoverflow.com/questions/51640997/how-to-get-the-number-of-rows-and-columns-of-an-eigenmatrixxd
```cpp
#include <Eigen/Dense>

int main()
{
    Eigen::MatrixXd matrix(3, 4);
    int r = matrix.rows();
    int c = matrix.cols();
    for (int i = 0; i < r; ++i)
    {
        for (int j = 0; j < c; ++j)
        {
            std::cout << matrix(i,j);
        }
    }
    return 0;
}
```

# `.block()`

Shrink matrix with Eigen using block() in assignment https://stackoverflow.com/questions/30145771/shrink-matrix-with-eigen-using-block-in-assignment

# `::Map()`

Typecasting `std::vector<double>` to `Eigen::VectorXd` https://forum.kde.org/viewtopic.php?t=94839
```cpp
#include <Eigen/Dense>
#include <vector>
using namespace Eigen;
int main() {
  std::vector<std::complex<double> > v2(10);
  VectorXcd v3 = VectorXcd::Map(v2.data(), v2.size());
}
```

typecasting `Eigen::VectorXd` to `std::vector` https://stackoverflow.com/questions/26094379/typecasting-eigenvectorxd-to-stdvector
- > 
  ```cpp
  vector<int> vec(mat.data(), mat.data() + mat.rows() * mat.cols());
  ```
- > You cannot typecast, but you can easily copy the data:
  ```cpp
  VectorXd v1;
  v1 = ...;
  vector<double> v2;
  v2.resize(v1.size());
  VectorXd::Map(&v2[0], v1.size()) = v1;
  ```
  > `mat.rows() * mat.cols()` can be simplified to `mat.size()`, however, be aware that this solution only work for a plain `Matrix<>` object, while using a `Map<>` as in my answer works for sub-matrices too.

Using C++/Eigen3 https://epcced.github.io/2019-04-16-ModernCpp/lectures/eigen/using-eigen.pdf
- > It is easy to “overlay” existing memory with an Eigen Array or Matrix:
  ```cpp
  std::vector<double> a(1000);
  Eigen::Map<Eigen::Matrix<double, 100, 10>> a_eigen(a.data());
  a_eigen(10, 0) = 1.0;
  Eigen::Map<Eigen::MatrixXd> a2_eigen(a.data(), 10, 100);
  ```

can I exchange data between matrix, array and std:vector https://forum.kde.org/viewtopic.php?t=102900

eigen_matrix_helper.cpp https://gist.github.com/ialhashim/14db82926cdab2575508

# 添加行、列等

Append column to matrix, using Eigen library https://stackoverflow.com/questions/27404811/append-column-to-matrix-using-eigen-library
- > You can use `conservativeResize` for that purpose:
  ```cpp
  mat.conservativeResize(mat.rows(), mat.cols()+1);
  mat.col(mat.cols()-1) = vec;
  ```
  >> Thanks, this is working. I figured out that it is even possible to write `mat.conservativeResize(NoChange, mat.cols()+1);` which lets the number of rows unchanged.

How do you make a matrix out of vectors in eigen? https://stackoverflow.com/questions/16470893/how-do-you-make-a-matrix-out-of-vectors-in-eigen
- > You can also append them using the comma initializer syntax:
  ```cpp
  m << v1, v2, v3, v4;
  ```
  > The matrix m must have been properly resized first.

Eigen how to concatenate matrix along a specific dimension? https://stackoverflow.com/questions/21496157/eigen-how-to-concatenate-matrix-along-a-specific-dimension

how to concatenate Vectors in Eigen? https://stackoverflow.com/questions/25691324/how-to-concatenate-vectors-in-eigen
- > Like so, assuming you have vec1 and vec2 already:
  ```cpp
  VectorXd vec_joined(vec1.size() + vec2.size());
  vec_joined << vec1, vec2;
  ```

Assigning a vector to a matrix column in Eigen https://stackoverflow.com/questions/36417836/assigning-a-vector-to-a-matrix-column-in-eigen

Eigen::Matrix与array数据转换 https://www.cnblogs.com/VVingerfly/p/8037490.html
