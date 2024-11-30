――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  int a = 1;
  int b = a + 2;
  return b + 3;
}

int notmain() {
  int d = 1 + 2;
  return d + 3;
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'function': {'type': 'int',
               'identifier': 'main',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '1'}},
                           'routine': {'expression': {'type': 'int',
                                                      'identifier': 'b',
                                                      'op': '=',
                                                      'expression': {'identifier': 'a',
                                                                     'op': '+',
                                                                     'expression': {'value': '2'}}},
                                       'routine': {'return': {'expression': {'identifier': 'b',
                                                                             'op': '+',
                                                                             'expression': {'value': '3'}}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'notmain',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'd',
                                          'op': '=',
                                          'expression': {'value': '1',
                                                         'op': '+',
                                                         'expression': {'value': '2'}}},
                           'routine': {'return': {'expression': {'identifier': 'd',
                                                                 'op': '+',
                                                                 'expression': {'value': '3'}}}}}}}]
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 [{'MOV': {'tgt': '*a', 'src': '#1'}},
  [{'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '*a', 'src': '#2'}}}},
   {'RET': {'tgt': {'ADD': {'tgt': '*b', 'src': '#3'}}}}]],
 {'LOC': {'tgt': '*notmain'}},
 [{'MOV': {'tgt': '*d', 'src': {'ADD': {'tgt': '#1', 'src': '#2'}}}},
  {'RET': {'tgt': {'ADD': {'tgt': '*d', 'src': '#3'}}}}]]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
main:
	push rbp
	mov rbp, rsp
	mov rbp-0, 1
	mov rax, rbp-0
	add rax, 2
	mov rbp-2, rax
	add rax, 3
	pop rbp
	ret
notmain:
	push rbp
	mov rbp, rsp
	mov rax, 2
	add rax, 1
	mov rbp-0, rax
	add rax, 3
	pop rbp
	ret

