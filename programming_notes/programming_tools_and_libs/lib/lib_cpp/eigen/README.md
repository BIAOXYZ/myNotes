
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
  * Quick reference guide https://eigen.tuxfamily.org/dox/group__QuickRefPage.html

Chapters https://eigen.tuxfamily.org/dox/modules.html
- Dense matrix and array manipulation https://eigen.tuxfamily.org/dox/group__DenseMatrixManipulation__chapter.html
  * Matrix and vector arithmetic https://eigen.tuxfamily.org/dox/group__TutorialMatrixArithmetic.html || https://github.com/qixianyu-buaa/EigenChineseDocument/blob/master/Eigen/Chapter1_DenseMatrixAndArrary/Section2_MatrixAndVectorArithmetic.hpp
  * The Array class and coefficient-wise operations https://eigen.tuxfamily.org/dox/group__TutorialArrayClass.html
  * Block operations https://eigen.tuxfamily.org/dox/group__TutorialBlockOperations.html || https://github.com/qixianyu-buaa/EigenChineseDocument/blob/master/Eigen/Chapter1_DenseMatrixAndArrary/Section4_BlockOperations.hpp
  * Alignment issues https://eigen.tuxfamily.org/dox/group__DenseMatrixManipulation__Alignement.html
    + Using STL Containers with Eigen https://eigen.tuxfamily.org/dox/group__TopicStlContainers.html

# 其他

C++矩阵计算库Eigen3之：矩阵的基本操作和运算 https://blog.csdn.net/hanss2/article/details/78822955

C++ Eigen3使用详细教程 https://blog.csdn.net/wwxy1995/article/details/84996437

Eigen使用方法 https://blog.csdn.net/u012686154/article/details/88061647

C++矩阵处理工具——Eigen https://blog.csdn.net/abcjennifer/article/details/7781936

C++Eigen库的配置和基本使用 https://blog.csdn.net/wangxue_1231/article/details/90256026

Eigen: C++开源矩阵计算工具——Eigen的简单用法 https://blog.csdn.net/Augusdi/article/details/12907341

Eigen Tutorial 中文文档(c++版) - IQIT的文章 - 知乎 https://zhuanlan.zhihu.com/p/87613088
- Eigen教程 https://github.com/qixianyu-buaa/EigenChineseDocument

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

# 排序

利用标准库std::sort()对Eigen库的向量进行排序 https://blog.csdn.net/X_And_Y/article/details/83383520

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
