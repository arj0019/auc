.map LOC ::= LOC *tgt
.fmt LOC ::= $tgt:\n
             \tpush rbp\n
             \tmov rbp, rsp\n

.map ADD ::= ADD #tgt, #src
.fmt ADD ::= \tmov rax, $tgt\n
             \tadd rax, $src\n
             \tpush rax\n

.map RET ::= RET &tgt
           | RET #tgt
.fmt RET ::= &tgt
             \tpop rax\n
             \tpop rbp\n
             \tret\n
           | \tmov rax, $tgt\n
             \tpop rbp\n
             \tret\n
