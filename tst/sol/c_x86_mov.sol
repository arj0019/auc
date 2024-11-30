――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int mov_symbol_symbol() {
  int a = 0;
  int b = a;
  return b;
}

int mov_symbol_expression() {
  int a = 0 + 1;
  return a;
}

int mov_symbol_constant() {
  int a = 0;
  return a;
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'function': {'type': 'int',
               'identifier': 'mov_symbol_symbol',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'identifier': 'a'}},
                                       'routine': {'return': {'expression': {'identifier': 'b'}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'mov_symbol_expression',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0',
                                                         'op': '+',
                                                         'expression': {'value': '1'}}},
                           'routine': {'return': {'expression': {'identifier': 'a'}}}}}},
 {'function': {'type': 'int',
               'identifier': 'mov_symbol_constant',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'return': {'expression': {'identifier': 'a'}}}}}}]
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*mov_symbol_symbol'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}},
  [{'MOV': {'tgt': '*b', 'src': '*a'}}, {'RET': {'tgt': '*b'}}]],
 {'LOC': {'tgt': '*mov_symbol_expression'}},
 [{'MOV': {'tgt': '*a', 'src': {'ADD': {'tgt': '#0', 'src': '#1'}}}},
  {'RET': {'tgt': '*a'}}],
 {'LOC': {'tgt': '*mov_symbol_constant'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}}, {'RET': {'tgt': '*a'}}]]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
mov_symbol_symbol:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rbp-2, rbp-0
	mov rax, rbp-2
	pop rbp
	ret
mov_symbol_expression:
	push rbp
	mov rbp, rsp
	mov rax, 1
	mov rbp-0, rax
	pop rbp
	ret
mov_symbol_constant:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	pop rbp
	ret

