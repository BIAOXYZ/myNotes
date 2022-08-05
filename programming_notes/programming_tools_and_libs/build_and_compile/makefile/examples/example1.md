
# 1

你见过最好的Makefile学习实例是什么？ - 极智视界的回答 - 知乎 https://www.zhihu.com/question/55488701/answer/2251580268

```sh
apt update && apt install -y libsqlite3-dev
mkdir test && cd test/
mkdir -p proj_root/src/level1/level2/test/test_sqlite/
mkdir -p proj_root/src/level1/level2/sqlite/{include,src}

cat << EOF > proj_root/src/level1/level2/test/test_sqlite/basic_sqlite_api_test.cpp
EOF
# Makefile 里 $ 太多了，就不搞 HereDoc 了，自己手动复制粘贴吧- -
cat << EOF > proj_root/src/level1/level2/sqlite/include/sqlite_apis.h
EOF
cat << EOF > proj_root/src/level1/level2/sqlite/src/sqlite_apis.cpp
EOF

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
bool check_db_existence(const string &db_path);
bool check_table_existence(const string &table, const string &db_path);
int create_tb_from_sql(const string &sql, const string &db_path);
int create_tb_from_name(const string &table, const string &db_path);
int execute_sql_without_returned_data(const string &sql, const string &db_path);
int execute_sql_with_returned_data(const string &sql, const string &db_path, vector<string> &rs, pair<int, int> &shape);
int execute_binded_sql(const string &sql, const string &db_path, int index, const string &value);
int execute_binded_sql2(const string &sql, const string &db_path, int index, const vector<uint64_t> &values);
int execute_binded_sql3(const string &sql, const string &db_path, int index1, const vector<uint64_t> &values1, int index2, const vector<uint64_t> &values2);
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

bool check_db_existence(const string & db_path)
{   
    FILE* file;
    if (file = fopen(db_path.c_str(), "r")) {
        fclose(file);
        return true;
    }
    return false;
}

bool check_table_existence(const string & table, const string & db_path)
{
    if (!check_db_existence(db_path)) {
        fprintf(stderr, "Both the database and the table do not exist!");
        exit(-1);        
    }
    string sql_start = "select count(type) from sqlite_master where type = 'table' and name = '";
    string sql_end = "';";
    string sql = sql_start + table + sql_end;
    vector<string> rs = {};
    pair<int, int> shape;
    execute_sql_with_returned_data(sql, db_path, rs, shape);
    if (rs[1] == "1") {
        return true;
    }
    return false;
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

/**
  * Note that this function will automatically create a database in 
  * parameter db_path, the effect of which is indeed the one we expected.
  * And the Schema is (row, column, value).
  */
int create_tb_from_name(const string &table, const string &db_path)
{
    string sql_start = "create table ";
    string sql_end = " (row INT, col INT, val TEXT)";
    string sql = sql_start + table + sql_end;
    int rc = execute_sql_without_returned_data(sql, db_path);
    if (rc != 0) {
        fprintf(stderr, "There is error occured in func create_tb_from_name(): \n");
    }
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

int execute_binded_sql2(const string &sql, const string &db_path, int index, const vector<uint64_t>& values)
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
    rc = sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, NULL);

    #ifdef _DEBUG_
    printf("The statement %s has %d parameter(s).\n", sql.c_str(), sqlite3_bind_parameter_count(stmt));
    #endif

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Failed to execute statement: %s\n", sqlite3_errmsg(db));
    } else {
        for (int value : values) {
            printf("The binded value = %d\n", value);
            sqlite3_bind_int(stmt, index, value);
            sqlite3_step(stmt);
            sqlite3_reset(stmt);
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return 0;
}

int execute_binded_sql3(const string &sql, const string &db_path, int index1, const vector<uint64_t>& values1,
     int index2, const vector<uint64_t> &values2)
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
    rc = sqlite3_prepare_v2(db, sql.c_str(), -1, &stmt, NULL);

    #ifdef _DEBUG_
    printf("The statement %s has %d parameter(s).\n", sql.c_str(), sqlite3_bind_parameter_count(stmt));
    #endif

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Failed to execute statement: %s\n", sqlite3_errmsg(db));
    } else {
        for (int v1 : values1) {
            for (int v2 : values2) {
                printf("The 1st binded value v1 = %d, the 2nd binded value v2 = %d\n", v1, v2);
                sqlite3_bind_int(stmt, 1, v1);
                sqlite3_bind_int(stmt, 2, v2);
                sqlite3_step(stmt);
                sqlite3_reset(stmt);
            }
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return 0;
}
```

**`basic_sqlite_api_test.cpp`**
```cpp
#include <iostream>
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
    
    string sql2 = "Insert into Cars values (99,99,?);";
    std::vector<uint64_t> vec = {11,12,13,14,15};
    rt = execute_binded_sql2(sql2, path, 1, vec);
    printf("rt is %d\n", rt);
    
    string sql3 = "Insert into Cars values (1010101,?,?);";
    std::vector<uint64_t> vec1 = {111,222};
    std::vector<uint64_t> vec2 = {11,12,13,14,15};
    rt = execute_binded_sql3(sql3, path, 1, vec1, 2, vec2);
    printf("rt is %d\n", rt);
    printf("Test binded_sql() succeeds\n"); 
}
void test_check_db_existence() {
    const string path = "./test_db";
    bool rt = false;
    rt = check_db_existence(path);
    printf("rt is %d because the database really exists.\n", (int)rt);
    if (rt) {
        printf("Test check_db_existence() succeeds\n"); 
    }
}
void test_check_table_existence() {
    const string path = "./test_db";
    const string table = "Cars";
    bool rt = false;
    rt = check_table_existence(table, path);
    printf("rt is %d because the database and table both really exists.\n", (int)rt);
    if (rt) {
        printf("Test check_table_existence() succeeds\n"); 
    }  
}
int main()
{
    std::cout << "********** Tests Start **********" << std::endl;
    test_create_db();
    std::cout << "********** Split Line **********" << std::endl;
    test_delete_db();
    std::cout << "********** Split Line **********" << std::endl;
    test_open_and_close_db();
    std::cout << "********** Split Line **********" << std::endl;
    test_create_tb_sql();
    std::cout << "********** Split Line **********" << std::endl;
    test_insert_sql();
    std::cout << "********** Split Line **********" << std::endl;
    test_select_sql();
    std::cout << "********** Split Line **********" << std::endl;
    test_bind_sql();
    std::cout << "********** Split Line **********" << std::endl;
    test_check_db_existence();
    std::cout << "********** Split Line **********" << std::endl;
    test_check_table_existence();
    std::cout << "********** Tests End **********" << std::endl;
    return 0;
}
```
