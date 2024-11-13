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
