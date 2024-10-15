.del (\n|\t)

.fmt function ::= \s*(?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}

.fmt routine ::= \s*(?P<assignment>[^;]*;)(?P<routine>[^;]*;)
               | \s*(?P<assignment>[^;]*;)
               | \s*(?P<expression>[^;]*;)(?P<routine>[^;]*;)
               | \s*(?P<expression>[^;]*;)
               | \s*(?P<return>[^;]*;)

.fmt assignment ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<expression>[^;]*;)
.map assignment ::= #MOV tgt:identifier, src:expression

.fmt expression ::= (?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+);
.map expression ::= op tgt:identifier, src:expression
                  | op tgt:value, src:expression
                  | value

.fmt return ::= return\s+(?P<value>\w+);
.map return ::= #RET

.fmt op ::= \+|-|\*|/
.map op ::= #ADD|#SUB|#MUL|#DIV

.fmt type ::= int

.fmt value ::= -?0x[0-9A-Fa-f]+
             | -?[0-9]+
.map value ::= value

.fmt identifier ::= [A-Za-z_][0-9A-Za-z_]*
.map identifier ::= identifier
