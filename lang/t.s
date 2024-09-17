<expression> ::= (?P<type>\w+)\s+(?P<identifier>\w+)\s*=\s*(?P<value>\w+)(?P<delimeter>.)

<delimeter> ::= ;

<type> ::= int

<identifier> ::= [A-Za-z_][0-9A-Za-z_]*

<value> ::= -?[0-9]+

<whitespace> ::= \s+
