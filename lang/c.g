.del (\n|\t)

.fmt function ::= \s*(?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}
.map function ::= &routine

.fmt routine ::= \s*(?P<expression>[^;]*;)(?P<routine>.*;)
               | \s*(?P<expression>.*;)
               | \s*(?P<return>.*;)
.map routine ::= &expression; &routine
               | &expression
               | &return

.fmt expression ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+);
.map expression ::= &op &identifier, &expression
                  | &op &identifier, &expression
                  | &op &value, &expression
                  | &value

.fmt return ::= return\s+(?P<value>\w+);
.map return ::= RET &value

.fmt op ::= =|\+|-|\*|/
.map op ::= MOV|ADD|SUB|MUL|DIV

.fmt type ::= int

.fmt value ::= -?0x[0-9A-Fa-f]+
             | -?[0-9]+
.map value ::= $value
             | $value

.fmt identifier ::= [A-Za-z_][0-9A-Za-z_]*
.map identifier ::= $identifier
