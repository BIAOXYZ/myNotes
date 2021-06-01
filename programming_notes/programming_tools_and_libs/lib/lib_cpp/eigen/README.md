
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
