.del (\n|\t)

<expression> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<expression>\w+);|(?P<value>\w+)

<type> ::= int

<value> ::= -?0x[0-9A-Fa-f]+|-?[0-9]+

<identifier> ::= [A-Za-z_][0-9A-Za-z_]*
