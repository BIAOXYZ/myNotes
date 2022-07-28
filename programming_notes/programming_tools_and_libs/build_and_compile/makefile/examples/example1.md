
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

**`Makefile`**
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

**`sqlite_apis.h`**
```cpp
#pragma once
#include <sqlite3.h>
#include <string>
#include <vector>

using std::string;
using std::vector;
using std::pair;

int create_db(const string &db_path);
int delete_db(const string &db_path);
sqlite3 *open_db(const string &db_path);
int close_db(sqlite3 *db);
int create_tb_from_sql(const string &sql, const string &db_path);
int execute_sql_without_returned_data(const string &sql, const string &db_path);
int execute_sql_with_returned_data(const string &sql, const string &db_path, vector<string> &rs, pair<int, int> &shape);
int execute_binded_sql(const string &sql, const string &db_path, int index, const string &value);
```

**`sqlite_apis.cpp`**
```cpp
#include <cstdio>
#include <iostream>
#include "src/level1/level2/sqlite/include/sqlite_apis.h"

#define _DEBUG_

int create_db(const string &db_path)
{
    sqlite3 *db;
    int rc;

    rc = sqlite3_open(db_path.c_str(), &db);

    if (rc) {
        fprintf(stderr, "Failed to create database: %s\n", sqlite3_errmsg(db));
        exit(-1);
    } else {
        fprintf(stderr, "Create database successfully\n");
    }
    sqlite3_close(db);
    return 0;
}

int delete_db(const string &db_path)
{
    int rc;
    rc = remove(db_path.c_str());

    if (rc) {
        fprintf(stderr, "Failed to delete database: %s\n", db_path);
        exit(-1);
    } else {
        fprintf(stderr, "Delete database successfully\n");
    }
    return 0;
}

sqlite3 *open_db(const string &db_path)
{
    sqlite3 *db;
    int rc;

    rc = sqlite3_open(db_path.c_str(), &db);

    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(-1);
    } else {
        fprintf(stderr, "Opened database successfully\n");
    }
    return db;
}

int close_db(sqlite3 *db)
{
    int rc;
    rc = sqlite3_close(db);

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Failed to close database: %s\n", sqlite3_errmsg(db));
        exit(-1);
    } else {
        fprintf(stderr, "Close database successfully\n");
    }
    return 0;
}


static int callback(void *data, int n_columns, char **col_value, char **col_name){
   int i;
   fprintf(stderr, "%s: ", (const char*)data);
   for (i = 0; i < n_columns; i++) {
      printf("%s = %s\n", col_name[i], col_value[i] ? col_value[i] : "NULL");
   }
   printf("\n");
   return 0;
}

int create_tb_from_sql(const string &sql, const string &db_path)
{
    if (sql.size() == 0) {
        fprintf(stderr, "The sql statement cannot be empty!");
        exit(-1);
    }
    if (db_path.size() == 0) {
        fprintf(stderr, "The database path cannot be empty!");
        exit(-1);
    }

    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;

    // Open database
    rc = sqlite3_open(db_path.c_str(), &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
    } else {
        fprintf(stdout, "Opened database successfully\n");
    }

    // Execute SQL statement
    rc = sqlite3_exec(db, sql.c_str(), callback, 0, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    } else {
        fprintf(stdout, "Table created successfully\n");
    }
    sqlite3_close(db);
    return 0;
}

int execute_sql_without_returned_data(const string &sql, const string &db_path)
{
    if (sql.size() == 0) {
        fprintf(stderr, "The sql statement cannot be empty!");
        exit(-1);
    }
    if (db_path.size() == 0) {
        fprintf(stderr, "The database path cannot be empty!");
        exit(-1);
    }

    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;

    // Open database
    rc = sqlite3_open(db_path.c_str(), &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
    } else {
        fprintf(stdout, "Opened database successfully\n");
    }

    // Execute SQL statement
    rc = sqlite3_exec(db, sql.c_str(), NULL, NULL, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    } else {
        fprintf(stdout, "SQL %s executed successfully\n", sql.c_str());
    }
    sqlite3_close(db);
    return 0;
}

int execute_sql_with_returned_data(const string &sql, const string &db_path, vector<string>& rs, pair<int, int>& shape)
{
    if (sql.size() == 0) {
        fprintf(stderr, "The sql statement cannot be empty!");
        exit(-1);
    }
    if (db_path.size() == 0) {
        fprintf(stderr, "The database path cannot be empty!");
        exit(-1);
    }

    sqlite3 *db;
    int rc;

    // Open database
    rc = sqlite3_open(db_path.c_str(), &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
    } else {
        fprintf(stdout, "Opened database successfully\n");
    }

    char **query_results;
    int n_rows;
    int n_cols;
    char *zErrMsg = 0;

    // Execute Query SQL statement
    rc = sqlite3_get_table(db, sql.c_str(), &query_results, &n_rows, &n_cols, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    } else {
        fprintf(stdout, "SQL %s executed successfully\n", sql.c_str());
    }

    #ifdef _DEBUG_
    printf("(n_rows, n_cols) is: (%d, %d) \n", n_rows, n_cols);
    for (int i = 0; i < n_cols; ++i) {
        printf("The %d-th column name is: %s\n", i+1, query_results[i]);
    }
    for (int i = 1; i < n_rows + 1; ++i) {
        for (int j = 0; j < n_cols; ++j) {
            printf("The elem of row %d col %d is: %s | ", i, j+1, query_results[i*n_cols + j]);
        }
        printf("\n");
    }
    #endif

    shape.first = n_rows;
    shape.second = n_cols;
    #ifdef _DEBUG_
    printf("The shape of the result table is: row_number = %d, col_number = %d \n", shape.first, shape.second);
    #endif
    rs.resize((n_rows+1)*n_cols);
    for (int i = 0; i < (n_rows+1)*n_cols; ++i) {
        rs[i].assign(query_results[i]);
        #ifdef _DEBUG_
        std::cout << rs[i] << std::endl;
        #endif
    }

    sqlite3_free_table(query_results);
    sqlite3_close(db);
    return 0;
}

int execute_binded_sql(const string &sql, const string &db_path, int index, const string& value)
{
    if (sql.size() == 0) {
        fprintf(stderr, "The sql statement cannot be empty!");
        exit(-1);
    }
    if (db_path.size() == 0) {
        fprintf(stderr, "The database path cannot be empty!");
        exit(-1);
    }

    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;

    /* Open database */
    rc = sqlite3_open(db_path.c_str(), &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
    } else {
        fprintf(stdout, "Opened database successfully\n");
    }

    /* Execute SQL statement */
    sqlite3_stmt *stmt;
    rc = sqlite3_prepare_v2(db, sql.c_str(), sql.size()+1, &stmt, NULL);

    #ifdef _DEBUG_
    printf("The statement %s has %d parameter(s).\n", sql.c_str(), sqlite3_bind_parameter_count(stmt));
    #endif

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Failed to execute statement: %s\n", sqlite3_errmsg(db));
    } else {
        sqlite3_bind_int(stmt, index, stoi(value));
    }
    int step = sqlite3_step(stmt);
    if (step == SQLITE_ROW) {
        printf("Expected 1st elem is: %s\n", sqlite3_column_text(stmt, 0));
        printf("Expected 2nd elem is: %s\n", sqlite3_column_text(stmt, 1));
        printf("Expected 3rd elem is: %s\n", sqlite3_column_text(stmt, 2));
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return 0;
}
```

