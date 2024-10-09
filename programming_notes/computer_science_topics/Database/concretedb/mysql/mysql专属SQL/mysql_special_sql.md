
# replace into

How to INSERT If Row Does Not Exist (UPSERT) in MySQL https://www.atlassian.com/data/admin/how-to-insert-if-row-does-not-exist-upsert-in-mysql
- > **Using `REPLACE`**
  * > In the event that you wish to actually replace rows where `INSERT` commands would produce errors due to duplicate `UNIQUE` or `PRIMARY KEY` values as outlined above, one option is to opt for the `REPLACE` statement.
  * > For example, we can use `REPLACE` to swap out our existing record of id = 1 of In Search of Lost Time by Marcel Proust with Green Eggs and Ham by Dr. Seuss:
    ```sql
    mysql> REPLACE INTO books
        (id, title, author, year_published)
    VALUES
        (1, 'Green Eggs and Ham', 'Dr. Seuss', 1960);
    Query OK, 2 rows affected (0.00 sec)
    ```
- > **Using `INSERT ... ON DUPLICATE KEY UPDATE`**
