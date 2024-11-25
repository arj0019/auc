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

For example, the logged output of `./duc -v DEBUG ./tst/retexpr.c` is...

```
――― Source Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
――― Source Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  return 0 + 1;
}
――― Abstract Syntax ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'function': {'type': 'int',
              'identifier': 'main',
              'routine': {'return': {'expression': {'value': '0',
                                                    'op': '+',
                                                    'expression': {'value': '1'}}}}}}
――― Internal Representation ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 {'RET': {'tgt': {'ADD': {'tgt': '#0', 'src': '#1'}}}}]
――― Target Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'LOC': ['LOC *tgt'],
 'ADD': ['ADD #tgt, &src', 'ADD #tgt, #src'],
 'RET': ['RET &tgt', 'RET #tgt']}
――― Target Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'LOC': ['$tgt:\\n\\tpush rbp\\n\\tmov rbp, rsp\\n'],
 'ADD': ['&src\\tpop rax\\n\\tadd rax, $tgt\\n\\tpush rax\\n',
         '\\tmov rax, $src\\n\\tadd rax, $tgt\\n\\tpush rax\\n'],
 'RET': ['&tgt\\tpop rax\\n\\tpop rbp\\n\\tret\\n',
         '\\tmov rax, $tgt\\n\\tpop rbp\\n\\tret\\n']}
――― Target Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
main:
  push rbp
  mov rbp, rsp
  mov rax, 1
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
