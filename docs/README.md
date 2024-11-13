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

For example, the logged output of `./duc -v INFO ./tst/fun.c` is...

```
――― Source Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
――― Source Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'function': [[{'key': 'LOC', 'tgt': '&identifier', 'src': None},
               {'key': '&routine', 'tgt': None, 'src': None}]],
 'routine': [[{'key': '&expression', 'tgt': None, 'src': None},
              {'key': '&routine', 'tgt': None, 'src': None}],
             [{'key': '&expression', 'tgt': None, 'src': None}],
             [{'key': '&return', 'tgt': None, 'src': None}]],
 'expression': [[{'key': '&op', 'tgt': '&identifier', 'src': '&expression'}],
                [{'key': '&op', 'tgt': '&identifier', 'src': '&expression'}],
                [{'key': '&op', 'tgt': '&value', 'src': '&expression'}],
                [{'key': '&identifier', 'tgt': None, 'src': None}],
                [{'key': '&value', 'tgt': None, 'src': None}]],
 'return': [[{'key': 'RET', 'tgt': '&expression', 'src': None}],
            [{'key': 'RET', 'tgt': '&value', 'src': None}],
            [{'key': 'RET', 'tgt': '&identifier', 'src': None}]],
 'op': [[{'key': 'MOV', 'tgt': None, 'src': None}],
        [{'key': 'ADD', 'tgt': None, 'src': None}],
        [{'key': 'SUB', 'tgt': None, 'src': None}],
        [{'key': 'MUL', 'tgt': None, 'src': None}],
        [{'key': 'DIV', 'tgt': None, 'src': None}]],
 'value': [[{'key': '#value', 'tgt': None, 'src': None}],
           [{'key': '#value', 'tgt': None, 'src': None}]],
 'identifier': [[{'key': '*identifier', 'tgt': None, 'src': None}]]}
――― Abstract Syntax ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'function': {'type': 'int',
               'identifier': 'main',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'a',
                                          'op': '=',
                                          'expression': {'value': '1',
                                                         'op': '+',
                                                         'expression': {'value': '2'}}},
                           'routine': {'return': {'expression': {'value': '3',
                                                                 'op': '+',
                                                                 'expression': {'identifier': 'a'}}}}}}},
 {'function': {'type': 'int',
               'identifier': 'notmain',
               'routine': {'expression': {'type': 'int',
                                          'identifier': 'b',
                                          'op': '=',
                                          'expression': {'value': '4'}}}}}]
――― Internal Representation ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 [{'MOV': {'tgt': '*a', 'src': {'ADD': {'tgt': '#1', 'src': '#2'}}}},
  {'RET': {'tgt': {'ADD': {'tgt': '#3', 'src': '*a'}}}}],
 {'LOC': {'tgt': '*notmain'}},
 {'MOV': {'tgt': '*b', 'src': '#4'}}]
――― Target Map ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'LOC': ['LOC #tgt'],
 'MOV': ['MOV *tgt, !src', 'MOV *tgt, *src', 'MOV *tgt, #src'],
 'ADD': ['ADD *tgt, !src',
         'ADD *tgt, *src',
         'ADD *tgt, #src',
         'ADD #tgt, !src',
         'ADD #tgt, *src',
         'ADD #tgt, #src'],
 'RET': ['RET !tgt', 'RET *tgt', 'RET #tgt']}
――― Target Grammar ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'LOC': [['$tgt:']],
 'MOV': [['&src', 'mov &tgt, [%rbp-8]'],
         ['mov &tgt, &src'],
         ['mov &tgt, $src']],
 'ADD': [['sub %rbp, 8',
          'mov [%rbp], &tgt',
          '&src',
          'add [%rbp], [%rbp-8]',
          'add %rbp, 8'],
         ['sub %rbp, 8', 'mov [%rbp], &tgt', 'add [%rbp], &src', 'add %rbp, 8'],
         ['sub %rbp, 8', 'mov [%rbp], &tgt', 'add [%rbp], $src', 'add %rbp, 8'],
         ['sub rbp, 8',
          'mov [rbp], $tgt',
          '&src',
          'add [%rbp], [%rbp-8]',
          'add %rbp, 8'],
         ['sub %rbp, 8', 'mov [%rbp], $tgt', 'add [%rbp], &src', 'add %rbp, 8'],
         ['sub rbp, 8', 'mov [%rbp], $tgt', 'add [%rbp], $src', 'add %rbp, 8']],
 'RET': [['&tgt', 'mov eax, [%rbp-8]', 'ret'],
         ['mov eax, &tgt', 'ret'],
         ['mov eax, $tgt', 'ret']]}
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
