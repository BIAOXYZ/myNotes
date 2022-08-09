
# 1

c++中vector做形参传递的三种形式 https://blog.csdn.net/zou_albert/article/details/108221004
- > c++中常用的vector容器作为参数时，有三种传参方式，分别如下（为说明问题，用二维vector）：
  ```cpp
  function1(std::vector<std::vector > vec)，传值
  function2(std::vector<std::vector >& vec)，传引用
  function3(std::vector<std::vector >* vec)，传指针
  ```
- > 三种方式对应的调用形式分别为：
  ```cpp
  function1(vec)，传入值
  function2(vec)，传入引用
  function3(&vec), 传入地址
  ```

## 个人实战文章代码

```cpp
#include <iostream>
#include <vector>
using namespace std;

void function1(std::vector<std::vector<int> > vec)
{
    cout<<"-----------------------------------------"<<endl;
    //打印vec的地址
    cout<<"function1.&vec:"<<&vec<<endl;
    //打印vec[i]的地址（即第一层vector的地址）
    cout<<"function1.&vec[i]:"<<endl;
    for(int i=0;i<2;i++)
        cout<<&vec[i]<<endl;
    //打印vec的各元素地址
    cout<<"function1.&vec[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<&vec[i][j]<<" ";
        cout<<endl;
    }
    cout<<"---------------------------"<<endl;
    //打印vec的各元素值
    cout<<"function1.vec[i][j]:"<<endl;
    vec[0][0] = 10000;//进行修改的
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<vec[i][j]<<" ";
        cout<<endl;
    }
}
void function2(std::vector<std::vector<int> >& vec)
{
    cout<<"-----------------------------------------"<<endl;
    //打印vec的地址
    cout<<"function2.&vec:"<<&vec<<endl;
    //打印vec[i]的地址（即第一层vector的地址）
    cout<<"function2.&vec[i]:"<<endl;
    for(int i=0;i<2;i++)
        cout<<&vec[i]<<endl;
    //打印vec的各元素地址
    cout<<"function2.&vec[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<&vec[i][j]<<" ";
        cout<<endl;
    }
    cout<<"---------------------------"<<endl;
    //打印vec的各元素值
    cout<<"function2.vec[i][j]:"<<endl;
    vec[0][0] = 10000;//进行修改的
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<vec[i][j]<<" ";
        cout<<endl;
    }
}
void function3(std::vector<std::vector<int> > *vec)
{
    cout<<"-----------------------------------------"<<endl;
    //打印vec的地址
    cout<<"function3.&vec:"<<vec<<endl;
    //打印vec[i]的地址（即第一层vector的地址）
    cout<<"function3.&vec[i]:"<<endl;
    for(int i=0;i<2;i++)
        cout<<&(*vec)[i]<<endl;
    //打印vec的各元素地址
    cout<<"function3.&vec[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<&(*vec)[i][j]<<" ";
        cout<<endl;
    }
    cout<<"---------------------------"<<endl;
    //打印vec的各元素值
    cout<<"function3.vec[i][j]:"<<endl;
    (*vec)[0][0] = 10000;//进行修改的
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<(*vec)[i][j]<<" ";
        cout<<endl;
    }
}

int main()
{
    //创建2*3的vector容器v,初始值均初始化为0 1 2 1 2 3
    std::vector<std::vector<int> > v(2,std::vector<int>(3,0));
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            v[i][j]=i+j;
    }

    //打印v的地址
    cout<<"&v:"<<&v<<endl;
    //打印v[i]的地址（即第一层vector的地址）
    cout<<"&v[i]:"<<endl;
    for(int i=0;i<2;i++)
        cout<<&v[i]<<endl;
    //打印v的各元素地址
    cout<<"&v[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<&v[i][j]<<" ";
        cout<<endl;
    }

    cout<<"---------------------------"<<endl;
    //打印v的各元素值
    cout<<"v[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<v[i][j]<<" ";
        cout<<endl;
    }

    function1(v);

    cout<<"---------------------------"<<endl;
    //打印v的各元素值
    cout<<"v[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<v[i][j]<<" ";
        cout<<endl;
    }

    function2(v);

    cout<<"---------------------------"<<endl;
    //打印v的各元素值
    cout<<"v[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<v[i][j]<<" ";
        cout<<endl;
    }

    function3(&v);
    
    cout<<"---------------------------"<<endl;
    //打印v的各元素值
    cout<<"v[i][j]:"<<endl;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<3;j++)
            cout<<v[i][j]<<" ";
        cout<<endl;
    }
    return 0;
}
```
```console
&v:0x7ffec9980130
&v[i]:
0x55a84167bed0
0x55a84167bee8
&v[i][j]:
0x55a84167bf10 0x55a84167bf14 0x55a84167bf18 
0x55a84167bf30 0x55a84167bf34 0x55a84167bf38 
---------------------------
v[i][j]:
0 1 2 
1 2 3 
-----------------------------------------
function1.&vec:0x7ffec9980150
function1.&vec[i]:
0x55a84167c360
0x55a84167c378
function1.&vec[i][j]:
0x55a84167beb0 0x55a84167beb4 0x55a84167beb8 
0x55a84167c3a0 0x55a84167c3a4 0x55a84167c3a8 
---------------------------
function1.vec[i][j]:
10000 1 2 
1 2 3 
---------------------------
v[i][j]:
0 1 2 
1 2 3 
-----------------------------------------
function2.&vec:0x7ffec9980130
function2.&vec[i]:
0x55a84167bed0
0x55a84167bee8
function2.&vec[i][j]:
0x55a84167bf10 0x55a84167bf14 0x55a84167bf18 
0x55a84167bf30 0x55a84167bf34 0x55a84167bf38 
---------------------------
function2.vec[i][j]:
10000 1 2 
1 2 3 
---------------------------
v[i][j]:
10000 1 2 
1 2 3 
-----------------------------------------
function3.&vec:0x7ffec9980130
function3.&vec[i]:
0x55a84167bed0
0x55a84167bee8
function3.&vec[i][j]:
0x55a84167bf10 0x55a84167bf14 0x55a84167bf18 
0x55a84167bf30 0x55a84167bf34 0x55a84167bf38 
---------------------------
function3.vec[i][j]:
10000 1 2 
1 2 3 
---------------------------
v[i][j]:
10000 1 2 
1 2 3 
```
