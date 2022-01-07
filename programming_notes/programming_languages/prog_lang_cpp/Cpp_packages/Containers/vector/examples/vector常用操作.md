
# vector extend

C++ extend a vector with another vector https://stackoverflow.com/questions/313432/c-extend-a-vector-with-another-vector
- https://stackoverflow.com/questions/313432/c-extend-a-vector-with-another-vector/313444#313444
  * > From [here](http://www.cplusplus.com/reference/vector/vector/insert/)
    ```cpp
    // reserve() is optional - just to improve performance
    v.reserve(v.size() + distance(v_prime.begin(),v_prime.end()));
    v.insert(v.end(),v_prime.begin(),v_prime.end());
    ```
