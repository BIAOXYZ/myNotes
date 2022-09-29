
parsenodes.h https://doxygen.postgresql.org/parsenodes_8h_source.html
- `Query` Struct Reference https://doxygen.postgresql.org/structQuery.html
- `RangeTblEntry` Struct Reference https://doxygen.postgresql.org/structRangeTblEntry.html
```console
(gdb) bt
#0  transformSelectStmt (pstate=0x56238891e5c8, stmt=0x56238891e418) at analyze.c:1305
#1  0x00005623875b7eb7 in transformStmt (pstate=0x56238891e5c8, parseTree=0x56238891e418) at analyze.c:301
...
...
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value
$19 = {type = T_RangeTblEntry, rtekind = RTE_RELATION, relid = 24576, relkind = 114 'r', rellockmode = 1, tablesample = 0x0, subquery = 0x0, security_barrier = false, jointype = JOIN_INNER, joinaliasvars = 0x0, functions = 0x0, funcordinality = false, tablefunc = 0x0, values_lists = 0x0, ctename = 0x0, ctelevelsup = 0, self_reference = false, coltypes = 0x0, coltypmods = 0x0, colcollations = 0x0, enrname = 0x0, enrtuples = 0, alias = 0x0, eref = 0x56238891e910, lateral = false, inh = true, inFromCl = true, requiredPerms = 2, checkAsUser = 0, selectedCols = 0x56238891eef0, insertedCols = 0x0, updatedCols = 0x0, extraUpdatedCols = 0x0, securityQuals = 0x0}
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value->relid
Attempt to dereference a generic pointer.
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value.relid
Attempt to dereference a generic pointer.
# 上面两个打印失败就是因为就 C 语言运算符优先级来说有：
# `.` 高于 `->` 高于 `(type)` 高于 `*`（也就是说： `以对象方式访问成员` > `以指针方式访问成员` > `强制类型转换` > `解引用`）。
# 于是它们等于是最后把 relid 强转成 RangeTblEntry* 类型，最后再解引用。当然是不对的，因为 relid 是 Oid 类型的。
(gdb) p (*(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value).relid
$18 = 24576
(gdb) p (*(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value)->relid
$22 = 24576
(gdb) p ((RangeTblEntry*)pstate->p_rtable->head->data->ptr_value)->relid
$23 = 24576
(gdb) p (RangeTblEntry*)pstate->p_rtable->head->data->ptr_value->relid
Attempt to dereference a generic pointer.
(gdb)
```

parser.c https://doxygen.postgresql.org/backend_2parser_2parser_8c_source.html || parser.c File Reference https://doxygen.postgresql.org/backend_2parser_2parser_8c.html
- `raw_parser()`

```sh
# 运算符优先级没有正确处理导致的问题
(gdb) p (*((List*)raw_parsetree_list->head->data->ptr_value)->head)->data
$60 = {ptr_value = 0xe9, int_value = 233, oid_value = 233}
```
```sh
# head 是个 ListCell 类型的指针
(gdb) p	parsetree_list->head
$74 = (ListCell *) 0x2ae4a40
# head 解引用后就是一个 ListCell
(gdb) p *parsetree_list->head
$75 = {data = {ptr_value = 0x2ae4a08, int_value = 44976648, oid_value = 44976648}, next = 0x0}
# 强转的时候如果括号没搞好，反而会搞错，导致打印不出来正确的值。上面那个打错就是因为这个原因。
(gdb) p *(List*)parsetree_list->head
$76 = {type = 44976648, length = 0, head = 0x0, tail = 0x20}
# 只要自己加括号加对了，就可以正确打出来。
(gdb) p *((List*)parsetree_list)->head
$77 = {data = {ptr_value = 0x2ae4a08, int_value = 44976648, oid_value = 44976648}, next = 0x0}
```

```sh
(gdb) ptype parsetree_list
type = struct List {
    NodeTag type;
    int length;
    ListCell *head;
    ListCell *tail;
} *
(gdb) ptype parsetree_list->head
type = struct ListCell {
    union {
        void *ptr_value;
        int int_value;
        Oid oid_value;
    } data;
    ListCell *next;
} *
(gdb) p *parsetree_list->head
$6 = {data = {ptr_value = 0x1e3ae80, int_value = 31698560, oid_value = 31698560}, next = 0x0}
# head (也就是 ListCell 或者 ListCell* 的（联合体）成员 data 不是个指针，所以打印时去解引用是不对的。
(gdb) p *parsetree_list->head->data
Attempt to take contents of a non-pointer value.
# 不解引用直接打印才可以。
(gdb) p parsetree_list->head->data
$7 = {ptr_value = 0x1e3ae80, int_value = 31698560, oid_value = 31698560}
```

