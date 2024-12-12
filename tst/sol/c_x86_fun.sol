――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  int a = ((1 + 2) / (3 * 4));
  return a;
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'program': {'functions': {'function': {'type': 'int',
                                        'identifier': 'main',
                                        'routine': {'expression': {'type': 'int',
                                                                   'identifier': 'a',
                                                                   'op': '=',
                                                                   'expression': {'_expression': {'value': '1',
                                                                                                  'op': '+',
                                                                                                  '_expression': {'value': '2'}},
                                                                                  'op': '/',
                                                                                  'expression': {'value': '3',
                                                                                                 'op': '*',
                                                                                                 'expression': {'value': '4'}}}},
                                                    'routine': {'return': {'expression': {'identifier': 'a'}}}}}}}}
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 [{'MOV': {'tgt': '*a',
           'src': {'DIV': {'tgt': {'ADD': {'tgt': '#1', 'src': '#2'}},
                           'src': {'MUL': {'tgt': '#3', 'src': '#4'}}}}}},
  {'RET': {'tgt': '*a'}}]]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
main:
	push rbp
	mov rbp, rsp
	mov rax, 3
	mul rax, 4
	mov rbp-2, rax
	mov rax, 2
	add rax, 1
	div rax, rbp-2
	mov rbp-0, rax
	pop rbp
	ret

