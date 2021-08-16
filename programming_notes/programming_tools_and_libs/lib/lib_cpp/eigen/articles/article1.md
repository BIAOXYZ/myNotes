
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
- > **Using existing data**
  * > The raw C/C++ buffers can be interfaced with `Eigen` using the `Map` class. The `Map` object has a type defined as:
    ```cpp
    Map< Matrix<typename Scalar, int RowsAtCompileTime, int ColsAtCompileTime> >
    ```
  * > The main argument supplied to the `Map`’s’ template is of type `Eigen::Matrix`. Thus, the data type and number of elements in the buffer being interfaced should match the supplied matrix type.
  * > In the example below we interface an integer array of length 9 to 3 by 3 matrix.
    ```cpp
    int data[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    
    cout<<"Column Major 3 by 3 Matrix"<<endl;
    Map<Matrix<int, 3, 3>> A(data, 3, 3);
    cout<<A<<endl;
    // 1 4 7
    // 2 5 8
    // 3 6 9
    ```
  * > By default the `Eigen` library uses ***column-major*** order to process the data within the raw buffer. However this can be changed by explicitly specifying the storage order of the underlying `Matrix`.
    ```cpp
    cout<<"Row Major 3 by 3 Matrix"<<endl;
    Map<Matrix<int, 3, 3, RowMajor>> B(data);
    cout<<B<<endl;             
    // 1 2 3
    // 4 5 6
    // 7 8 9
    ```
  * > An additional argument to the `Map` is the **`Stride`**. ***The stride offers further control over the layout of the data*** being processed from the raw buffer. For example, in the following example, we are skipping over an element while interfacing with the raw buffer.
    ```cpp
    int data[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    
    Map<Matrix<int, 3, 2>, 0, Stride<6, 2>> A(data);
    cout<<A<<endl;        
    // 1  7
    // 3  9
    // 5 11
    ```
