.del (\n|\t)

.fmt function ::= \s*(?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}
.map function ::= LOC &identifier; &routine

.fmt routine ::= \s*(?P<expression>[^;]*;)(?P<routine>.*;)
               | \s*(?P<expression>[^;]*;)
               | \s*(?P<return>[^;]*;)
.map routine ::= &expression; &routine
               | &expression
               | &return

.fmt expression ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<identifier>\w+);
                  | (?P<value>\w+);
.map expression ::= &op &identifier, &expression
                  | &op &identifier, &expression
                  | &op &value, &expression
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

.fmt value ::= -?0x[0-9A-Fa-f]+
             | -?[0-9]+
.map value ::= $value
             | $value

.fmt identifier ::= [A-Za-z_][0-9A-Za-z_]*
.map identifier ::= $identifier
