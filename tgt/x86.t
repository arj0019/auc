.del (\n|\t)

.map LOC ::= LOC #tgt
.fmt LOC ::= $tgt:

.map MOV ::= MOV *tgt, !src
           | MOV *tgt, *src
           | MOV *tgt, #src
.fmt MOV ::= &src\n
             mov &tgt, [%rbp-8]
           | mov &tgt, &src
           | mov &tgt, $src

.map ADD ::= ADD *tgt, !src
           | ADD *tgt, *src
           | ADD *tgt, #src
           | ADD #tgt, !src
           | ADD #tgt, *src
           | ADD #tgt, #src
.fmt ADD ::= sub %rbp, 8
             mov [%rbp], &tgt;
             &src;
             add [%rbp], [%rbp-8]
             add %rbp, 8
           | sub %rbp, 8
             mov [%rbp], &tgt;
             add [%rbp], &src
             add %rbp, 8
           | sub %rbp, 8
             mov [%rbp], &tgt;
             add [%rbp], $src
             add %rbp, 8
           | sub rbp, 8
             mov [rbp], $tgt;
             &src;
             add [%rbp], [%rbp-8]
             add %rbp, 8
           | sub %rbp, 8
             mov [%rbp], $tgt;
             add [%rbp], &src
             add %rbp, 8
           | sub rbp, 8
             mov [%rbp], $tgt;
             add [%rbp], $src
             add %rbp, 8

.map RET ::= RET !tgt
           | RET *tgt
           | RET #tgt
.fmt RET ::= &tgt;
             mov eax, [%rbp-8]
             ret
           | mov eax, &tgt;
             ret
           | mov eax, $tgt;
             ret
