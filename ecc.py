import re


BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.non_terminals = self._create_non_terminals(grammar)

  def parse(self, source):
    loc = 0
    while loc < len(source):
      for symbol, expression in self.non_terminals:
        print(f"cmp {source[loc:]}, {symbol}::{expression}")
        if (match := re.match(expression, source[loc:], re.DOTALL)):
          print(f"eq  {match.group(0)}, {symbol}::{match.groupdict()}\n")
          for _symbol, _expression in match.groupdict().items():
            self.parse(_expression)
          loc += match.end(); break
      else: raise(SyntaxError(f"Failed to match: '{source[loc:]}'"))
        
  @staticmethod
  def _create_non_terminals(grammar):
    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    return re.findall(BNF, grammar)

