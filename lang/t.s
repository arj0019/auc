.del (\n|\t)

<expression> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<value>\w+)(?P<delimeter>.)

<delimeter> ::= ;

<type> ::= int

<value> ::= -?[0-9]+

<identifier> ::= [A-Za-z_][0-9A-Za-z_]*
