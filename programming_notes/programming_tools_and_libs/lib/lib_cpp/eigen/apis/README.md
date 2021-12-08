
Slicing and Indexing https://eigen.tuxfamily.org/dox/group__TutorialSlicingIndexing.html
- > **Array of indices**
  * > The generic `operator()` can also takes as input an arbitrary list of row or column indices stored as either an `ArrayXi`, a `std::vector<int>`, `std::array<int,N>`, etc.
    ```cpp
    std::vector<int> ind{4,2,5,5,3};
    MatrixXi A = MatrixXi::Random(4,6);
    cout << "Initial matrix A:\n" << A << "\n\n";
    cout << "A(all,ind):\n" << A(all,ind) << "\n\n";
    ```
    > Output:
    ```console
    Initial matrix A:
      7   9  -5  -3   3 -10
     -2  -6   1   0   5  -5
      6  -3   0   9  -8  -8
      6   6   3   9   2   6
    
    A(all,ind):
      3  -5 -10 -10  -3
      5   1  -5  -5   0
     -8   0  -8  -8   9
      2   3   6   6   9
    ```
