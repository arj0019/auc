<function> ::= <type>\s+<identifier>\s*\(\s*<args>\s*\)\s*\{\s*<routine>\s*\}

<args> ::= <type>\s+<identifier>\s*,\s*<args>
         | <type>\s+<identifier>\s*,?

<routine> ::= <equation><routine>
            | <equation>
            | <expression><routine>
            | <expression>

<equation> ::= <type>\s+<identifier>\s*=\s*<expression>;

<expression> ::= <value>\s*<op>\s*<expression>
               | <value>;

<identifier>  ::= [A-Za-z_][0-9A-Za-z_]*

<value> ::= "[A-Za-z_][0-9A-Za-z_]*"
          | -?0x[0-9A-Fa-f]+
          | -?[0-9]+

<type> ::= int | char | str

<op> ::= - | \+ | / | \*
