――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int add_symbol_symbol() {
  int a = 0;
  int b = 1;
  int c = a + b;
  return c;
}

int add_symbol_expression() {
  int a = 0;
  int b = a + 1 + 2;
  return b;
}

int add_symbol_constant() {
  int a = 0;
  int b = a + 1;
  return b;
}

int add_constant_symbol() {
  int a = 0;
  int b = 1 + a;
  return b;
}

int add_constant_expression() {
  int a = 0 + 1 + 2;
  return a;
}

int add_constant_constant() {
  return 0 + 1;
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'function': {'type': 'int',
               'identifier': 'add_symbol_symbol',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'value': '1'}},
                                       'routine': {'expression': {'type': 'int',
                                                                  'identifier': 'c',
                                                                  'op': '=',
                                                                  'expression': {'identifier': 'a',
                                                                                 'op': '+',
                                                                                 'expression': {'identifier': 'b'}}},
                                                   'routine': {'return': {'expression': {'identifier': 'c'}}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'add_symbol_expression',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'identifier': 'a',
                                                                     'op': '+',
                                                                     'expression': {'value': '1',
                                                                                    'op': '+',
                                                                                    'expression': {'value': '2'}}}},
                                       'routine': {'return': {'expression': {'identifier': 'b'}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'add_symbol_constant',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'identifier': 'a',
                                                                     'op': '+',
                                                                     'expression': {'value': '1'}}},
                                       'routine': {'return': {'expression': {'identifier': 'b'}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'add_constant_symbol',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'value': '1',
                                                                     'op': '+',
                                                                     'expression': {'identifier': 'a'}}},
                                       'routine': {'return': {'expression': {'identifier': 'b'}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'add_constant_expression',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '0',
                                                         'op': '+',
                                                         'expression': {'value': '1',
                                                                        'op': '+',
                                                                        'expression': {'value': '2'}}}},
                           'routine': {'return': {'expression': {'identifier': 'a'}}}}}},
 {'function': {'type': 'int',
               'identifier': 'add_constant_constant',
               'routine': {'return': {'expression': {'value': '0',
                                                     'op': '+',
                                                     'expression': {'value': '1'}}}}}}]
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*add_symbol_symbol'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}},
  [{'MOV': {'tgt': '*b', 'src': '#1'}},
   [{'MOV': {'tgt': '*c', 'src': {'ADD': {'tgt': '*a', 'src': '*b'}}}},
    {'RET': {'tgt': '*c'}}]]],
 {'LOC': {'tgt': '*add_symbol_expression'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}},
  [{'MOV': {'tgt': '*b',
            'src': {'ADD': {'tgt': '*a',
                            'src': {'ADD': {'tgt': '#1', 'src': '#2'}}}}}},
   {'RET': {'tgt': '*b'}}]],
 {'LOC': {'tgt': '*add_symbol_constant'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}},
  [{'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '*a', 'src': '#1'}}}},
   {'RET': {'tgt': '*b'}}]],
 {'LOC': {'tgt': '*add_constant_symbol'}},
 [{'MOV': {'tgt': '*a', 'src': '#0'}},
  [{'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '#1', 'src': '*a'}}}},
   {'RET': {'tgt': '*b'}}]],
 {'LOC': {'tgt': '*add_constant_expression'}},
 [{'MOV': {'tgt': '*a',
           'src': {'ADD': {'tgt': '#0',
                           'src': {'ADD': {'tgt': '#1', 'src': '#2'}}}}}},
  {'RET': {'tgt': '*a'}}],
 {'LOC': {'tgt': '*add_constant_constant'}},
 {'RET': {'tgt': {'ADD': {'tgt': '#0', 'src': '#1'}}}}]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
add_symbol_symbol:
	push rbp
	mov rbp, rsp
	mov rbp-2, 0
	mov rbp-4, 1
	mov rax, rbp-2
	add rax, rbp-4
	mov rbp-6, rax
	pop rbp
	ret
add_symbol_expression:
	push rbp
	mov rbp, rsp
	mov rbp-2, 0
	mov rax, 2
	add rax, 1
	add rax, rbp-2
	mov rbp-4, rax
	pop rbp
	ret
add_symbol_constant:
	push rbp
	mov rbp, rsp
	mov rbp-2, 0
	mov rax, rbp-2
	add rax, 1
	mov rbp-4, rax
	pop rbp
	ret
add_constant_symbol:
	push rbp
	mov rbp, rsp
	mov rbp-2, 0
	mov rax, 1
	add rax, rbp-2
	mov rbp-4, rax
	pop rbp
	ret
add_constant_expression:
	push rbp
	mov rbp, rsp
	mov rax, 2
	add rax, 1
	mov rbp-2, rax
	pop rbp
	ret
add_constant_constant:
	push rbp
	mov rbp, rsp
	mov rax, 1
	pop rbp
	ret

