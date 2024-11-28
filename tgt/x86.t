.map CALL ::= CALL *tgt
.fmt CALL :: \tcall $tgt\n

.map LOC ::= LOC *tgt
.fmt LOC ::= $tgt:\n
             \tpush rbp\n
             \tmov rbp, rsp\n

.map MOV ::= MOV *tgt, &src
           | MOV *tgt, #src
.fmt MOV ::= &src
             \tpop rax\n
             \tmov rbx-!tgt, rax\n
           | \tmov rbx-!tgt, $src\n

.map ADD ::= ADD *tgt, #src
           | ADD #tgt, &src
           | ADD #tgt, #src
.fmt ADD ::= \tmov rax, rbx-&tgt\n
             \tadd rax, $src\n
             \tpush rax\n
           | &src
             \tpop rax\n
             \tadd rax, $tgt\n
             \tpush rax\n
           | \tmov rax, $src\n
             \tadd rax, $tgt\n
             \tpush rax\n

.map SUB ::= SUB #tgt, &src
           | SUB #tgt, #src
.fmt SUB ::= &src
             \tpop rbx\n
             \tmov rax, $tgt\n
             \tsub rax, rbx\n
             \tpush rax\n
           | \tmov rax, $tgt\n
             \tsub rax, $src\n
             \tpush rax\n

.map RET ::= RET *tgt
           | RET &tgt
           | RET #tgt
.fmt RET ::= \tmov rax, rbx-&tgt\n
             \tret\n
           | &tgt
             \tpop rax\n
             \tpop rbp\n
             \tret\n
           | \tmov rax, $tgt\n
             \tpop rbp\n
             \tret\n

.del \tpush rax\n
     \tpop rax\n
.del \tadd [^\n]*, 0\n
.del \tsub [^\n]*, 0\n
