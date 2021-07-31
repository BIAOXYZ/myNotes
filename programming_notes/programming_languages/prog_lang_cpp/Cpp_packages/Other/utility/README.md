
# 官方

`header <utility>` http://www.cplusplus.com/reference/utility/
- **Functions**
  * std::forward http://www.cplusplus.com/reference/utility/forward/
  * std::move http://www.cplusplus.com/reference/utility/move/
    + > Generally, ***<ins>`rvalues` are values whose address cannot be obtained by dereferencing them</ins>***, either because they are literals or because they are temporary in nature (such as values returned by functions or explicit constructor calls). By passing an object to this function, an rvalue that refers to it is obtained.
    + > Many components of the standard library implement ***move semantics***, allowing to transfer ownership of the assets and properties of an object directly without having to copy them when the argument is an `rvalue`.
    + > Although note that -in the standard library- moving implies that the moved-from object is left in a valid but unspecified state. Which means that, after such an operation, the value of the moved-from object should only be destroyed or assigned a new value; accessing it otherwise yields an unspecified value.
- **Types**
  * std::pair https://www.cplusplus.com/reference/utility/pair/ 【这个不应该实现在 `<unordered_map>` 里才更适合嘛？】

`Standard library header <utility>` https://en.cppreference.com/w/cpp/header/utility
- **Type support**
  * std::size_t https://en.cppreference.com/w/cpp/types/size_t
  * std::nullptr_t https://en.cppreference.com/w/cpp/types/nullptr_t
- **Swap and type operations**
  * std::forward https://en.cppreference.com/w/cpp/utility/forward
  * std::move https://en.cppreference.com/w/cpp/utility/move
