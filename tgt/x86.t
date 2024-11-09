.del (\n|\t)

.map MOV ::= MOV *tgt, !src
           | MOV *tgt, *src
           | MOV *tgt, #src
.fmt MOV ::= &src\n
             mov &tgt, %reg
           | mov &tgt, &src
           | mov &tgt, $src

.map ADD ::= ADD *tgt, !src
           | ADD *tgt, *src
           | ADD *tgt, #src
           | ADD #tgt, !src
           | ADD #tgt, *src
           | ADD #tgt, #src
.fmt ADD ::= mov %rax, &tgt;
             &src:%rbx;
             add %rax, %rbx
           | mov %rax, &tgt;
             add %rax, &src
           | mov %rax, &tgt;
             add %rax, $src
           | mov %rax, $tgt;
             &src:%rbx;
             add %rax, %rbx
           | mov %rax, $tgt;
             add %rax, &src
           | mov %rax, $tgt;
             add %rax, $src

.map RET ::= RET !tgt
           | RET *tgt
           | RET #tgt
.fmt RET ::= &src:%rax;
             ret
           | mov eax, &tgt;
             ret
           | mov eax, $tgt;
             ret
