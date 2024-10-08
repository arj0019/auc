.del (\n|\t)

<function> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\(\)\s*\{(?P<routine>.*?)\}

<routine> ::= \s*(?P<expression>[^;]*;)(?P<routine>[^;]*;)\s*
            | \s*(?P<expression>[^;]*;)\s*
            | \s*(?P<return>[^;]*;)\s*

<expression> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*(?P<op>\S+)\s*(?P<expression>[^;]*;)
               | (?P<value>\w+);

<return> ::= return\s+(?P<value>\w+);

<op> ::= \+|-|\*|/|=|<=|<|>=|>

<type> ::= int

<value> ::= -?0x[0-9A-Fa-f]+
          | -?[0-9]+

<identifier> ::= [A-Za-z_][0-9A-Za-z_]*
