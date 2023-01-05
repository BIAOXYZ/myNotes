
# 1

【[:star:][`*`]】 c++ 获取占用内存 https://www.csdn.net/tags/MtTaEgysNjM5LWJsb2cO0O0O.html  【服了，这个帖子不知道为什么没了。。。最后在谷歌的缓存里找到的。。。】
- > 在Linux C++程序中获取进程占用内存、机器内存的方法：
```cpp
#include <unistd.h>
#include <cstring>
#include <iostream>

using namespace std;

int get_memory_by_pid(pid_t pid) {
  FILE* fd;
  char line[1024] = {0};
  char virtual_filename[32] = {0};
  char vmrss_name[32] = {0};
  int vmrss_num = 0;
  sprintf(virtual_filename, "/proc/%d/status", pid);
  fd = fopen(virtual_filename, "r");
  if(fd == NULL) {
    cout << "open " << virtual_filename << " failed" << endl;
    exit(1);
  }

  // VMRSS line is uncertain
  for(int i = 0 ; i < 60; i++) {
    if(strstr(line, "VMRSS:") != NULL) {
      sscanf(line, "%s %d", vmrss_name, &vmrss_num);
      break;
    }
  }
  fclose(fd);
  return vmrss_num;
}

int get_machine_memory() {
  const char* virtual_filename = "/proc/meminfo";
  FILE* fd;

  char line[1024] = {0};
  fd = fopen(virtual_filename, "r");
  if(fd == NULL) {
    cout << "open " << virtual_filename << " failed" << endl;
    exit(1);
  }
  char vmrss_name[32];
  int machine_memory;
  fgets(line, sizeof(line), fd);
  sscanf(line, "%s %d", vmrss_name, &machine_memory);
  fclose(fd);
  return machine_memory;
}

int main() {
  cout << "The current process consumes " << get_memory_by_pid(getpid()) / 1024 << "MB memory" << endl;
  cout << "The machine memory: " << get_machine_memory() / 1024 << "MB memory" << endl;
  return 0;
}
```
```console
The current process consumes 0MB memory
The machine memory: 15393MB memory
```
