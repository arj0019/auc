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

## Grammar Definitions
A compiler in ECC is generated from source and target grammars; they define the mapping of formatted code to an internal representation.
<br/><br/>

Formatted code can be pre/post-processed with the delete and substitute instructions.
```
DEL = r'\.del\s+(?P<tgt>.+?)(?=\.\w+\s+|$)'
SUB = r'\.sub\s+(?P<tgt>.+?);(?P<src>.+?)(?=\.\w+\s+|$)'
```
For example, whitespace can be elimintated from source code to simplify the source grammar definition...
```
.del (\n|\t)
```
Additionally, deadcode patterns in target code can be substituted with semantically equivalent expressions...
```
.sub \tmov ([^\n]*), ([^\n]*)\n\tmov \2, \1\n;\tmov \1, \2\n
```
<br/>

Variants of the formatting and mapping of a symbol may be defined using `OR = r'\s*\|\s*'`.

Formats define the structure of code; they are python regular expressions extended with nested grouping.
- The assotiated symbol should have a corresponding mapping defined.
- Nested groups are inferred as named groups within the format expression; they should be defined elsewhere.
```
FMT = r'\.fmt\s+(?P<sym>\w+)\s*::=\s*(?P<exprs>.*?)(?=\.\w+\s+|$)'
```

Maps define the internal representation of the corresponding format; they are matched to the instruction expression.
- Within a mapping variant, a series of instructions can be delimited with `AND = r'\s*;\s*'`.
- Instructions consist of an opcode, and optionally a target and source operand.
- In the case that there is no operand, the opcode becomes the operand; this is how terminal values are represented.
```
MAP = r'\.map\s+(?P<sym>\w+)\s*::=\s*(?P<exprs>.*?)(?=\.\w+\s+|$)'
INS = r'(?P<opc>[&*#]?\w+)(?:\s+(?P<tgt>[&*#]\w+))?\s*(?:,\s*(?P<src>[&*#]\w+))?'
```

### Source Grammar
A source grammar defines the mapping of formatted source code to an internal representation.

Source code parsing may be restricted to specific 'entry points' by defining symbols as an origin.
- If no parsing origins are defined, all symbols qualify as parsing origins.
```
ORG = r'\.org\s+(?P<tgt>.+?)(?=\.\w+\s+|$)'
```

For example, an independent `expression` will result in a syntax error if `function` is defined as the only origin...
```
.org function
```

Source maps may contain control characters that are interpreted and handled as defined below...
- `*[symbol]`: Map symbol format to a tracked symbol; its location may be stored in the symbol table.
- `&[symbol]`: Map symbol format to a complex object; it is typically a nested internal representation.
- `#[symbol]`: Map symbol format to an explicit value; this is a terminal, such as a number.

Multiple instructions may be defined within a source grammar mapping variant with `AND = r'\s*\;\s*'`.

For example, the source formatting and mapping of `return` could be defined as...
```
.fmt return ::= return\s+(?P<value>\w+);
              | return\s+(?P<identifier>\w+);
.map return ::= RET &value
              | RET &identifier

.fmt value ::= -?0x[0-9A-Fa-f]+
             | -?[0-9]+
.map value ::= #value
             | #value

.fmt identifier ::= [A-Za-z_][0-9A-Za-z_]*
.map identifier ::= *identifier
```

### Target Grammar
A target grammar defines the mapping of an internal representation to formatted target code.

Target maps may contain control characters that are interpreted and handled as defined below...
- `*[tgt|src]`: Interpret field content to a tracked symbol; its location may be stored in the symbol table.
- `&[tgt|src]`: Interpret field content to a complex object; it is typically a nested internal representation.
- `#[tgt|src]`: Interpret field content to an explicit value; this is a terminal, such as a number.

Target formats may contain control characters that are interpreted and handled as defined below...
- `![tgt|src]`: Declare and format with an incremented offset from the relative base pointer, if that mapped is typed as `*` or `&`.
- `&[tgt|src]`: Format as the corresponding offset from the relative base pointer, if that mapped is typed as `*`.
- `&[tgt|src]`: Format as the expansion of its corresponding field, if that field is mapped as `&`.
- `$[tgt|src]`: Format as the explicit value of the corresponding field, if that field is mapped as `#`.

For example, the target formatting and mapping of `return` could be defined as...
```
.map RET ::= RET *tgt
           | RET &tgt
           | RET #tgt
.fmt RET ::= \tmov rax, rbp-&tgt\n
             \tpop rbp\n
             \tret\n
           | &tgt
             \tpop rbp\n
             \tret\n
           | \tmov rax, $tgt\n
             \tpop rbp\n
             \tret\n
```

## DUC (pseudo-C x86 compiler)
DUC is a C-like compiler developed concurrently with the ECC framework that is used to explore and implement compiler construction concepts. The executable is effectively an alias for `ecc.py` with the source and target grammars pre-selected.
<br/><br/>

For example, the logged output of `./duc -v INFO ./tst/fun.c` is...

```
――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  int a = ((1 + 2) / (3 * 4));
  return a;
}

――― Abstract Syntax ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
――― Internal Representation ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}},
 [{'MOV': {'tgt': '*a',
           'src': {'DIV': {'tgt': {'ADD': {'tgt': '#1', 'src': '#2'}},
                           'src': {'MUL': {'tgt': '#3', 'src': '#4'}}}}}},
  {'RET': {'tgt': '*a'}}]]
――― Target Code (Post-Processed) ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
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
