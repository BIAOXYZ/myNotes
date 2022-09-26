
# 官方

queryparser https://github.com/pganalyze/queryparser
- > DEPRECATED - use libpg_query instead! https://github.com/lfittl/libpg_query

# 其他

Query Parsing https://wiki.postgresql.org/wiki/Query_Parsing
- > **Using Postgres internals**
  * > An example can be seen [here](https://github.com/pganalyze/queryparser/blob/master/queryparser.c), this can be easily implemented in a [Postgres extension](http://www.postgresql.org/docs/current/static/extend-extensions.html) as well as seen [here](https://github.com/pganalyze/queryparser/blob/master/extension/annotate_query.c).
  * https://github.com/pganalyze/queryparser/blob/master/extension/annotate_query.c
    ```c
    #include "postgres.h"
    #include "fmgr.h"
    #include "utils/builtins.h"
    #include "parser/parser.h"
    #include "nodes/print.h"

    PG_MODULE_MAGIC;


    PG_FUNCTION_INFO_V1(annotate_query);

    Datum
    annotate_query(PG_FUNCTION_ARGS)
    {
    	text	*sql_t = PG_GETARG_TEXT_P(0);
    	bool	pretty_b = PG_GETARG_BOOL(1);
    	text	*out_t;
    	char	*sql, *out;
    	List	*tree;

    	/* FIXME: Syntax error handling? */

    	sql = text_to_cstring(sql_t);
    	tree = raw_parser(sql);

    	out = nodeToJSONString(tree);

    	out_t = cstring_to_text(out);
    	PG_RETURN_TEXT_P(out_t);
    }
    ```
