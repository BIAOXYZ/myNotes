
# 基本接口

## 检测文件是否存在

The best way to check if a file exists using standard C/C++ https://www.tutorialspoint.com/the-best-way-to-check-if-a-file-exists-using-standard-c-cplusplus
- > **In C**
  * > Example
    ```c
    #include<stdio.h>
    int main() {
    /* try to open file to read */
    FILE *file;
    if (file = fopen("a.txt", "r")) {
        fclose(file);
        printf("file exists");
    } else {
        printf("file doesn't exist");
    }
    }
    ```
  * > Output
    ```console
    file exists
    ```
- > **In C++**
  * > Example
    ```c++
    #include <fstream>
    #include<iostream>
    using namespace std;
    int main() {
    /* try to open file to read */
    ifstream ifile;
    ifile.open("b.txt");
    if(ifile) {
        cout<<"file exists";
    } else {
        cout<<"file doesn't exist";
    }
    }
    ```
  * > Output
    ```console
    file doesn't exist
    ```
