.del (\n|\t)

.map MOV ::= MOV *tgt, #src
           | MOV *tgt, *src
.fmt MOV ::= mov &tgt, $src
           | mov &tgt, &src

.map ADD ::= ADD *tgt, #src
           | ADD *tgt, *src
.fmt ADD ::= add &tgt, $src
           | add &tgt, &src

.map RET ::= RET #tgt
           | RET *tgt
.fmt RET ::= mov eax, $tgt\nret
           | mov eax, &tgt\nret
