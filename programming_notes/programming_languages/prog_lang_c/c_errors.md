
# general

C语言常见编译错误及分析 https://blog.csdn.net/Changxing898/article/details/100869032

# concrete

##

错误：reference to non-static member function must be called https://blog.csdn.net/u010982765/article/details/79021426

## `empty character constant`

error C2137: empty character constant https://blog.51cto.com/u_15323215/3278363
- > 案例：
  ```c
  #include<stdio.h>
  int main()
  {
      const char a='';
  	printf("%c",a);
  	return 0;
  }
  ```
- > 错误分析：
  * > 原因是连用了两个单引号，而中间没有任何字符。***一般的，单引号表示字符型常量，单引号中必须有，也只能有一个字符***（使用转义符时，转义符所表示的字符当作一个字符看待）。两个单引号之间不加任何内容是不允许的。

Empty character constant in C++ https://stackoverflow.com/questions/31193454/empty-character-constant-in-c
- https://stackoverflow.com/questions/31193454/empty-character-constant-in-c/31193498#31193498
  * > This line:
    ```cpp
    m_pchString[m_nLength-1] = '';
    ```
  * > What you probably mean is:
    ```cpp
    m_pchString[m_nLength-1] = '\0';
    ```
  * > Or even:
    ```cpp
    m_pchString[m_nLength-1] = 0;
    ```
  * > Strings are zero terminated, which is written as a plain `0` or the null character `'\0'`. ***For double quote strings `""` the zero termintation character is implicitly added to the end, but since you explicitly set a single character you must specify which***.
