from collections import OrderedDict
import re


BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.grammar = self._parse_grammar(grammar)

  def parse(self, source):
    return self._parse(source, self.grammar)

  def _parse(self, source, grammar):
    ast = []
    while source:  # sequentially match source to grammar
      for symbol, expression in grammar.items():
        if (match := re.match(expression, source, re.DOTALL)):
          source = source[match.end():]
          parsed_match = {symbol: {}}

          # recursively parse subexpressions (grammar references)
          if (_match := match.groupdict().items()):
            for _symbol, _expression in _match:
              parsed_match[symbol][_symbol] = self._parse(_expression, grammar)
          else: parsed_match[symbol] = match.group(0)
          
          ast.append(parsed_match); break

      else: raise SyntaxError(f"Match not found: {source[:30]}")

    # flatten single element lists and terminal values
    # if (len(ast) == 1):
    #   if (len(ast[0]) == 1): ast = match.group(0)
    #   else: ast = ast[0]

    return ast

  @staticmethod
  def _parse_grammar(grammar):
    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    return OrderedDict(re.findall(BNF, grammar))

