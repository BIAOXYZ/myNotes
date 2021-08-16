
Matrix Manipulations in C++ using Eigen Library https://iamfaisalkhan.com/matrix-manipulations-using-eigen-cplusplus/
- > [Eigen]() is an open source C++ library optimized for handling numeric operations such as addition, subtraction, multiplication etc. of matrices and arrays along with solving linear systems. Eigen is feature rich and highly optimized. It offers explicit vectorized instruction for multiple platforms. Its use of [C++ expression templates](https://en.wikipedia.org/wiki/Expression_templates) allow it to ***intelligently avoid temporary variables and enable lazy evaluation***. The library is very similar in function to the popular Python’s [Numpy]().
- > **Dynamic Size Matrices**
  * > Whenever you have a choice between dynamic or fixed size Matrix, the fixed size one will typically be more optimized. The fixed size matrices avoids dynamic memory allocation and are further optimized using [loop unrolling](https://en.wikipedia.org/wiki/Loop_unrolling).
- > **The `Array` Class**
  * > The multiplication, division and similar operations offered by the Matrix class are done following the linear algebra rules. ***In order to use co-efficient (or element-wise) operations, we have to use the the `Array` class***. This class is very similar in declaration to the `Matrix` class.
  * > Just like in the case of the `Matrix` class, we can use the typedef notations of `ArrayNt` for 1-dimensional arrays. The multi-dimensional arrays are defined as `ArrayXXt`, where the XX specify the dimensions and t is used for data type. As an example consider defining two 2-D arrays and then multiplying them together. ***Here multiplication will take place element wise***.
    ```cpp
    Eigen::Array22d;
    A << 1, 4,
         8, 9;
    
    Eigen::ArrayXXd B(2, 2);
    B << 2, 5,
         1, 3;
    
    cout << "Array A \n" << A <<endl;
    cout << "Array B \n" << B <<endl;
    cout << "Element wise multiplication of A * B\n" << (A * B)<<endl;
    
    // 2 20
    // 8 27
    ```
- > **Array Interface to Matrix**
  * > Instead of explicitly defining an `Array` object for element-wise operations, we have the option of using the array interface of an existing `Matrix` objects to do mix types of operations.
- > **Special Matrices and Arrays**
  * > Another way to initialize matrices and arrays is using the static methods like `Zero()`, `Ones()`, `Identity()` or `Random()`.
