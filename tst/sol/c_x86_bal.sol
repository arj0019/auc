――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int bal_constant() {
  int a = (0);
  return a;
}

int bal_symbol() {
  int a = (0);
  int b = (a);
  return b;
}

int bal_expression() {
  int a = (0);
  int b = (a + 1);
  int c = ((a) + 2);
  int d = (a + (3));
  int e = ((a) + (4));
  int f = ((a) + (5 + 6));
  return f;
}

int bal_return() {
  return (0);
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'program': {'functions': {'function': {'type': 'int',
                                        'identifier': 'bal_constant',
                                        'routine': {'expression': {'type': 'int',
                                                                   'identifier': 'a',
                                                                   'op': '=',
                                                                   'expression': {'value': '0'}},
                                                    'routine': {'return': {'expression': {'identifier': 'a'}}}}},
                           'functions': {'function': {'type': 'int',
                                                      'identifier': 'bal_symbol',
                                                      'routine': {'expression': {'type': 'int',
                                                                                 'identifier': 'a',
                                                                                 'op': '=',
                                                                                 'expression': {'value': '0'}},
                                                                  'routine': {'expression': {'type': 'int',
                                                                                             'identifier': 'b',
                                                                                             'op': '=',
                                                                                             'expression': {'identifier': 'a'}},
                                                                              'routine': {'return': {'expression': {'identifier': 'b'}}}}}},
                                         'functions': {'function': {'type': 'int',
                                                                    'identifier': 'bal_expression',
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
                                                                                            'routine': {'expression': {'type': 'int',
                                                                                                                       'identifier': 'c',
                                                                                                                       'op': '=',
                                                                                                                       'expression': {'identifier': 'a',
                                                                                                                                      'op': '+',
                                                                                                                                      'expression': {'value': '2'}}},
                                                                                                        'routine': {'expression': {'type': 'int',
                                                                                                                                   'identifier': 'd',
                                                                                                                                   'op': '=',
                                                                                                                                   'expression': {'identifier': 'a',
                                                                                                                                                  'op': '+',
                                                                                                                                                  'expression': {'value': '3'}}},
                                                                                                                    'routine': {'expression': {'type': 'int',
                                                                                                                                               'identifier': 'e',
                                                                                                                                               'op': '=',
                                                                                                                                               'expression': {'identifier': 'a',
                                                                                                                                                              'op': '+',
                                                                                                                                                              'expression': {'value': '4'}}},
                                                                                                                                'routine': {'expression': {'type': 'int',
                                                                                                                                                           'identifier': 'f',
                                                                                                                                                           'op': '=',
                                                                                                                                                           'expression': {'identifier': 'a',
                                                                                                                                                                          'op': '+',
                                                                                                                                                                          'expression': {'value': '5',
                                                                                                                                                                                         'op': '+',
                                                                                                                                                                                         'expression': {'value': '6'}}}},
                                                                                                                                            'routine': {'return': {'expression': {'identifier': 'f'}}}}}}}}}},
                                                       'functions': {'function': {'type': 'int',
                                                                                  'identifier': 'bal_return',
                                                                                  'routine': {'return': {'expression': {'value': '0'}}}}}}}}}}
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[[{'LOC': {'tgt': '*bal_constant'}},
  [{'MOV': {'tgt': '*a', 'src': '#0'}}, {'RET': {'tgt': '*a'}}]],
 [[{'LOC': {'tgt': '*bal_symbol'}},
   [{'MOV': {'tgt': '*a', 'src': '#0'}},
    [{'MOV': {'tgt': '*b', 'src': '*a'}}, {'RET': {'tgt': '*b'}}]]],
  [[{'LOC': {'tgt': '*bal_expression'}},
    [{'MOV': {'tgt': '*a', 'src': '#0'}},
     [{'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '*a', 'src': '#1'}}}},
      [{'MOV': {'tgt': '*c', 'src': {'ADD': {'tgt': '*a', 'src': '#2'}}}},
       [{'MOV': {'tgt': '*d', 'src': {'ADD': {'tgt': '*a', 'src': '#3'}}}},
        [{'MOV': {'tgt': '*e', 'src': {'ADD': {'tgt': '*a', 'src': '#4'}}}},
         [{'MOV': {'tgt': '*f',
                   'src': {'ADD': {'tgt': '*a',
                                   'src': {'ADD': {'tgt': '#5',
                                                   'src': '#6'}}}}}},
          {'RET': {'tgt': '*f'}}]]]]]]],
   [{'LOC': {'tgt': '*bal_return'}}, {'RET': {'tgt': '#0'}}]]]]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
bal_constant:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	pop rbp
	ret
bal_symbol:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rbp-2, rbp-0
	mov rax, rbp-2
	pop rbp
	ret
bal_expression:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	add rax, 1
	mov rbp-2, rax
	mov rax, rbp-0
	add rax, 2
	mov rbp-4, rax
	mov rax, rbp-0
	add rax, 3
	mov rbp-6, rax
	mov rax, rbp-0
	add rax, 4
	mov rbp-8, rax
	mov rax, 6
	add rax, 5
	add rax, rbp-0
	mov rbp-10, rax
	pop rbp
	ret
bal_return:
	push rbp
	mov rbp, rsp
	mov rax, 0
	pop rbp
	ret

