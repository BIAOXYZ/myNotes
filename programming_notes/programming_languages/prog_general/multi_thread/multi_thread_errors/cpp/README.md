
linux下多线程C++运行时间统计 https://blog.csdn.net/u012526003/article/details/80862801
- > **clock**
  * > clock函数在ctime中，用于统计cpu时钟时间，***在程序是单线程时，相对准确，但是如果开启多线程，则会出现很大误差***。如下面的程序
  * > 运行需要1s左右，但是会记录10s左右的时间，***因为每个线程中，cpu的clock都在计数***，因此这个时间是不准确的。