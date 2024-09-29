import argparse
from collections import OrderedDict
import pprint
import re
import shutil


TERMSIZE = shutil.get_terminal_size()  # get the terminal size for formatting


DEL = r'^\s*\.del\s+(.+)$'
BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar:str, **kwargs):
    """ Initialize a parser from a given grammar and configuation.

    Args:
      grammar (str): lanugage grammar formatted as BNF+RE

    KwArgs:
      simplify (bool): reduce nested lists and dictionaries
    """
    self.grammar = self._parse_grammar(grammar)
    self.simplify = kwargs.get('simplify', False)

  def _parse_grammar(self, grammar):
    match = re.search(DEL, grammar, re.MULTILINE)
    self._del = match.group(1) if match else ''

    grammar = re.sub(r'\s+', '', grammar)
    grammar = re.findall(BNF, grammar)
    grammar = [(sym, re.split(r'\|', expr)) for sym, expr in grammar]
    return OrderedDict(grammar)

  def parse(self, source):
    """ Parse the given source code into an AST with recursive decent.

    Args:
      source (str): source code to parse; formatted according to grammar

    Returns:
      ast (list, dict): abstract syntax tree of the given source code
    """
    _source = self.preprocess(source)
    ast = self._parse(_source, self.grammar.items())
    if self.simplify: ast = self._simplify(ast)
    return ast

  def preprocess(self, source):
    """Modify given source code according to grammar configuration

    Args:
      self._del (str): characters to exclude
      source (str): source code to preprocess

    Returns:
      source (str): preprocessed source code
    """
    return re.sub(self._del, '', source)  # remove grammar exclusions

  def _parse(self, source, targets):
    """ Parse the given source code into an AST with recursive decent.

    Args:
      source (str): source code to parse; formatted according to grammar
      targets (dict): targeted symbol(s) of recursive decent

    Returns:
      ast (list, dict): abstract syntax tree of the given source code
    """
    ast = [];
    while source:  # sequentially match source to grammar
      for symbol, expressions in targets:
        for expression in expressions:
          if not (match := re.match(expression, source, re.DOTALL)): continue

          # recursively parse subexpressions (grammar references)
          parsed_match = {symbol: {}}
          try:
            if (_match := match.groupdict().items()):
              for _symbol, _expression in _match:
                if not _expression: continue
                parsed_match[symbol][_symbol] = self._parse(_expression, {_symbol: self.grammar[_symbol]}.items())
            else:
              parsed_match[symbol] = match.group(0)
            ast.append(parsed_match); break

          except: continue
        else: continue
        source = source[match.end():]; break

      else: raise SyntaxError(f"@ln:col ({source[:30]})")
    return ast

  def _simplify(self, struct):
    """ Recursively reduce nested lists and dictionaries.

    Reduce any list with a single element to that element.
    
    In any dictionary, if the value corresping to a key is a dictionary with
    only one key, and that key is the same as the outer key, reduce the value
    corresonding to the outer key to the value corresponding to the inner key.
    """
    if isinstance(struct, list):
      # recursively reduce lists by element(s)
      _struct = [self._simplify(item) for item in struct]

      # if a list has one element, replace it with that element
      if len(_struct) == 1: return _struct[0]
      else: return _struct

    elif isinstance(struct, dict):
        _struct = {}
        for key, value in struct.items(): # Recursively reduce dictionaries by key repetition
          _value = self._simplify(value)
          if (isinstance(_value, dict) and len(_value) == 1 and key in _value):
              _struct[key] = _value[key]
          else: _struct[key] = _value
        return _struct

    else: return struct


def printh(header, body): print(f"--- {header} {'-' * (TERMSIZE.columns - len(header) - 5)}\n{body}")


if __name__ == '__main__':
  parser = argparse.ArgumentParser(prog='ecc', description='x86 assembly compilers generated from Backus Naur grammar extended with regular expressions')
  parser.add_argument('grammar', help='language grammar file path')
  parser.add_argument('source', help='source code file path')
  parser.add_argument('-s', '--simplify', action='store_true', help='simplify the ast')
  parser.add_argument('-v', '--verbose', action='store_true', help='enable verbose output')

  args = parser.parse_args()

  with open(args.grammar, 'r') as file:
    _grammar = file.read()
  parser = Parser(_grammar, simplify=args.simplify)
  if (args.verbose): printh('GRAMAMR', pprint.pformat(dict(parser.grammar), sort_dicts=False))

  with open(args.source, 'r') as file:
    source = file.read()
  ast = parser.parse(source)
  if (args.verbose): printh('SYNTAX', pprint.pformat(ast, sort_dicts=False))
