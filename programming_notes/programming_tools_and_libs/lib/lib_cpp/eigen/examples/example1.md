
# 1. vector里可以带不同形状的Eigen矩阵

```cpp
#include "./eigen/Eigen/Dense"
#include <iostream>
#include <vector>
using namespace std;

int main() {
    std::vector<Eigen::MatrixXd> v(2);
    Eigen::MatrixXd m1, m2;

    m1.resize(2,2);
    m1 << 1,2,
          3,4;
    
    m2.resize(2,3);
    m2 << 5,6,0,
          7,8,0;

    cout << "----------" << endl;
    v[0] = m1;
    v[1] = m2;
    cout << v[0] << endl;
    cout << v[1] << endl;
    cout << "----------" << endl;
}
```
```sh
$ g++ test.cpp -o test 
$ ./test 
----------
1 2
3 4
5 6 0
7 8 0
----------
$
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 2. 默认的 column major 和 row major 的区别

```cpp
#include "/app/src/third_party/eigen/Eigen/Dense"
#include <iostream>
#include <vector>
using namespace std;

int main() {
    Eigen::MatrixXd m1;
    m1.resize(2,3);
    m1 << 1,2,3,
          4,5,6;

    Eigen::Matrix<int, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor> m2;
    m2.resize(2,3);
    m2 << 1,2,3,
          4,5,6;

    cout << "1. seems no difference" << endl;
    cout << "--------------------" << endl;
    cout << "m1: " << endl;
    cout << m1 << endl;
    cout << "m2: " << endl;
    cout << m2 << endl;
    cout << "--------------------" << endl;

    cout << "2. seems no difference, too" << endl;
    cout << "--------------------" << endl;
    cout << "m1: " << endl;
    for (int i = 0; i < m1.rows(); ++i) {
        for (int j = 0; j < m1.cols(); ++j) {
            cout << "m1(" << i << "," << j << ") = " << m1(i,j) << endl;
        }
    }
    cout << "m2: " << endl;
    for (int i = 0; i < m2.rows(); ++i) {
        for (int j = 0; j < m2.cols(); ++j) {
            cout << "m2(" << i << "," << j << ") = " << m2(i,j) << endl;
        }
    }
    cout << "--------------------" << endl;

    cout << "3. the difference is here:" << endl;
    cout << "m1: " << endl;
    for (int k = 0; k < m1.rows() * m1.cols(); ++k)
        cout << "m1(" << k << ") = " << m1(k) << endl;
    cout << "m2: " << endl;
    for (int k = 0; k < m2.rows() * m2.cols(); ++k)
        cout << "m2(" << k << ") = " << m2(k) << endl;
    cout << "--------------------" << endl;
}
```
```sh
$ g++ rowmajor_colmajor.cpp -o rowmajor_colmajor
$ ./rowmajor_colmajor 
1. seems no difference
--------------------
m1: 
1 2 3
4 5 6
m2: 
1 2 3
4 5 6
--------------------
2. seems no difference, too
--------------------
m1: 
m1(0,0) = 1
m1(0,1) = 2
m1(0,2) = 3
m1(1,0) = 4
m1(1,1) = 5
m1(1,2) = 6
m2: 
m2(0,0) = 1
m2(0,1) = 2
m2(0,2) = 3
m2(1,0) = 4
m2(1,1) = 5
m2(1,2) = 6
--------------------
3. the difference is here:
m1: 
m1(0) = 1
m1(1) = 4
m1(2) = 2
m1(3) = 5
m1(4) = 3
m1(5) = 6
m2: 
m2(0) = 1
m2(1) = 2
m2(2) = 3
m2(3) = 4
m2(4) = 5
m2(5) = 6
--------------------
$ 
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
