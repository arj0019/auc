.del (\n|\t)

<routine> ::= (?P<expression>[^;]*;)(?P<routine>[^;]*;)
            | (?P<expression>[^;]*;)

<expression> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<expression>[^;]*;)
               | (?P<value>\w+);

<type> ::= int

<value> ::= -?0x[0-9A-Fa-f]
          | -?[0-9]+

<identifier> ::= [A-Za-z_][0-9A-Za-z_]*
