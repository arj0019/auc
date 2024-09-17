from collections import OrderedDict
import re


BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.non_terminals = self._create_non_terminals(grammar)

  def parse(self, source):
    return self._parse(source, self.non_terminals)

  def _parse(self, source, grammar):
    for symbol, expression in grammar.items():
      if (match := re.match(expression, source, re.DOTALL)):
        if (_match := match.groupdict().items()):
          return {symbol:self._parse(expression, grammar)
                  for symbol, expression in _match}
        else: return match.group(0)
    return None
        
  @staticmethod
  def _create_non_terminals(grammar):
    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    return OrderedDict(re.findall(BNF, grammar))

