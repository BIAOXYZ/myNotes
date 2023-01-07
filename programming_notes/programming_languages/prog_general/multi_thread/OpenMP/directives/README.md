
2 Directives https://www.openmp.org/spec-html/5.0/openmpch2.html

OpenMP Directives https://learn.microsoft.com/en-us/cpp/parallel/openmp/reference/openmp-directives

# `collapse()`

Understanding the collapse clause in openmp https://stackoverflow.com/questions/28482833/understanding-the-collapse-clause-in-openmp
- https://stackoverflow.com/questions/28482833/understanding-the-collapse-clause-in-openmp/28483812#28483812
  * > The problem with your code is that the iterations of the inner loop depend on the outer loop. According to the OpenMP specification under the description of the section on binding and the `collapse` clause: <br> `If execution of any associated loop changes any of the values used to compute any of the iteration counts, then the behavior is unspecified.`
  * > You can use collapse when this is not the case for example with a square loop
    ```cpp
    #pragma omp parallel for private(j) collapse(2)
    for (i = 0; i < 4; i++)
        for (j = 0; j < 100; j++)
    ```
  * > In fact this is a good example to show when to use `collapse`. ***The outer loop only has four iterations. If you have more than four threads then some will be wasted***. But when you `collapse` ***the threads will distribute among 400 iterations which is likely to be much greater than the number of threads***. Another reason to use collapse is if the load is not well distributed. If you only used four iterations and the fourth iteration took most of the time the other threads wait. But if you use 400 iterations the load is likely to be better distributed.
  * > You can fuse a loop by hand for the code above like this
    ```cpp
    #pragma omp parallel for
    for(int n=0; n<4*100; n++) {
        int i = n/100; int j=n%100;
    ```
  * > [Here](https://stackoverflow.com/questions/18749493/openmp-drastically-slows-down-for-loop/18763554#18763554) is an example showing how to fuse a triply fused loop by hand.
  * > Finally, [here](https://stackoverflow.com/questions/24013832/fusing-a-triangle-loop-for-parallelization-calculating-sub-indices) is an example showing how to fuse a triangular loop which collapse is not defined for.
