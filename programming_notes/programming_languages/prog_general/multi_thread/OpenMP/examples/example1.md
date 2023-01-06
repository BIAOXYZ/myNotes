
# 1

> ***`test.cpp`***
>> //notes：同样的代码，如果你编译时候没有加 `-fopenmp`，那么 OpenMP 的优化是不生效的（但是正常编译和运行是没问题的）。
```cpp
#include <bits/stdc++.h>

int M = 10000;
int N = 100000;
void test1(int m=M, int n=N) {
    std::cout << "m is: " << m << " n is: " << n << std::endl;
    std::vector<int> v(m*n, 0);
    auto start = std::chrono::system_clock::now();
    #pragma omp parallel for num_threads(8)
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            v[m*i + j] = m * i + j;
        }
    }
    auto end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "Elapsed time with OPENOMP is: " << elapsed.count() << "s" << std::endl;
}
void test2(int m=M, int n=N) {
    std::cout << "m is: " << m << " n is: " << n << std::endl;
    std::vector<int> v(m*n, 0);
    auto start = std::chrono::system_clock::now();
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            v[m*i + j] = m * i + j;
        }
    }
    auto end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "Elapsed time is: " << elapsed.count() << "s" << std::endl;
}

int main() {
    test1();
    test2(); 
}
```
```sh
$ g++ test.cpp -o test
$ ./test 
m is: 10000 n is: 100000
Elapsed time with OPENOMP is: 3.56431s
m is: 10000 n is: 100000
Elapsed time is: 3.60475s
$ 
$ g++ test.cpp -fopenmp -o test_enable_openmp
$ ./test_enable_openmp 
m is: 10000 n is: 100000
Elapsed time with OPENOMP is: 0.54728s
m is: 10000 n is: 100000
Elapsed time is: 3.50869s
$ 
# 加上 -march=native -mtune=native 看来也没啥用 —— 或者也可能是三种都要配合 -O2 一起？不管了，主要还是为了实验 OpenMP。
$ g++ test.cpp -fopenmp -march=native -mtune=native -o test_enable_openmp_and_other_compile_params
$ ./test_enable_openmp_and_other_compile_params 
m is: 10000 n is: 100000
Elapsed time with OPENOMP is: 0.574336s
m is: 10000 n is: 100000
Elapsed time is: 3.53735s
$ 
```


> ***`test2.cpp`***
>> //notes：这个 `test2.cpp` 和前面的 `test.cpp` 的区别很明显。前面 `test.cpp` 是对 `vector` 进行操作，这里变成了简单的 `x++`。然后就会发现 OpenMP 的优化就不起作用了 —— 所以可能编译器本身已经做了很多优化工作，***并不是所有的看起来能并行的地方用 OpenMP 都会有效果***。
```cpp
#include <bits/stdc++.h>

int M = 10000;
int N = 100000;
void test1(int m=M, int n=N) {
    std::cout << "m is: " << m << " n is: " << n << std::endl;
    // std::vector<int> v(m*n, 0);
    int x = 0;
    auto start = std::chrono::system_clock::now();
    #pragma omp parallel for num_threads(8)
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            // v[m*i + j] = m * i + j;
            x++;
        }
    }
    auto end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "Elapsed time with OPENOMP is: " << elapsed.count() << "s" << std::endl;
}
void test2(int m=M, int n=N) {
    std::cout << "m is: " << m << " n is: " << n << std::endl;
    // std::vector<int> v(m*n, 0);
    int x = 0;
    auto start = std::chrono::system_clock::now();
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            // v[m*i + j] = m * i + j;
            x++;
        }
    }
    auto end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    std::cout << "Elapsed time is: " << elapsed.count() << "s" << std::endl;
}

int main() {
    test1();
    test2(); 
}
```
```sh
$ g++ test2.cpp -o test
$ ./test 
m is: 10000 n is: 100000
Elapsed time with OPENOMP is: 1.66191s
m is: 10000 n is: 100000
Elapsed time is: 1.64564s
$ 
$ g++ test2.cpp -fopenmp -o test_enable_openmp
$ ./test_enable_openmp 
m is: 10000 n is: 100000
Elapsed time with OPENOMP is: 2.97912s
m is: 10000 n is: 100000
Elapsed time is: 1.65952s
$ 
```

# 2

在C++中使用openmp进行多线程编程 https://blog.csdn.net/acaiwlj/article/details/49818965

## 启用 openmp，所有线程都会打印一遍；否则就只打一遍。

```cpp
#include <bits/stdc++.h>
int main() {
    #pragma omp parallel
    {
        std::cout << "parallel run!!!\n";
    }
}
```
```sh
$ g++ test2.cpp -fopenmp -o test2
$ ./test2
parallel run!!!
parallel run!!!
parallel run!!!
parallel run!!!
parallel run!!!
parallel run!!!
parallel run!!!
parallel run!!!
```

```cpp
#include <bits/stdc++.h>
int main() {
    // #pragma omp parallel
    {
        std::cout << "parallel run!!!\n";
    }
}
```
```console
$ g++ test2.cpp -fopenmp -o test2
$ ./test2
parallel run!!!
```

## 启用 openmp 就（绝大部分情况下）是乱序的；否则就是正常序列。

```cpp
#include <bits/stdc++.h>
int main() {
    #pragma omp parallel for
    for (int i = 0; i < 10; ++i) {
        printf("%d-", i);
    }
    printf("\n");
}
```
```sh
$ g++ test2.cpp -fopenmp -o test2
$ ./test2
7-6-2-3-5-9-8-0-1-4-
$ ./test2
0-9-1-4-2-5-6-7-3-8-
$ ./test2
0-1-8-5-6-7-2-3-4-9-
```

```cpp
#include <bits/stdc++.h>
int main() {
    // #pragma omp parallel for
    for (int i = 0; i < 10; ++i) {
        printf("%d-", i);
    }
    printf("\n");
}
```
```sh
$ g++ test2.cpp -fopenmp -o test2
$ ./test2
0-1-2-3-4-5-6-7-8-9-
$ ./test2
0-1-2-3-4-5-6-7-8-9-
$ ./test2
0-1-2-3-4-5-6-7-8-9-
$ 
```
