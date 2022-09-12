
# 包（package）
//notes：还有一些其他的Oracle兼容性相关特性，参见 Oracle 兼容性部分吧。

Introduction to IvorySQL Packages https://www.ivorysql.org/zh-CN/blog/IvorySQL-Packages
```sql
-- 执行这句前 \d 和 执行这句后 \d 看到的系统表是不一样的，说明为了兼容性，增加了一些类似 Oracle 系统表的表。
SET compatible_mode TO oracle;

CREATE TABLE books (
    id     INT, 
    title  VARCHAR2(100), 
    author VARCHAR2(100),
    price  NUMBER);

INSERT INTO books VALUES (10, 'The Hobbit', 'J. R. R. Tolkien', 10.0);
INSERT INTO books VALUES (11, 'Winnie-the-Pooh', 'A. A. Milne', 5.0);
INSERT INTO books VALUES (12, 'Peter Pan', 'James Matthew Barrie', 4.0);
INSERT INTO books VALUES (13, 'Charlie and the Chocolate Factory', 'Roald Dahl', 5.0);
INSERT INTO books VALUES (14, 'SThe Jungle Book', 'Rudyard Kipling', 9.0);
INSERT INTO books VALUES (15, 'The Little White Bird', 'James Matthew Barrie', 3.0);
```
```sql
CREATE OR REPLACE PACKAGE mybooks AS
    CURSOR      booksinfo IS SELECT * from BOOKS;
    PROCEDURE list_books;
    FUNCTION add_book(title VARCHAR2(100), author VARCHAR2(100), 
         price NUMBER) RETURN bool;
    PROCEDURE remove_book(book_title VARCHAR2(100));
END;
/

CREATE OR REPLACE PACKAGE BODY mybooks AS
    -- declare private variables
    bookinfo    booksinfo%rowtype; 
    books_count INT;
    PROCEDURE list_books AS
    BEGIN
        OPEN booksinfo;
        RAISE INFO 'Book Info:';
        RAISE INFO '';
        LOOP
            FETCH booksinfo into bookinfo;
            EXIT WHEN NOT FOUND;

            RAISE INFO '  Name    = %', bookinfo.title;
            RAISE INFO '  Author  = %', bookinfo.author;
            RAISE INFO '  Price   = %', bookinfo.price;
            RAISE INFO '------------------------------';
        END LOOP;
        RAISE INFO 'Total Books   = %', books_count;
        CLOSE booksinfo;
    END;
    FUNCTION add_book(title VARCHAR2(100), author VARCHAR2(100),
        price NUMBER) RETURN bool AS
    BEGIN
        INSERT INTO BOOKS VALUES (
            books_count + 1,
            title,
            author,
            price);
        books_count := books_count + 1;
        RETURN true;

        EXCEPTION WHEN OTHERS THEN
            RETURN false;
    END;
    PROCEDURE remove_book(book_title VARCHAR2(100)) AS
    BEGIN
        DELETE FROM BOOKS WHERE title = book_title;
        EXCEPTION WHEN OTHERS THEN
            RAISE INFO 'Book % not found', book_title;
    END;
-- initializer block
BEGIN           
    books_count := 0;
    SELECT count(*) INTO books_count
        FROM BOOKS;
END;
/
```
```sql
DECLARE
    nbooks int := 0;
BEGIN
    nbooks := mybooks.books_count;
    RAISE INFO 'Total Books   = %', nbooks;
END;
/

2022-09-12 09:03:57.995 UTC [344769] ERROR:  package private variable ("mybooks.books_count") is not accessible
2022-09-12 09:03:57.995 UTC [344769] CONTEXT:  compilation of PL/iSQL function "inline_code_block" near line 4
2022-09-12 09:03:57.995 UTC [344769] STATEMENT:  DECLARE
	    nbooks int := 0;
	BEGIN
	    nbooks := mybooks.books_count;
	    RAISE INFO 'Total Books   = %', nbooks;
	END;

ERROR:  package private variable ("mybooks.books_count") is not accessible
CONTEXT:  compilation of PL/iSQL function "inline_code_block" near line 4
postgres=#
```
```sql
BEGIN
    mybooks.list_books;
END;
/

postgres=# BEGIN
postgres$#     mybooks.list_books;
postgres$# END;
postgres$# /
INFO:  Book Info:
INFO:
INFO:    Name    = The Hobbit
INFO:    Author  = J. R. R. Tolkien
INFO:    Price   = 10
INFO:  ------------------------------
INFO:    Name    = Winnie-the-Pooh
INFO:    Author  = A. A. Milne
INFO:    Price   = 5
INFO:  ------------------------------
INFO:    Name    = Peter Pan
INFO:    Author  = James Matthew Barrie
INFO:    Price   = 4
INFO:  ------------------------------
INFO:    Name    = Charlie and the Chocolate Factory
INFO:    Author  = Roald Dahl
INFO:    Price   = 5
INFO:  ------------------------------
INFO:    Name    = SThe Jungle Book
INFO:    Author  = Rudyard Kipling
INFO:    Price   = 9
INFO:  ------------------------------
INFO:    Name    = The Little White Bird
INFO:    Author  = James Matthew Barrie
INFO:    Price   = 3
INFO:  ------------------------------
INFO:  Total Books   = 6
DO
postgres=#
```
```sql
DECLARE
    added bool;
BEGIN
    added := mybooks.add_book('The Cat in the Hat', 'Dr. Seuss', 10);
    IF added = TRUE THEN
        RAISE INFO 'new book added';
    END IF;
END;
/

postgres=# DECLARE
postgres$#     added bool;
postgres$# BEGIN
postgres$#     added := mybooks.add_book('The Cat in the Hat', 'Dr. Seuss', 10);
postgres$#     IF added = TRUE THEN
postgres$#         RAISE INFO 'new book added';
postgres$#     END IF;
postgres$# END;
postgres$# /
INFO:  new book added
DO
postgres=#
```
