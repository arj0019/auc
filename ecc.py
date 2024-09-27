import argparse
from collections import OrderedDict
import pprint
import re
import shutil


TERMSIZE = shutil.get_terminal_size()  # get the terminal size for formatting


DEL = r'^\s*\.del\s+(.+)$'
BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.grammar = self._parse_grammar(grammar)

  def parse(self, source):
    _source = self.preprocess(source)
    return self._parse(_source, self.grammar.items())

  def _parse(self, source, targets):
    ast = []
    while source:  # sequentially match source to grammar
      for symbol, expression in targets:
        if not (match := re.match(expression, source, re.DOTALL)): continue

        source = source[match.end():]
        parsed_match = {symbol: {}}

        # recursively parse subexpressions (grammar references)
        if (_match := match.groupdict().items()):
          for _symbol, _expression in _match:
            if not _expression: continue
            parsed_match[symbol][_symbol] = self._parse(_expression, {_symbol: self.grammar[_symbol]}.items())
        else: parsed_match[symbol] = match.group(0)
        
        ast.append(parsed_match); break

      else: raise SyntaxError(f"@ln:col ({source[:30]})")

    # flatten single element lists and terminal values
    if (len(ast) == 1):
      if (len(ast[0]) == 1): ast = match.group(0)
      else: ast = ast[0]

    return ast

  def preprocess(self, source):
    source = re.sub(self._del, '', source)  # remove grammar exclusions
    return source

  def _parse_grammar(self, grammar):
    match = re.search(DEL, grammar, re.MULTILINE)
    self._del = match.group(1) if match else ''

    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    return OrderedDict(re.findall(BNF, grammar))


def printh(header, body): print(f"--- {header} {'-' * (TERMSIZE.columns - len(header) - 5)}\n{body}")


if __name__ == '__main__':
  parser = argparse.ArgumentParser(prog='ecc', description='x86 assembly compilers generated from Backus Naur grammar extended with regular expressions')
  parser.add_argument('grammar', help='language grammar file path')
  parser.add_argument('source', help='source code file path')
  parser.add_argument('-v', '--verbose', action='store_true', help='enable verbose output')

  args = parser.parse_args()

  with open(args.grammar, 'r') as file:
    _grammar = file.read()
  parser = Parser(_grammar)
  if (args.verbose): printh('GRAMAMR', pprint.pformat(dict(parser.grammar), sort_dicts=False))

  with open(args.source, 'r') as file:
    source = file.read()
  ast = parser.parse(source)
  if (args.verbose): printh('SYNTAX', pprint.pformat(ast, sort_dicts=False))
