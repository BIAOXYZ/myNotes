
# vector里的元素也要考虑内存管理

【vectorの奇技淫巧】C++ vector 如何正确处理动态申请内存的元素 https://juejin.cn/post/6988156280133124110

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vector与指针

指向vector的指针及空间释放问题 https://bbs.csdn.net/topics/320050082
```cpp
#include <vector>
int main()
{
    vector<int>* p=new vector<int>(10,3); //初始化10个元素 都为3
    vector<int>* zz=new vector<int>(5,6); //初始化5个元素 都为6
    delete p; //销毁 p指向的空间？？？
    p=zz; //zz交给p， 这样是否p就是 5个6 了？{}
}
```
- > 恩，对的。 <br> `delete *p` 只是删除 `p指针` 所指向的空间，当执行 `delete *p` 后，`指针*p` 还是存在的，但是 `*p` 指向一个已删除的内存空间，`*p` 就成了一个***悬挂指针***。如果之后还对 `*p` 操作，会造成灾难性的后果。 <br> 一般情况下，`delete *p` 后可以令 `p=0`，表示不指向任何内存空间，或者像楼主一样重新赋值也可以。

c++ vector指针访问vector元素的两种方法 https://blog.csdn.net/COCO56/article/details/88907016

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vector size and capacity

`std::vector::capacity` https://www.cplusplus.com/reference/vector/vector/capacity/

`std::vector<T,Allocator>::capacity` https://en.cppreference.com/w/cpp/container/vector/capacity

C++ STL 之 vector 的 capacity 和 size 属性区别 https://www.runoob.com/note/27430

vector capacity() function in C++ STL https://www.geeksforgeeks.org/vector-capacity-function-in-c-stl/

## 个人实战

```cpp
#include <iostream>
#include <vector>
using namespace std;
int main(void){

    vector<int> v1(5);
    cout << "The size of v1 is: " << v1.size() << endl;
    for (int i = 0; i < v1.size(); ++i) v1[i] = i;
    for (int i = 0; i < v1.size(); ++i) cout << v1[i] << endl;
    
    v1[5] = 5;
    v1[6] = 6;
    cout << v1[5] << "---" << v1[6] << endl;
    
    v1[10] = 10;
    v1[11] = 11;
    cout << v1[9] << "---" << v1[10] << "---" << v1[11] << endl;
    
    // 如果放开注释，下面 v2 的 size 就打不出来了。
    // v1[100000000] = 100000000;
    // cout << v1[9] << v1[100000000] << endl;
    
    vector<int> v2;
    cout << "The size of v2 is: " << v2.size() << endl;
    for (int i = 0; i < v2.size(); ++i) v2[i] = i;
    for (int i = 0; i < v2.size(); ++i) cout << v2[i] << endl;
    
    return 0;
}
```
```cpp
// 在 paiza.io 的输出是这样的：
The size of v1 is: 5
0
1
2
3
4
5---6
1702496822---757936690---926234413
The size of v2 is: 0
```
```cpp
// 在 cpp.sh 的输出是这样的：
The size of v1 is: 5
0
1
2
3
4
5---6
0---10---11
The size of v2 is: 0
```
