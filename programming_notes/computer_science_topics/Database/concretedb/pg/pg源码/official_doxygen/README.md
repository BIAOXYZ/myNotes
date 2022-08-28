
parsenodes.h https://doxygen.postgresql.org/parsenodes_8h_source.html
- `Query` Struct Reference https://doxygen.postgresql.org/structQuery.html
- `RangeTblEntry` Struct Reference https://doxygen.postgresql.org/structRangeTblEntry.html
```console
(gdb) bt
#0  transformSelectStmt (pstate=0x56238891e5c8, stmt=0x56238891e418) at analyze.c:1305
#1  0x00005623875b7eb7 in transformStmt (pstate=0x56238891e5c8, parseTree=0x56238891e418) at analyze.c:301
...
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value
$19 = {type = T_RangeTblEntry, rtekind = RTE_RELATION, relid = 24576, relkind = 114 'r', rellockmode = 1, tablesample = 0x0, subquery = 0x0, security_barrier = false, jointype = JOIN_INNER, joinaliasvars = 0x0, functions = 0x0, funcordinality = false, tablefunc = 0x0, values_lists = 0x0, ctename = 0x0, ctelevelsup = 0, self_reference = false, coltypes = 0x0, coltypmods = 0x0, colcollations = 0x0, enrname = 0x0, enrtuples = 0, alias = 0x0, eref = 0x56238891e910, lateral = false, inh = true, inFromCl = true, requiredPerms = 2, checkAsUser = 0, selectedCols = 0x56238891eef0, insertedCols = 0x0, updatedCols = 0x0, extraUpdatedCols = 0x0, securityQuals = 0x0}
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value->relid
Attempt to dereference a generic pointer.
(gdb) p *(RangeTblEntry*)pstate->p_rtable->head->data->ptr_value.relid
Attempt to dereference a generic pointer.
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