```sh
# 其他 ptype 打印的情况（主要区别就是结构体最后的大括号后面有没有 * 号，按指针类型打印就有，解引用后打印就没有）。
(gdb) ptype parsetree
type = struct RawStmt {
    NodeTag type;
    Node *stmt;
    int stmt_location;
    int stmt_len;
} *
(gdb)
(gdb) ptype *parsetree
type = struct RawStmt {
    NodeTag type;
    Node *stmt;
    int stmt_location;
    int stmt_len;
}

(gdb) ptype *parsetree.stmt
type = struct Node {
    NodeTag type;
}
(gdb) ptype *parsetree->stmt
type = struct Node {
    NodeTag type;
}
(gdb) ptype parsetree->stmt
type = struct Node {
    NodeTag type;
} *
(gdb) ptype parsetree.stmt
type = struct Node {
    NodeTag type;
} *
```

```sh
# postgres/src/backend/parser/analyze.c
case T_SelectStmt:
                        {
                                SelectStmt *n = (SelectStmt *) parseTree;
# 后面代码省略。

(gdb) p parseTree
$44 = (Node *) 0x1e3ab10
(gdb) p n
$45 = (SelectStmt *) 0x1e3ab10
# Node* 类型去解引用就得不到什么东西。
(gdb) p	*parseTree
$46 = {type = T_SelectStmt}
# 但是用强制转换后的 SelectStmt* 类型去解引用就可以把结构的其他成员显示出来。
(gdb) p	*n
$47 = {type = T_SelectStmt, distinctClause = 0x0, intoClause = 0x0, targetList = 0x1e3a7e8, fromClause = 0x1e3a8c0, whereClause = 0x1e3aa30, groupClause = 0x0, havingClause = 0x0, windowClause = 0x0, valuesLists = 0x0, sortClause = 0x1e3ad88, limitOffs
et = 0x0, limitCount = 0x1e3adc0, lockingClause = 0x0, withClause = 0x0, op = SETOP_NONE, all = false, larg = 0x0, rarg = 0x0}

(gdb) p	n->targetList
$50 = (List *) 0x1e3a7e8
(gdb) p n->targetList->head
$51 = (ListCell *) 0x1e3a7c0
(gdb) p n->targetList->head->data
$52 = {ptr_value = 0x1e3a768, int_value = 31696744, oid_value = 31696744}
(gdb) p n->targetList->head->data->ptr_value
$53 = (void *) 0x1e3a768
# ListCell 的特点，如果“真正的成员”（因为 data 是个 union 类型）是在 ptr_value 上，那么必须对 void* 类型的 ptr_value 进行正确的强制类型转换。
(gdb) p	*n->targetList->head->data->ptr_value
Attempt to dereference a generic pointer.
(gdb) p*(ResTarget*)n->targetList->head->data->ptr_value
$54 = {type = T_ResTarget, name = 0x0, indirection = 0x0, val =	0x1e3a6b0, location = 7}
(gdb)
# 但是比较有意思的是即使转错了，可能有些成员也能打印出来- -
(gdb) p*(ColumnRef*)n->targetList->head->data->ptr_value
$55 = {type = T_ResTarget, fields = 0x0, location = 0}
(gdb) p*(SortBy*)n->targetList->head->data->ptr_value
$57 = {type = T_ResTarget, node = 0x0, sortby_dir = SORTBY_DEFAULT, sortby_nulls = SORTBY_NULLS_DEFAULT, useOp = 0x1e3a6b0, location = 7}

# 接下来继续往下打印
(gdb) p n->targetList->head->data->ptr_value->val
Attempt to dereference a generic pointer.
(gdb) p (ResTarget*)n->targetList->head->data->ptr_value->val
Attempt to dereference a generic pointer.
(gdb) p	((ResTarget*)n->targetList->head->data->ptr_value)->val
$73 = (Node *) 0x1e3a6b0
(gdb) p	*((ResTarget*)n->targetList->head->data->ptr_value)->val
$74 = {type = T_ColumnRef}
```

# `.gdbinit` for pg debug

Tip 15: get GDB to print your structures https://modelingwithdata.org/arch/00000065.htm

```console
define nt
  p *(Node*)$arg0
end

define tr
  p *(($arg0*)$arg1)
end

define plist
  p ((List*)$arg0)->length
  set $n = ((List*)$arg0)->length
  set $i = 0
  while($i < $n)
    p ((List*)$arg0)->elements[$i]
    set $i = $i + 1
  end
end
```