**`basic_sqlite_api_test.cpp`**
```cpp
#include "src/level1/level2/sqlite/include/sqlite_apis.h"

void test_create_db()
{
    string path = "./test_db";
    create_db(path);
    printf("Test create_db() succeeds\n");
}
void test_delete_db()
{
    string path = "./test_db";
    delete_db(path);
    printf("Test delete_db() succeeds\n");
}
void test_open_and_close_db()
{
    string path = "./test_db";
    sqlite3 *db = open_db(path);
    int rt = close_db(db);
    printf("rt is %d\n", rt);
    printf("Test open_and_close_db() succeeds\n");
}
void test_create_tb_sql()
{
    const string path = "./test_db";
    string sql;
    /* Create SQL statement */
    sql = "CREATE TABLE COMPANY("
          "ID INT PRIMARY KEY     NOT NULL,"
          "NAME           TEXT    NOT NULL,"
          "AGE            INT     NOT NULL,"
          "ADDRESS        CHAR(50),"
          "SALARY         REAL );";
    // int rt = create_tb_from_sql(sql, path);
    int rt = execute_sql_without_returned_data(sql, path);
    printf("rt is %d\n", rt);
    printf("Test create_db_sql() succeeds\n");
}
void test_insert_sql()
{
    const string path = "./test_db";
    string sql, sql2;
    /* Insert SQL statement */
    sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) "  \
         "VALUES (1, 'Alice', 11, 'California', 20000.00 ); " \
         "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) "  \
         "VALUES (2, 'Bob', 22, 'Texas', 15000.00 ); ";
    int rt = execute_sql_without_returned_data(sql, path);
    sql2 = "DROP TABLE IF EXISTS Cars;" 
           "CREATE TABLE Cars(Id INT, Name TEXT, Price INT);" 
           "INSERT INTO Cars VALUES(1, 'Audi', 52642);" 
           "INSERT INTO Cars VALUES(2, 'Mercedes', 57127);" 
           "INSERT INTO Cars VALUES(3, 'Skoda', 9000);" 
           "INSERT INTO Cars VALUES(4, 'Volvo', 29000);" 
           "INSERT INTO Cars VALUES(5, 'Bentley', 350000);";
    rt = execute_sql_without_returned_data(sql2, path);
    printf("rt is %d\n", rt);
    printf("Test insert_sql() succeeds\n");
}
void test_select_sql()
{
    const string path = "./test_db";
    string sql;
    vector<string> rs{};
    pair<int, int> shape{};
    /* Select SQL statement */
    sql = "SELECT * FROM COMPANY;";
    int rt = execute_sql_with_returned_data(sql, path, rs, shape);
    printf("rt is %d\n", rt);
    printf("Test select_sql() succeeds\n");
}
void test_bind_sql() {
    const string path = "./test_db";
    string sql;
    /* Bind insert SQL statement */
    sql = "SELECT Id, Name, Price FROM Cars WHERE Id = ?";
    int rt = execute_binded_sql(sql, path, 1, "4");
    printf("rt is %d\n", rt);
    printf("Test binded_sql() succeeds\n"); 
}
int main()
{
    test_create_db();
    test_delete_db();
    test_open_and_close_db();
    test_create_tb_sql();
    test_insert_sql();
    test_select_sql();
    test_bind_sql();
    return 0;
}
```
