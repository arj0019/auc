.del (\n|\t)

.bal ()
.bal {}
.bal []

.org program
.fmt program ::= \s*(?P<functions>.*})
.map program ::= &functions

.fmt functions ::= \s*(?P<function>.*?})(?P<functions>.*})
                 | \s*(?P<function>.*})
.map functions ::= &function; &functions
                 | &function

.fmt function ::= \s*(?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}
.map function ::= LOC &identifier; &routine

.fmt routine ::= \s*(?P<expression>[^;]*;)(?P<routine>.*;)
               | \s*(?P<expression>[^;]*;)
               | \s*(?P<return>[^;]*;)
.map routine ::= &expression; &routine
               | &expression
               | &return

.fmt expression ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]+;)
                  | \(\((?P<_expression>.+?)\)\s*(?P<op>\S+)\s*(?P<expression>[^;]*\);)
                  | \((?P<identifier>\S+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*\);)
                  | (?P<identifier>\S+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | \((?P<value>\S+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*\);)
                  | (?P<value>\S+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<identifier>\S+);
                  | (?P<value>\S+);
.map expression ::= &op &identifier, &expression
                  | &op &_expression, &expression
                  | &op &identifier, &expression
                  | &op &identifier, &expression
                  | &op &value, &expression
                  | &op &value, &expression
                  | &identifier
                  | &value

.fmt _expression ::= \((?P<identifier>\S+)\s*(?P<op>\S+)\s*(?P<_expression>.+\))
                   | (?P<identifier>\S+)\s*(?P<op>\S+)\s*(?P<_expression>.+)
                   | \((?P<value>\S+)\s*(?P<op>\S+)\s*(?P<_expression>.+\))
                   | (?P<value>\S+)\s*(?P<op>\S+)\s*(?P<_expression>.+)
                   | (?P<identifier>\S+)
                   | (?P<value>\S+)
.map _expression ::= &op &identifier, &_expression
                   | &op &identifier, &_expression
                   | &op &value, &_expression
                   | &op &value, &_expression
                   | &identifier
                   | &value

.fmt return ::= return\s+(?P<expression>[^;]*;)
              | return\s+(?P<value>\w+);
              | return\s+(?P<identifier>\w+);
.map return ::= RET &expression
              | RET &value
              | RET &identifier

.fmt op ::= =|\+|-|\*|/
.map op ::= MOV|ADD|SUB|MUL|DIV

.fmt type ::= int

.fmt value ::= \((?P<value>-?[0-9]+)\)
             | -?[0-9]+
.map value ::= #value
             | #value

.fmt identifier ::= \((?P<identifier>[A-Za-z_][0-9A-Za-z_]*)\)
                  | [A-Za-z_][0-9A-Za-z_]*
.map identifier ::= *identifier
                  | *identifier
