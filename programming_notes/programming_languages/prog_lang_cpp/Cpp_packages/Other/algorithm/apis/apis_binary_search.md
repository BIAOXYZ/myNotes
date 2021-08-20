
C++ STL中的Binary search（二分查找） https://www.cnblogs.com/wkfvawl/p/9475939.html
- > **二.常用操作**
  * > 1.`binary_search`：查找某个元素是否出现。
  * > 2.`lower_bound`：查找第一个大于或等于某个元素的位置。
  * > 3.`upper_bound`：查找第一个大于某个元素的位置。
- > **三、代码**
```cpp
#include<iostream>
#include<algorithm>
using namespace std;
int main()
{
    int a[100]= {4,10,11,30,69,70,96,100};
    int b=binary_search(a,a+9,4);//查找成功，返回1
    cout<<"在数组中查找元素4，结果为："<<b<<endl;
    int c=binary_search(a,a+9,40);//查找失败，返回0
    cout<<"在数组中查找元素40，结果为："<<c<<endl;
    int d=lower_bound(a,a+9,10)-a;
    cout<<"在数组中查找第一个大于等于10的元素位置，结果为："<<d<<endl;
    int e=lower_bound(a,a+9,101)-a;
    cout<<"在数组中查找第一个大于等于101的元素位置，结果为："<<e<<endl;
    int f=upper_bound(a,a+9,10)-a;
    cout<<"在数组中查找第一个大于10的元素位置，结果为："<<f<<endl;
    int g=upper_bound(a,a+9,101)-a;
    cout<<"在数组中查找第一个大于101的元素位置，结果为："<<g<<endl;
}
//////////////////////////////////////////////////
在数组中查找元素4，结果为：1
在数组中查找元素40，结果为：0
在数组中查找第一个大于等于10的元素位置，结果为：1
在数组中查找第一个大于等于101的元素位置，结果为：9
在数组中查找第一个大于10的元素位置，结果为：2
在数组中查找第一个大于101的元素位置，结果为：9
```
