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

int bal_return() {
  return (0);
}

int bal_simple_b() {
  int a = (0);
  int b = (a + 1);
}

int bal_simple_c() {
  int a = (0);
  int c = ((a) - 1);
  return c;
}

int bal_simple_d() {
  int a = (0);
  int d = (a * (1));
  return d;
}

int bal_simple_e() {
  int a = (0);
  int e = ((a) / (1));
  return e;
}

int bal_complex_b() {
  int a = (0);
  int b = ((a + 1) - (2));
  return b;
}

int bal_complex_c() {
  int a = (0);
  int c = ((a) * (1 / 2));
  return c;
}

int bal_complex_d() {
  int a = (0);
  int d = ((a + 1) - (2 * 3));
  return d;
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
                                                                    'identifier': 'bal_return',
                                                                    'routine': {'return': {'expression': {'value': '0'}}}},
                                                       'functions': {'function': {'type': 'int',
                                                                                  'identifier': 'bal_simple_b',
                                                                                  'routine': {'expression': {'type': 'int',
                                                                                                             'identifier': 'a',
                                                                                                             'op': '=',
                                                                                                             'expression': {'value': '0'}},
                                                                                              'routine': {'expression': {'type': 'int',
                                                                                                                         'identifier': 'b',
                                                                                                                         'op': '=',
                                                                                                                         'expression': {'identifier': 'a',
                                                                                                                                        'op': '+',
                                                                                                                                        'expression': {'value': '1'}}}}}},
                                                                     'functions': {'function': {'type': 'int',
                                                                                                'identifier': 'bal_simple_c',
                                                                                                'routine': {'expression': {'type': 'int',
                                                                                                                           'identifier': 'a',
                                                                                                                           'op': '=',
                                                                                                                           'expression': {'value': '0'}},
                                                                                                            'routine': {'expression': {'type': 'int',
                                                                                                                                       'identifier': 'c',
                                                                                                                                       'op': '=',
                                                                                                                                       'expression': {'_expression': {'identifier': 'a'},
                                                                                                                                                      'op': '-',
                                                                                                                                                      'expression': {'value': '1'}}},
                                                                                                                        'routine': {'return': {'expression': {'identifier': 'c'}}}}}},
                                                                                   'functions': {'function': {'type': 'int',
                                                                                                              'identifier': 'bal_simple_d',
                                                                                                              'routine': {'expression': {'type': 'int',
                                                                                                                                         'identifier': 'a',
                                                                                                                                         'op': '=',
                                                                                                                                         'expression': {'value': '0'}},
                                                                                                                          'routine': {'expression': {'type': 'int',
                                                                                                                                                     'identifier': 'd',
                                                                                                                                                     'op': '=',
                                                                                                                                                     'expression': {'identifier': 'a',
                                                                                                                                                                    'op': '*',
                                                                                                                                                                    'expression': {'value': '1'}}},
                                                                                                                                      'routine': {'return': {'expression': {'identifier': 'd'}}}}}},
                                                                                                 'functions': {'function': {'type': 'int',
                                                                                                                            'identifier': 'bal_simple_e',
                                                                                                                            'routine': {'expression': {'type': 'int',
                                                                                                                                                       'identifier': 'a',
                                                                                                                                                       'op': '=',
                                                                                                                                                       'expression': {'value': '0'}},
                                                                                                                                        'routine': {'expression': {'type': 'int',
                                                                                                                                                                   'identifier': 'e',
                                                                                                                                                                   'op': '=',
                                                                                                                                                                   'expression': {'_expression': {'identifier': 'a'},
                                                                                                                                                                                  'op': '/',
                                                                                                                                                                                  'expression': {'value': '1'}}},
                                                                                                                                                    'routine': {'return': {'expression': {'identifier': 'e'}}}}}},
                                                                                                               'functions': {'function': {'type': 'int',
                                                                                                                                          'identifier': 'bal_complex_b',
                                                                                                                                          'routine': {'expression': {'type': 'int',
                                                                                                                                                                     'identifier': 'a',
                                                                                                                                                                     'op': '=',
                                                                                                                                                                     'expression': {'value': '0'}},
                                                                                                                                                      'routine': {'expression': {'type': 'int',
                                                                                                                                                                                 'identifier': 'b',
                                                                                                                                                                                 'op': '=',
                                                                                                                                                                                 'expression': {'_expression': {'identifier': 'a',
                                                                                                                                                                                                                'op': '+',
                                                                                                                                                                                                                '_expression': {'value': '1'}},
                                                                                                                                                                                                'op': '-',
                                                                                                                                                                                                'expression': {'value': '2'}}},
                                                                                                                                                                  'routine': {'return': {'expression': {'identifier': 'b'}}}}}},
                                                                                                                             'functions': {'function': {'type': 'int',
                                                                                                                                                        'identifier': 'bal_complex_c',
                                                                                                                                                        'routine': {'expression': {'type': 'int',
                                                                                                                                                                                   'identifier': 'a',
                                                                                                                                                                                   'op': '=',
                                                                                                                                                                                   'expression': {'value': '0'}},
                                                                                                                                                                    'routine': {'expression': {'type': 'int',
                                                                                                                                                                                               'identifier': 'c',
                                                                                                                                                                                               'op': '=',
                                                                                                                                                                                               'expression': {'_expression': {'identifier': 'a'},
                                                                                                                                                                                                              'op': '*',
                                                                                                                                                                                                              'expression': {'value': '1',
                                                                                                                                                                                                                             'op': '/',
                                                                                                                                                                                                                             'expression': {'value': '2'}}}},
                                                                                                                                                                                'routine': {'return': {'expression': {'identifier': 'c'}}}}}},
                                                                                                                                           'functions': {'function': {'type': 'int',
                                                                                                                                                                      'identifier': 'bal_complex_d',
                                                                                                                                                                      'routine': {'expression': {'type': 'int',
                                                                                                                                                                                                 'identifier': 'a',
                                                                                                                                                                                                 'op': '=',
                                                                                                                                                                                                 'expression': {'value': '0'}},
                                                                                                                                                                                  'routine': {'expression': {'type': 'int',
                                                                                                                                                                                                             'identifier': 'd',
                                                                                                                                                                                                             'op': '=',
                                                                                                                                                                                                             'expression': {'_expression': {'identifier': 'a',
                                                                                                                                                                                                                                            'op': '+',
                                                                                                                                                                                                                                            '_expression': {'value': '1'}},
                                                                                                                                                                                                                            'op': '-',
                                                                                                                                                                                                                            'expression': {'value': '2',
                                                                                                                                                                                                                                           'op': '*',
                                                                                                                                                                                                                                           'expression': {'value': '3'}}}},
                                                                                                                                                                                              'routine': {'return': {'expression': {'identifier': 'd'}}}}}}}}}}}}}}}}}}
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[[{'LOC': {'tgt': '*bal_constant'}},
  [{'MOV': {'tgt': '*a', 'src': '#0'}}, {'RET': {'tgt': '*a'}}]],
 [[{'LOC': {'tgt': '*bal_symbol'}},
   [{'MOV': {'tgt': '*a', 'src': '#0'}},
    [{'MOV': {'tgt': '*b', 'src': '*a'}}, {'RET': {'tgt': '*b'}}]]],
  [[{'LOC': {'tgt': '*bal_return'}}, {'RET': {'tgt': '#0'}}],
   [[{'LOC': {'tgt': '*bal_simple_b'}},
     [{'MOV': {'tgt': '*a', 'src': '#0'}},
      {'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '*a', 'src': '#1'}}}}]],
    [[{'LOC': {'tgt': '*bal_simple_c'}},
      [{'MOV': {'tgt': '*a', 'src': '#0'}},
       [{'MOV': {'tgt': '*c', 'src': {'SUB': {'tgt': '*a', 'src': '#1'}}}},
        {'RET': {'tgt': '*c'}}]]],
     [[{'LOC': {'tgt': '*bal_simple_d'}},
       [{'MOV': {'tgt': '*a', 'src': '#0'}},
        [{'MOV': {'tgt': '*d', 'src': {'MUL': {'tgt': '*a', 'src': '#1'}}}},
         {'RET': {'tgt': '*d'}}]]],
      [[{'LOC': {'tgt': '*bal_simple_e'}},
        [{'MOV': {'tgt': '*a', 'src': '#0'}},
         [{'MOV': {'tgt': '*e', 'src': {'DIV': {'tgt': '*a', 'src': '#1'}}}},
          {'RET': {'tgt': '*e'}}]]],
       [[{'LOC': {'tgt': '*bal_complex_b'}},
         [{'MOV': {'tgt': '*a', 'src': '#0'}},
          [{'MOV': {'tgt': '*b',
                    'src': {'SUB': {'tgt': {'ADD': {'tgt': '*a', 'src': '#1'}},
                                    'src': '#2'}}}},
           {'RET': {'tgt': '*b'}}]]],
        [[{'LOC': {'tgt': '*bal_complex_c'}},
          [{'MOV': {'tgt': '*a', 'src': '#0'}},
           [{'MOV': {'tgt': '*c',
                     'src': {'MUL': {'tgt': '*a',
                                     'src': {'DIV': {'tgt': '#1',
                                                     'src': '#2'}}}}}},
            {'RET': {'tgt': '*c'}}]]],
         [{'LOC': {'tgt': '*bal_complex_d'}},
          [{'MOV': {'tgt': '*a', 'src': '#0'}},
           [{'MOV': {'tgt': '*d',
                     'src': {'SUB': {'tgt': {'ADD': {'tgt': '*a', 'src': '#1'}},
                                     'src': {'MUL': {'tgt': '#2',
                                                     'src': '#3'}}}}}},
            {'RET': {'tgt': '*d'}}]]]]]]]]]]]]
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
bal_return:
	push rbp
	mov rbp, rsp
	mov rax, 0
	pop rbp
	ret
bal_simple_b:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	add rax, 1
	mov rbp-2, rax
bal_simple_c:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	sub rax, 1
	mov rbp-2, rax
	pop rbp
	ret
bal_simple_d:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, 1
	mul rax, rbp-0
	mov rbp-2, rax
	pop rbp
	ret
bal_simple_e:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	div rax, 1
	mov rbp-2, rax
	pop rbp
	ret
bal_complex_b:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, rbp-0
	add rax, 1
	sub rax, 2
	mov rbp-2, rax
	pop rbp
	ret
bal_complex_c:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, 1
	div rax, 2
	mul rax. rbp-0
	mov rbp-2, rax
	pop rbp
	ret
bal_complex_d:
	push rbp
	mov rbp, rsp
	mov rbp-0, 0
	mov rax, 2
	mul rax, 3
	mov rbp-4, rax
	mov rax, rbp-0
	add rax, 1
	sub rax, rbp-4
	mov rbp-2, rax
	pop rbp
	ret

