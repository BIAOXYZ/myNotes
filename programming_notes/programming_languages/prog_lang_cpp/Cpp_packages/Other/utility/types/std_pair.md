
# 官方

std::pair https://www.cplusplus.com/reference/utility/pair/

std::pair https://en.cppreference.com/w/cpp/utility/pair

# 其他

C++ pair的基本用法总结（整理） https://blog.csdn.net/sevenjoin/article/details/81937695
- > 定义(构造函数)：
  ```console
  pair<T1, T2> p1;            //创建一个空的pair对象（使用默认构造），它的两个元素分别是T1和T2类型，采用值初始化。
  pair<T1, T2> p1(v1, v2);    //创建一个pair对象，它的两个元素分别是T1和T2类型，其中first成员初始化为v1，second成员初始化为v2。
  make_pair(v1, v2);          // 以v1和v2的值创建一个新的pair对象，其元素类型分别是v1和v2的类型。
  p1 < p2;                    // 两个pair对象间的小于运算，其定义遵循字典次序：如 p1.first < p2.first 或者 !(p2.first < p1.first) && (p1.second < p2.second) 则返回true。
  p1 == p2；                  // 如果两个对象的first和second依次相等，则这两个对象相等；该运算使用元素的==操作符。
  p1.first;                   // 返回对象p1中名为first的公有数据成员
  p1.second;                 // 返回对象p1中名为second的公有数据成员
  ```
- > 5，通过tie获取pair元素值
  * > 在某些清况函数会以pair对象作为返回值时，可以直接通过`std::tie`进行接收。比如：
    ```cpp
    std::pair<std::string, int> getPreson() {
        return std::make_pair("Sven", 25);
    }
    
    int main(int argc, char **argv) {
        std::string name;
        int ages;
     
        std::tie(name, ages) = getPreson();
     
        std::cout << "name: " << name << ", ages: " << ages << std::endl;
     
        return 0;
    }
    ```

Initialize a std::pair in C++ https://www.techiedelight.com/initialize-a-stdpair-cpp/
