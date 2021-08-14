
C语言结构体末端定义空数组 https://blog.csdn.net/Sophisticated_/article/details/83059189
- > 在某些情况，数据结构末端会定义一个可选区域，如下所示：
  ```c
  struct abc
  {
  	int age;
  	char *name[20];
  	...
  	char placeholder[0];
  }
  ```
- > 而结构体最后使用0长度数组的原因，主要是为了方便的管理内存缓冲区，如果你直接使用指针而不使用数组，那么，你在分配内存缓冲区时，就必须分配结构体一次，然后再分配结构体内的指针一次，（而此时分配的内存已经与结构体的内存不连续了，所以要分别管理即申请和释放）而如果使用数组，那么只需要一次就可以全部分配出来，反过来，释放时也是一样，使用数组，一次释放，使用指针，得先释放结构体内的指针，再释放结构体。还不能颠倒次序。
- > 使用空数组：
  * > 不需要初始化，数组名直接就是所在的偏移 。
  * > 不占任何空间，指针需要占用4字节（32位）/8字节（64位）长度空间，空数组不占任何空间。