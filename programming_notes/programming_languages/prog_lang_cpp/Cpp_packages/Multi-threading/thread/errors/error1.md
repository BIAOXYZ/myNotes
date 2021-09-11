
# 问题原来的描述和回答

C++ Thread: terminate called without an active exception https://stackoverflow.com/questions/37024545/c-thread-terminate-called-without-an-active-exception
- > I'm trying to create one array of integers without repeat. To get arrays of length more than 1000, it takes a lot of time to make. So, I thought using thread would be a good decision. But I'm writing something wrong. So far following are my code:
- > `utils.h`
```cpp
#ifndef UTILS_H
#define UTILS_H

typedef long long int64; typedef unsigned long long uint64;

class utils
{
    public:
        utils();
        virtual ~utils();
        static int getRandomNumberInRange(int min, int max);
        static int* getRandomArray(int size, bool isRepeatAllowed);

    protected:

    private:
};

#endif // UTILS_H
```
- > `utils.cpp`
```cpp
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cmath>
#include <vector>
#include <algorithm> // for std::find
#include <sys/time.h>
#include <cctype>
#include <string>
#include <thread>
#include <vector>

#include "utils.h"

utils::utils()
{

}

utils::~utils()
{

}
int utils::getRandomNumberInRange(int min, int max)
{
    if (min > max) {
        int aux = min;
        min = max;
        max = aux;
    }
    else if (min == max) {
        return min;
    }
    return (rand() % (max - min)) + min;
}

void getUniqueInteger(int* arr, int last, int* newVal)
{
    int val = *newVal;
    while(std::find(arr, arr+last, val) != arr+last)
    {
        val = utils::getRandomNumberInRange(10, 10000);
    }
    arr[last] = val;
}

int* utils::getRandomArray(int size, bool isRepeatAllowed)
{
    int* arr = new int[size], newVal = 0;
    std::vector<std::thread *> threadArr;

    for (int i = 0; i < size; i++)
    {
        newVal = utils::getRandomNumberInRange(10, 1000);
        if(!isRepeatAllowed)
        {
            std::thread newThread(getUniqueInteger, arr, i, &newVal);
            threadArr.push_back( &newThread);
        }
        else
        {
            arr[i] = newVal;
        }
    }

    int spawnedThreadCount = threadArr.size();

    if (spawnedThreadCount > 0)
    {
        for (int j = 0; j < spawnedThreadCount; j++)
        {
            threadArr[j]->join();
            //delete threadArr[j];
        }
    }

    return arr;
}
```
- > `main.cpp`
```cpp
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string>

#include "utils.h"

using namespace std;

int main(int argc, char *argv[])
{
  if (argc != 2 && utils::isInteger(argv[1]))
  {
    cout << "You have to provide an integer input to this program!!!" << endl;
    return 0;
  }

  int size = stoi( argv[1] );

  srand(time(NULL));

  int* arr = utils::getRandomArray(size, false);

  return 0;
}
```
- > Compiling by: `g++ -Wall -g -std=c++11 -pthread -o a.out ./utils.cpp ./main.cpp`
- > But, whenever I'm running the program by `./a.out 10`, it's terminating by giving the output:
  ```console
  terminate called without an active exception
  Aborted (core dumped)
  ```
- > Please help. Thanks in advance.

***回答***：
- https://stackoverflow.com/questions/37024545/c-thread-terminate-called-without-an-active-exception/37026636#37026636
  * > Your code that creates the thread creates a stack variable that is immediately destroyed. You need to change this:
    ```cpp
    if(!isRepeatAllowed)
    {
        std::thread newThread(getUniqueInteger, arr, i, &newVal);
        threadArr.push_back( &newThread);
    }
    ```
    > to this:
    ```cpp
    if(!isRepeatAllowed)
    {
        std::thread* newThread = new std::thread(getUniqueInteger, arr, i, &newVal);
        threadArr.push_back( newThread);
    }
    ```
    > Then uncomment your delete line later on.

# 个人实战

1. 首先原来题目里 `main.cpp` 代码有问题，那个入参合法性校验的 if 语句里 `utils::isInteger` 这个方法根本没有。不管是笔误还是啥，反正这个检验与核心逻辑无关，直接删了（顺便删一些空行）。

```cpp
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string>
#include "utils.h"
using namespace std;

int main(int argc, char *argv[])
{
  int size = stoi( argv[1] );
  srand(time(NULL));
  int* arr = utils::getRandomArray(size, false);
  return 0;
}
```

2. 头文件 `utils.h` 完全不用变，但是这里也删一下空行。

```cpp
#ifndef UTILS_H
#define UTILS_H

typedef long long int64; typedef unsigned long long uint64;

class utils
{
    public:
        utils();
        virtual ~utils();
        static int getRandomNumberInRange(int min, int max);
        static int* getRandomArray(int size, bool isRepeatAllowed);
    protected:
    private:
};
#endif // UTILS_H
```

3. 如果 `utils.cpp` 用原版，编译完成后运行 `./a.out 10` 确实会报题目里说的错误；如果按照回答的修改，注释掉原版换成回答里的版本，编过后可以正常运行。代码如下：

```cpp
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cmath>
#include <vector>
#include <algorithm> // for std::find
#include <sys/time.h>
#include <cctype>
#include <string>
#include <thread>
#include <vector>
#include "utils.h"

utils::utils() {}
utils::~utils() {}

int utils::getRandomNumberInRange(int min, int max)
{
    if (min > max) {
        int aux = min;
        min = max;
        max = aux;
    }
    else if (min == max) {
        return min;
    }
    return (rand() % (max - min)) + min;
}

void getUniqueInteger(int* arr, int last, int* newVal)
{
    int val = *newVal;
    while(std::find(arr, arr+last, val) != arr+last)
    {
        val = utils::getRandomNumberInRange(10, 10000);
    }
    arr[last] = val;
}

int* utils::getRandomArray(int size, bool isRepeatAllowed)
{
    int* arr = new int[size], newVal = 0;
    std::vector<std::thread *> threadArr;

    for (int i = 0; i < size; i++)
    {
        newVal = utils::getRandomNumberInRange(10, 1000);
        // if(!isRepeatAllowed)
        // {
        //     std::thread newThread(getUniqueInteger, arr, i, &newVal);
        //     threadArr.push_back( &newThread);
        // }
        if(!isRepeatAllowed)
        {
            std::thread* newThread = new std::thread(getUniqueInteger, arr, i, &newVal);
            threadArr.push_back( newThread);
        }
        else
        {
            arr[i] = newVal;
        }
    }

    int spawnedThreadCount = threadArr.size();

    if (spawnedThreadCount > 0)
    {
        for (int j = 0; j < spawnedThreadCount; j++)
        {
            threadArr[j]->join();
            //delete threadArr[j];
        }
    }
    
    return arr;
}
```

```sh
# 修改前
$ g++ -Wall -g -std=c++11 -pthread -o a.out ./utils.cpp ./main.cpp
./main.cpp: In function ‘int main(int, char**)’:
./main.cpp:22:8: warning: unused variable ‘arr’ [-Wunused-variable]
   int* arr = utils::getRandomArray(size, false);
        ^~~
$ ./a.out 10
terminate called without an active exception
Aborted (core dumped)
$ 

# 修改后
$ g++ -Wall -g -std=c++11 -pthread -o a.out ./utils.cpp ./main.cpp
./main.cpp: In function ‘int main(int, char**)’:
./main.cpp:22:8: warning: unused variable ‘arr’ [-Wunused-variable]
   int* arr = utils::getRandomArray(size, false);
        ^~~
$ ./a.out 10
$ 
```
