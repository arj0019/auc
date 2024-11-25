.map LOC ::= LOC *tgt
.fmt LOC ::= $tgt:\n
             \tpush rbp\n
             \tmov rbp, rsp\n

.map ADD ::= ADD #tgt, &src
           | ADD #tgt, #src
.fmt ADD ::= &src
             \tpop rax\n
             \tadd rax, $tgt\n
             \tpush rax\n
           | \tmov rax, $src\n
             \tadd rax, $tgt\n
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

.del \tpush rax\n
     \tpop rax\n
.del \tadd [^\n]*, 0\n
