
## 关于 Round Robin

Guidance for designing distributed tables using dedicated SQL pool in Azure Synapse Analytics https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute
- > **Round-robin distributed**
  * > A round-robin distributed table distributes table rows ***evenly*** across all distributions. The assignment of rows to distributions is ***random***. Unlike hash-distributed tables, ***rows with equal values are not guaranteed to be assigned to the same distribution***.
    >> //notes：其实 Round Robin 差不多就是一个分区一个，一个分区一个这样基本均匀地去分。有点类似下面这个视频：
    >>> Round Robin partitioning - DataStage https://www.youtube.com/watch?v=Mj8g3lncIU8
    >>>> 【[:star:][`*`]】 //notes：反正视频里的实质就是当前轮到哪一条数据了，当前轮到哪一个节点了，就把这条数据分布到这个节点。。。然后下一条数据，下一个节点，依次类推。但是实际中可能不是这么简单（比如，每次可能是随机选择一个节点而不是顺序选择，但是在总体上保持接近平均划分，也就是每个节点里的数据量都差不多）。
  * > As a result, the system sometimes needs to invoke a data movement operation to better organize your data before it can resolve a query. This extra step can slow down your queries. For example, joining a round-robin table usually requires reshuffling the rows, which is a performance hit.
  * > Consider using the round-robin distribution for your table in the following scenarios:
    ```console
    When getting started as a simple starting point since it is the default
    If there is no obvious joining key
    If there is no good candidate column for hash distributing the table
    If the table does not share a common join key with other tables
    If the join is less significant than other joins in the query
    When the table is a temporary staging table
    ```
  * > The tutorial [Load New York taxicab data](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/load-data-from-azure-blob-storage-using-copy#load-the-data-into-your-data-warehouse) gives an example of loading data into a round-robin staging table.

How to choose Right data distribution strategy for Azure Synapse? https://rajanieshkaushikk.com/2020/09/09/how-to-choose-right-data-distribution-strategy-for-azure-synapse/
- > Azure Synapse distributes the data in three ways:
  * > **`Round Robin`**: This distributes the data **equally** among all the 60 underlying distributions. ***There is no specific key used to distribute the data***. This is the default method used when no data distribution strategy is specified.
  * > **`Hashing`**: Azure Synapse Analytics uses a hash function to assign each row to one distribution deterministically. In the table definition, one of the columns is designated as the distribution column. The hash function uses the values in the distribution column to assign each row to a distribution.
  * > **`Replication`**: A table that is replicated ***caches a full copy*** on ***each compute node***. Consequently, replicating a table removes the need to transfer data among compute nodes before a join or aggregation. This requires extra storage and there are additional overheads that are incurred when writing data which make large tables impractical.
- > **When to use Round Robin Distribution?**
  * > ![](https://rajanieshkaushikk.files.wordpress.com/2020/09/round-robin.png)
  * > A round-robin table is the most straightforward table to create and delivers fast performance when used as a staging table for loads. These are some scnearios where you should choose Round robin distribution:
    + > When you cannot identify a single key to distribute your data.
    + > If your data doesn’t frequently join with data from other tables.
    + > When there are no obvious keys to join.
    + > If the table is being used to hold temporary data.
    + > Dimension tables or other lookup tables in a schema can usually be stored as round-robin tables.Usually these tables connects to more than one fact tables and optimizing for one join may not be the best idea.These smaller dimanesions tables can leave some distributions empty when has distributed. So use round robin for uniform distribution of such tables.
  * > A round-robin table is the most straightforward table to create and **delivers fast performance when used as a staging table for loads**.
  * > A round-robin distributed table distributes data evenly across the table but without any further optimization. A distribution is first chosen at random, and then buffers of rows are assigned to distributions sequentially. **It is quick to load data into a round-robin table, but query performance can often be better with hash distributed tables. Joins on round-robin tables require reshuffling data, and this takes additional time**.
  * > **If you are unsure of query patterns and data, you can start with all tables in round-robin distribution. And as you learn the patterns the data can be easily redistributed on a hash key**.
- > **When to use Hash Distribution?**
  * > ![](https://rajanieshkaushikk.files.wordpress.com/2020/09/hash.png)
  * > Hashing is a very common and effective data distribution method. The data is distributed based on the **hash value of a single column that you select**, according to some hashing algorithm. This distribution column then dictates how the data is spread across the underlying distributions. Items that have the same data value and data type for the hash key always end up in the same distribution.A hash distributed table can deliver the **highest query performance for joins and aggregations on large tables**.
  * > **How to choose best distribution column?**
  * > Please make sure to keep these points in consideraion to identify the best distribution column.
    + > Choose a column that ***won’t be updated***.
    + > Always choose a column that leads to even distribution (skew) of rows across all the databases.
    + > Choose an appropriate distribution column that reduces the data movement activity between different distributions.
    + > ***Do not choose nullable column*** because all null columns are hashed in th same way and thus the rows will end up in the same location. If ***most columns of the table are nulls then it may not be a good candidate for hash distribution***.
    + > Any ***fact tables that has a default value in a column*** is also not a good candidate to create a hash distributed table.
    + > Large fact tables or historical transaction tables are usually stored as hash distributed tables. 
- > **When to use Replicated Distribution?**
  * > ![](https://rajanieshkaushikk.files.wordpress.com/2020/09/replicated-table.png)
  * > Replication is very good for small lookup tables or dimension tables that are frequently joined with other big tables. Instead of distributing small sections of data across the underlying distributions for small tables, the replication data strategy creates a copy of the entire table in each of the underlying distribution.
- > **Summary**

| Type of Distribution | Best Fit for… | Do not use when… |
|--|--|--|
| Replicated | – Small dimension tables in a star schema with less then 2 GB of storage after the compression (Synapse does 5x compression). <br> - Good for small lookup tables. <br> - Good for dimension tables that are frequently joined with other big tables. | - Many write transactions are on the table (for example insert, delete and updates). <br> - If you change the datawarehouse Units frequently. <br> - You only use 2 -3 columns out of many columns in your tables. <br> - you are indexing a replicated table. |
| Round Robin (default) | – Temporary /staging Table. <br> – No obvious joining key candidate is found in the table or If your data doesn’t frequently join with data from other tables. <br> – When you cannot identify a single key to distribute your data. <br> – If the table is being used to hold temporary data. <br> – If you are using a staging table for faster loads. <br> – If you are unsure of query patterns and data, you can start with all tables in round-robin distribution. And as you learn the patterns the data can be easily redistributed on a hash key. <br> – Small dimension table. | – Performance is slow due to data movement |
| Hash | – Large Fact Tables or historical Transaction tables are good candidates. <br> – Large dimension tables. | – The distribution key ***can not be updated*** <br> – A ***nullable column*** is a bad candidate for any hash distributed table. <br> – Fact tables that ***has a default value in a column*** is also not a good candidate to create a hash distributed table. |

补充：
- Fact Table and Dimension Table https://www.cnblogs.com/qlee/archive/2011/04/09/2010164.html
- Difference between Fact Table and Dimension Table https://www.geeksforgeeks.org/difference-between-fact-table-and-dimension-table/
  * > ![](https://media.geeksforgeeks.org/wp-content/uploads/20190528110320/Untitled-Diagram-68.png)
