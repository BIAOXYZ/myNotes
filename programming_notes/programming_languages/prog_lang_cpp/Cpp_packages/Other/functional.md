
# 官方

`header <functional>` https://www.cplusplus.com/reference/functional/
- **Wrapper classes**
  * std::function https://www.cplusplus.com/reference/functional/function/
    + std::function::function https://www.cplusplus.com/reference/functional/function/function/

std::function https://en.cppreference.com/w/cpp/utility/functional/function

Lambda expressions (since C++11) https://en.cppreference.com/w/cpp/language/lambda
- > **Syntax**
```console
[ captures ] ( params ) specs requires(optional) { body }	                                  (1)	
[ captures ] { body }	                                                                      (2)	(until C++23)
[ captures ] specs { body }	                                                                (2)	(since C++23)
[ captures ] < tparams > requires(optional) ( params ) specs requires(optional) { body }	  (3)	(since C++20)
[ captures ] < tparams > requires(optional) { body }	                                      (4)	(since C++20) (until C++23)
[ captures ] < tparams > requires(optional) specs { body }	                                (4)	(since C++23)
```

# 其他

深入浅出C++的function - 李超的文章 - 知乎 https://zhuanlan.zhihu.com/p/161356621

## 匿名函数 / Lambda 函数

C++ 中的 Lambda 表达式 https://docs.microsoft.com/zh-cn/cpp/cpp/lambda-expressions-in-cpp

11.9 — Lambda captures https://www.learncpp.com/cpp-tutorial/lambda-captures/

C++ 闭包和匿名函数 - Providence的文章 - 知乎 https://zhuanlan.zhihu.com/p/303391384
- > 匿名函数由以下几个部分组成，其中只有 1, 2, 6 三个部分是必须的，其余部分可以省略：![](https://pic1.zhimg.com/80/v2-38e792a40f910a018b17092cdc723674_1440w.jpg)
  ```console
  1. 捕获子句 capture clause / lambda introducer
  2. 参数列表 parameter list / lambda declarator
  3. 可变规格 mutable specification
  4. 被 mutable 修饰的匿名函数可以修改按值捕获的变量
  5. exception specification
  6. 尾随返回类型 trailing-return-type
  7. 匿名函数体 lambda body
  ```
- > **2.1 捕获子句**
  * > 捕获子句用于***捕获外部变量，使得匿名函数体可以使用这些变量***，捕获的方法分为***引用捕获***和***值（拷贝）捕获***两种，使用方法如下：
    ```console
    1. [] 不捕获任何变量；
    2. [&] 按引用捕获所有外部变量；
    3. [=] 按值捕获所有外部变量
    4. [&, var] 默认按引用捕获，仅按值捕获 var；
    5. [=, &var] 默认按值捕获，仅按引用捕获 var；
    6. [y, y] 重复按值捕获同一个变量，没有意义，会报 warning；
    7. [&, &var] 默认按引用捕获，并按引用捕获 var，没有意义，会报 warning；
    8. [=, this] 默认按值捕获，并按值捕获 this 指针，没有意义，同样会报 warning；
    9. [this] 按值捕获 this 指针，this 指针虽然不能被修改，但其指向的对象可以被操作并修改，相当于按引用捕获了 this 指向的对象，即 [&(*this)]；
    10. [*this] 在 C++ 11 中不能按值捕获 this 指针指向的对象；
    ```
  * > 在使用捕获子句的时候，需要注意一些问题：
    + > 1. 不建议使用 2，3 这两种方式进行捕获（对性能影响较大），应该明确地指出需要按引用捕获的变量；
    + > 2. 按值捕获的变量是 read-only (const) 的，只有当匿名函数的可变规格被显式声明为 mutable 的时候才可以修改按值捕获的变量；

C++ lambda表达式与函数对象 https://www.jianshu.com/p/d686ad9de817

C++匿名函数的使用 https://www.cnblogs.com/yaya12138/p/11815475.html

C++ 匿名函数 https://blog.csdn.net/zhang14916/article/details/101058089

### 匿名函数调用其自身

C++ lambda 递归调用 https://segmentfault.com/q/1010000007759236
- > ***提前声明merge***，然后capture
  ```cpp
  std::function<void(int,int,int,int)> merge;
  merge = [&lst, &tmp, &merge](int first, int first_tail, int second, int second_tail) -> void {
      // 存在任一子串的长度大于 2 ，则将其拆分成两个子串归并
      int mid = 0;
      if (first_tail - first > 1) {
          mid = (first_tail + first) / 2;
          merge(first, mid, mid, first_tail);
      }
      if (second_tail - second > 1) {
          mid = (second_tail + second) / 2;
          merge(second, mid, mid, second_tail);
      }
      // 临时空间的索引
      int i = 0;
      // 归并操作,两个序列均未取完，则先取小的
      while (first < first_tail && second < second_tail) {
          tmp[i++] = lst[first] < lst[second] ? lst[first++] : lst[second++];
      }
      // 存在一个序列已经取完，则将另一序列剩下的元素取尽
      while (first < first_tail) tmp[i++] = lst[first++];
      while (second < second_tail) tmp[i++] = lst[second++];
      // 回填
      while (i--) lst[--second_tail] = tmp[i];
  };
  ```

Capture `*this` in lambda expression: Timeline of change https://www.nextptr.com/tutorial/ta1430524603/capture-this-in-lambda-expression-timeline-of-change

# LeeCode相关题目

`590. N 叉树的后序遍历` https://leetcode.cn/problems/n-ary-tree-postorder-traversal/submissions/503120342 || https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/401-600/000590/tran/000590.cpp
