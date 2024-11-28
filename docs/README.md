# ECC (Expressive Compiler Collection)
Assembly compilers generated from regular expressions inspired by Backus Naur form.
```
usage: ecc [-h] [-v {INFO,WARNING,ERROR}] source target code

x86 assembly compilers generated from Backus Naur grammar extended with regular expressions

positional arguments:
  source                source grammar file path
  target                target grammar file path
  code                  source code file path

optional arguments:
  -h, --help            show this help message and exit
  -v {INFO,WARNING,ERROR}, --verbose {INFO,WARNING,ERROR}
                        Set the logging level (default: WARNING).
```


## DUC (pseudo-C x86 compiler)
DUC is a C-like compiler developed concurrently with the ECC framework that is used to explore and implement compiler construction concepts. The executable is effectively an alias for `ecc.py` with the source and target grammars pre-selected.

For example, the logged output of `./duc -v DEBUG ./tst/fun.c` is...

```
――― Source Deletions ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
['(\\n|\\t)']
――― Source Substitutions ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[]
――― Source Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'function': ['\\s*(?P<type>\\w+)\\s+(?P<identifier>\\w+)\\(\\)\\s*\\{(?P<routine>.*?)\\}'],
 'routine': ['\\s*(?P<expression>[^;]*;)(?P<routine>.*;)',
             '\\s*(?P<expression>[^;]*;)',
             '\\s*(?P<return>[^;]*;)'],
 'expression': ['(?P<type>\\w+)\\s+(?P<identifier>\\w+)\\s*(?P<op>\\S+)\\s*(?P<expression>[^;]*;)',
                '(?P<identifier>\\w+)\\s*(?P<op>\\S+)\\s*(?P<expression>[^;]*;)',
                '(?P<value>\\w+)\\s*(?P<op>\\S+)\\s*(?P<expression>[^;]*;)',
                '(?P<identifier>\\w+);',
                '(?P<value>\\w+);'],
 'return': ['return\\s+(?P<expression>[^;]*;)',
            'return\\s+(?P<value>\\w+);',
            'return\\s+(?P<identifier>\\w+);'],
 'op': ['=', '\\+', '-', '\\*', '/'],
 'type': ['int'],
 'value': ['-?0x[0-9A-Fa-f]+', '-?[0-9]+'],
 'identifier': ['[A-Za-z_][0-9A-Za-z_]*']}
――― Source Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'function': [[{'opc': 'LOC', 'tgt': '&identifier', 'src': None},
               {'opc': '&routine', 'tgt': None, 'src': None}]],
 'routine': [[{'opc': '&expression', 'tgt': None, 'src': None},
              {'opc': '&routine', 'tgt': None, 'src': None}],
             [{'opc': '&expression', 'tgt': None, 'src': None}],
             [{'opc': '&return', 'tgt': None, 'src': None}]],
 'expression': [[{'opc': '&op', 'tgt': '&identifier', 'src': '&expression'}],
                [{'opc': '&op', 'tgt': '&identifier', 'src': '&expression'}],
                [{'opc': '&op', 'tgt': '&value', 'src': '&expression'}],
                [{'opc': '&identifier', 'tgt': None, 'src': None}],
                [{'opc': '&value', 'tgt': None, 'src': None}]],
 'return': [[{'opc': 'RET', 'tgt': '&expression', 'src': None}],
            [{'opc': 'RET', 'tgt': '&value', 'src': None}],
            [{'opc': 'RET', 'tgt': '&identifier', 'src': None}]],
 'op': [[{'opc': 'MOV', 'tgt': None, 'src': None}],
        [{'opc': 'ADD', 'tgt': None, 'src': None}],
        [{'opc': 'SUB', 'tgt': None, 'src': None}],
        [{'opc': 'MUL', 'tgt': None, 'src': None}],
        [{'opc': 'DIV', 'tgt': None, 'src': None}]],
 'value': [[{'opc': '#value', 'tgt': None, 'src': None}],
           [{'opc': '#value', 'tgt': None, 'src': None}]],
 'identifier': [[{'opc': '*identifier', 'tgt': None, 'src': None}]]}
――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  int a = 1;
  int b = a + 2;
  return b + 3;
}

int notmain() {
  int d = 1 + 2;
  return d + 3;
}

――― Source Code (Pre-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {  int a = 1;  int b = a + 2;  return b + 3;}int notmain() {  int d = 1 + 2;  return d + 3;}
――― Abstract Syntax ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
――― Internal Representation ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 [{'MOV': {'tgt': '*a', 'src': '#1'}},
  [{'MOV': {'tgt': '*b', 'src': {'ADD': {'tgt': '*a', 'src': '#2'}}}},
   {'RET': {'tgt': {'ADD': {'tgt': '*b', 'src': '#3'}}}}]],
 {'LOC': {'tgt': '*notmain'}},
 [{'MOV': {'tgt': '*d', 'src': {'ADD': {'tgt': '#1', 'src': '#2'}}}},
  {'RET': {'tgt': {'ADD': {'tgt': '*d', 'src': '#3'}}}}]]
――― Target Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'CALL': ['CALL *tgt'],
 'LOC': ['LOC *tgt'],
 'MOV': ['MOV *tgt, &src', 'MOV *tgt, #src'],
 'ADD': ['ADD *tgt, #src', 'ADD #tgt, &src', 'ADD #tgt, #src'],
 'SUB': ['SUB #tgt, &src', 'SUB #tgt, #src'],
 'RET': ['RET *tgt', 'RET &tgt', 'RET #tgt']}
――― Target Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'LOC': ['$tgt:\\n\\tpush rbp\\n\\tmov rbp, rsp\\n'],
 'MOV': ['&src\\tpop rax\\n\\tmov rbp-!tgt, rax\\n',
         '\\tmov rbp-!tgt, $src\\n'],
 'ADD': ['\\tmov rax, rbp-&tgt\\n\\tadd rax, $src\\n\\tpush rax\\n',
         '&src\\tpop rax\\n\\tadd rax, $tgt\\n\\tpush rax\\n',
         '\\tmov rax, $src\\n\\tadd rax, $tgt\\n\\tpush rax\\n'],
 'SUB': ['&src\\tpop rbp\\n\\tmov rax, $tgt\\n\\tsub rax, rbp\\n\\tpush rax\\n',
         '\\tmov rax, $tgt\\n\\tsub rax, $src\\n\\tpush rax\\n'],
 'RET': ['\\tmov rax, rbp-&tgt\\n\\tret\\n',
         '&tgt\\tpop rax\\n\\tpop rbp\\n\\tret\\n',
         '\\tmov rax, $tgt\\n\\tpop rbp\\n\\tret\\n']}
――― Target Deletions ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
['\\tpush rax\\n\\tpop rax\\n', '\\tadd [^\\n]*, 0\\n', '\\tsub [^\\n]*, 0\\n']
――― Target Substitutions ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[('\\tmov ([^\\n]*), ([^\\n]*)\\n\\tmov \\2, \\1\\n', '\\tmov \\1, \\2\\n')]
――― Target Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
main:
  push rbp
  mov rbp, rsp
  mov rbp-2, 1
  mov rax, rbp-2
  add rax, 2
  push rax
  pop rax
  mov rbp-4, rax
  mov rax, rbp-4
  add rax, 3
  push rax
  pop rax
  pop rbp
  ret
notmain:
  push rbp
  mov rbp, rsp
  mov rax, 2
  add rax, 1
  push rax
  pop rax
  mov rbp-2, rax
  mov rax, rbp-2
  add rax, 3
  push rax
  pop rax
  pop rbp
  ret

――― Target Code (Post-Processed) ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
main:
  push rbp
  mov rbp, rsp
  mov rbp-2, 1
  mov rax, rbp-2
  add rax, 2
  mov rbp-4, rax
  add rax, 3
  pop rbp
  ret
notmain:
  push rbp
  mov rbp, rsp
  mov rax, 2
  add rax, 1
  mov rbp-2, rax
  add rax, 3
  pop rbp
  ret
```


## References
#### Compiler Theory/Construction
\- https://chatgpt.com

\- https://norasandler.com/2017/11/29/Write-a-Compiler.html

#### Regular Expressions
\- https://docs.python.org/3/library/re.html

#### Backus Naur Form
\- https://en.wikipedia.org/wiki/Backus–Naur_form

#### Tools
\- https://regex101.com

\- https://jsonviewer.stack.hu
