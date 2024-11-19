.del (\n|\t)

.map LOC ::= LOC *tgt
.fmt LOC ::= $tgt:;
             \tpush rbp;
             \tmov rbp, rsp

.map RET ::= RET #tgt
.fmt RET ::= \tmov eax, $tgt;
             \tpop rbp;
             \tret
