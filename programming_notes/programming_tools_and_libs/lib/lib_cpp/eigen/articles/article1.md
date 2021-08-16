
Matrix Manipulations in C++ using Eigen Library https://iamfaisalkhan.com/matrix-manipulations-using-eigen-cplusplus/
- > [Eigen]() is an open source C++ library optimized for handling numeric operations such as addition, subtraction, multiplication etc. of matrices and arrays along with solving linear systems. Eigen is feature rich and highly optimized. It offers explicit vectorized instruction for multiple platforms. Its use of [C++ expression templates](https://en.wikipedia.org/wiki/Expression_templates) allow it to ***intelligently avoid temporary variables and enable lazy evaluation***. The library is very similar in function to the popular Python’s [Numpy]().
- > **Dynamic Size Matrices**
  * > Whenever you have a choice between dynamic or fixed size Matrix, the fixed size one will typically be more optimized. The fixed size matrices avoids dynamic memory allocation and are further optimized using [loop unrolling](https://en.wikipedia.org/wiki/Loop_unrolling).
- > **The `Array` Class**
  * > The multiplication, division and similar operations offered by the Matrix class are done following the linear algebra rules. ***In order to use co-efficient (or element-wise) operations, we have to use the the `Array` class***. This class is very similar in declaration to the `Matrix` class.
  * > Just like in the case of the `Matrix` class, we can use the typedef notations of `ArrayNt` for 1-dimensional arrays. The multi-dimensional arrays are defined as `ArrayXXt`, where the XX specify the dimensions and t is used for data type. As an example consider defining two 2-D arrays and then multiplying them together. ***Here multiplication will take place <ins>element wise</ins>***.
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
  * > The raw C/C++ buffers can be interfaced with `Eigen` using the ***`Map`*** class. The `Map` object has a type defined as:
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
    + > The `Stride` class has two parameters: (i) `OuterStrideAtComileTime` (***value `6` above***) and (ii) `InnerStrideAtCompileTime` (***value `2` above***).
    + > The **inner stride** controls how many elements to skip ***between two consecutive entries within a given column (row)*** for column-major (row-major) matrix.
    + > The **outer stride** specifies the increment ***between two consecutive columns (rows)*** of a column-major (row-major) matrix.
    + > In the example above, we used an outer stride of 6 and an inner stride of 2. The ***outer stride of 6 will skip over 6 elements between each column***. More specifically, ***the first column will start at the first elements and the second column will start at the 7th element***. The ***inner stride of 2 means that we want to skip an element within the consecutive elements of a given column***.
    + > The figure below show this example visually using both column-major and row-major order.
    + > ![](https://iamfaisalkhan.com/content/images/size/w1600/2021/05/strides_example1.png)
- > **Performing Basic Operations**
  * > `Eigen` supports a variety of basic arithmetic operations. The `Matrix` class provides overloaded arithmetic functions that supports linear-algebra operations. ***The element-wise or other mixed operations can be performed through the `Array` interface***.
  * > Similarly, we can multiply and divide by a scalar variable:
    ```cpp
    Eigen::MatrixXf A (2, 2);
    A << 4, 7,
         8, 9;
    
    // Scale the matrix values by 2. 
    Eigen::MatrixXf C = A * 2;
    // Same as above without assigning the values to an additional Matrix. 
    A *= 0.5;
    ```
  * > ***All operations involving vectors are just the special case of `Nx1 matrix`***. You can multiply a matrix with a vector as long as the rules of matrix-vector multiplication are satisfied.
- > **Block Operations**
- > **Slicing**
  * > There is no direct support for slicing in `Eigen` as yet. If you are familiar with `Numpy`, slicing is a very handy feature. However, we can use the `Map` class to mimic this feature. The `data()` interface of a matrix or array gives us direct access (***pointer***) to the the underlying storage of the matrix class and combining that with `Map`, we can slice the data in any way.
  * > Lets look at few examples of slicing columns of an existing matrix.
    ```cpp
    Matrix4i A;
    A << 1, 2, 3, 4,
         5, 6, 7, 8,
         9, 10, 11, 12,
         13, 14, 15, 16;
    cout<<"Original Matrix \n"<<A<<endl;
    
    // Using the raw pointer to underlying storage, we can use the Map class to slice a matrix.  
    Map<MatrixXi> B(A.data(), 4, 2);
    
    cout<<"Slicing first two columns \n"<<B<<endl;//  1  2
                                                  //  5  6
                                                  //  9 10
                                                  // 13 14
    // Some pointer arithmetic to skip the first eight values (two columns). 
    Map<MatrixXi> C(A.data()+8, 4, 2);
    cout<<"Slicing last two columns \n"<<C<<endl; //  3  4
                                                  //  7  8
                                                  // 11 12
                                                  // 15 16
    ```
  * > Similarly, we can pair the `Map` with the `Stride` for more complex options of slicing. For example, the following code, will fetch the first and third column from above Matrix A.
    ```cpp
    Map<MatrixXi, 0, OuterStride<8>> B(A.data(), 4, 2);
    
    // Or
    
    Map<MatrixXi, 0, OuterStride<>> B(A.data(), 4, 2, OuterStride<>(8)
    ```
  * > Here, we have used the `OuterStride` interface with the stride value of 8. The `OuterStride` and similarly `InnerStride` are convenient specialization classes of `Stride` with the one of the value set to 0. For instance, the `OuterStride` is same as using `Stride <Value, 0>`.
  * > Few examples of slicing rows:
    ```cpp
    // Slicing first two rows. 
    Map<MatrixXi, 0, OuterStride<4>>(A.data(), 2, 4)// 1 2 3 4
                                                    // 5 6 7 8
    
    // Slicing first and third row. 
    Map<MatrixXi, 0, Stride<4, 2>>(A.data(), 2, 4) // 1  2  3  4
                                                   // 9 10 11 12
    ```
- > **Broadcasting**
  * > Broadcasting is the idea of constructing an intermediate representation of a vector by replicating its entries in one direction (rows or columns) such that it is possible to perform an operation on a different sized matrix. `Eigen` supports broadcasting. Here is a simple example of ***adding a vector to the matrix***.
    ```cpp
    int data[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    
    Map<Matrix3i> A(data);
    cout<<"Matrix A \n"<<A<<endl; // 1 4 7
                                  // 2 5 8
                                  // 3 6 9
    
    Vector3i B;
    B << 4, 5, 6;
    cout<<"Vector B\n"<<B<<endl; // 4
                                 // 5
                                 // 6
    
    //  Broadcast to columns
    cout<<A.colwise()+B<<endl;  // 5  8 11
                                // 7 10 13
                                // 9 12 15
    
    // Broadcast to rows 
    cout<<A.rowwise()+B.transpose()<<endl; // 5  9 13
                                           // 6 10 14
                                           // 7 11 15
    ```
- > **Summary**
  * > Eigen is a feature rich library that offers many additional features including support for linear solvers, sparse matrices, and multi-threading through `OpenMP` to name just the few. In a future post, we will try to cover some of these topics in more detail.
- > **Reference**
  * > Code for the Blog: https://github.com/n-log-n/Eigen_Tutorial
  * > Official Documentation: http://eigen.tuxfamily.org/dox-3.2/group__TutorialMatrixClass.html
