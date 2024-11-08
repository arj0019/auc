.del (\n|\t)

.map return ::= RET &tgt
.fmt return ::= mov eax, {tgt}\nret
