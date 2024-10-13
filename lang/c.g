.del (\n|\t)

.fmt function ::= (?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}

.fmt routine ::= \s*(?P<assignment>[^;]*;)(?P<routine>[^;]*;)\s*
               | \s*(?P<assignment>[^;]*;)\s*
               | \s*(?P<expression>[^;]*;)(?P<routine>[^;]*;)\s*
               | \s*(?P<expression>[^;]*;)\s*
               | \s*(?P<return>[^;]*;)\s*

.fmt assignment ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<expression>[^;]*;)

.fmt expression ::= (?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
                  | (?P<value>\w+);

.fmt return ::= return\s+(?P<value>\w+);

.fmt op ::= \+|-|\*|/

.fmt type ::= int

.fmt value ::= -?0x[0-9A-Fa-f]+
             | -?[0-9]+

.fmt identifier ::= [A-Za-z_][0-9A-Za-z_]*