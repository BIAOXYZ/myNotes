
# 1

你见过最好的Makefile学习实例是什么？ - 极智视界的回答 - 知乎 https://www.zhihu.com/question/55488701/answer/2251580268

```sh
# 目录结构和使用
$ tree
.
└── proj_root
    └── src
        └── level1
            └── level2
                ├── sqlite
                │   ├── include
                │   │   └── sqlite_apis.h
                │   └── src
                │       └── sqlite_apis.cpp
                └── test
                    └── test_sqlite
                        ├── basic_sqlite_api_test.cpp
                        └── Makefile

9 directories, 4 files
$ cd proj_root/src/level1/level2/test/test_sqlite/
$ make
g++ -c -o sqlite_apis.o ../../sqlite/src/sqlite_apis.cpp -lsqlite3 -I../../../../../
g++ -o basic_sqlite_api_test basic_sqlite_api_test.cpp sqlite_apis.o -lsqlite3 -I../../../../../
$
$ ls
basic_sqlite_api_test  basic_sqlite_api_test.cpp  Makefile  sqlite_apis.o
$
$ make clean
rm -f basic_sqlite_api_test sqlite_apis.o test_db
$
$ ls
basic_sqlite_api_test.cpp  Makefile
```

```makefile
# 等价于在 Makefile 所在目录执行:
# g++ basic_sqlite_api_test.cpp ../../sqlite/src/sqlite_apis.cpp -lsqlite3 -I../../../../../

INCLUDES += -I../../../../../
LIBS += -lsqlite3
CXX = g++
TMP_TARGET = sqlite_apis.o
TARGET = basic_sqlite_api_test
TESTDB = test_db

$(TARGET): basic_sqlite_api_test.cpp $(TMP_TARGET)
	$(CXX) -o $(TARGET) basic_sqlite_api_test.cpp $(TMP_TARGET) $(LIBS) $(INCLUDES)

$(TMP_TARGET): ../../sqlite/src/sqlite_apis.cpp ../../sqlite/include/sqlite_apis.h
	$(CXX) -c -o $(TMP_TARGET) ../../sqlite/src/sqlite_apis.cpp $(LIBS) $(INCLUDES)

.PHONY: clean
clean:
	rm -f $(TARGET) $(TMP_TARGET) $(TESTDB)
```
