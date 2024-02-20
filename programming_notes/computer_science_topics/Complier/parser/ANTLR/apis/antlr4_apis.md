
Class RuleContext https://www.antlr.org/api/JavaTool/org/antlr/v4/runtime/RuleContext.html
- > ***A rule context is a record of a single rule invocation. It knows which context invoked it, if any. If there is no parent context, then naturally the invoking state is not valid***. The parent link provides a chain upwards from the current rule invocation to the root of the invocation tree, forming a stack. We actually carry no information about the rule associated with this context (except when parsing). We keep only the state number of the invoking state from the ATN submachine that invoked this. Contrast this with the s pointer inside ParserRuleContext that tracks the current state being "executed" for the current rule. The parent contexts are useful for computing lookahead sets and getting error information. These objects are used during parsing and prediction. For the special case of parsers, we use the subclass `ParserRuleContext`.

Class ParserRuleContext https://www.antlr.org/api/Java/org/antlr/v4/runtime/ParserRuleContext.html

Enum PredictionMode https://www.antlr.org/api/Java/org/antlr/v4/runtime/atn/PredictionMode.html
- > Enum Constant Summary

  | Enum Constant | Description |
  |--|--|
  | LL | The `LL(*)` prediction mode. |
  | LL_EXACT_AMBIG_DETECTION | The `LL(*)` prediction mode with exact ambiguity detection. |
  | SLL | The `SLL(*)` prediction mode. |

Antlr4 笔记 https://program.snlcw.com/242.html
- > **5 预测模式（PredictionMode.SLL 和 PredictionMode.LL）**
  * > 有时候我在Antlrworks2里测试过的语法树，在代码里执行就报错，这是应为 Antlrworks2 可能使用了 PredictionMode.LL 模式解析的，但代码里我们必须要求设置  PredictionMode.SLL 以加快解析速度，遇到这种情况我们的做法是直接修改g4文件，而不是将 SLL 改为 LL。
  * > 5.1 SLL 模式
    + > 这种模式在预测时，会忽略当前解析上下文。这是解析速度最快的，而且对于大多数语法（grammars）都支持。但使用这种模式可能会带来grammar语法错误，就像上面说的。当使用这种预测模式时，Antlr解析器可能正确返回一个解析树，也可能报告一个语法错误。这种错误，可能是由于输入中的实际语法错误或语法和输入的特殊组合要求强大的LL预测能力来完成。
  * > 5.2 LL 模式
    + > 这种预测模式能够用于SSL预测解析失败的时候。这是最快的预测模式，可以保证语法和语法正确输入的所有组合的正确解析结果。使用这种预测模式时，解析器将为所有语法正确的语法和输入组合做出正确的决策。但是，在语法确实不明确的情况下，此预测模式可能不会报告精确答案。
  * > 5.3 例子
    ```g4
    routingEntry
        : (stati='S>*' | connected='C>*' dest=IP4_W_LEN falText routingEntryClause
        ;
    ```
    > falText 是由多个 falWord 组成的。这里 falText 后面跟着 routingEntryClause 会出现语法不明确， falText 可以包含后面的 routingEntryClause 要匹配的内容，除非控制 falText 使用“饥渴”匹配。因此这里用SLL模式就会报语法错误。改用LL就没问题。
