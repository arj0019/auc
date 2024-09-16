import re


BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.non_terminals = self._create_non_terminals(grammar)

  def parse(self, source):
    loc = 0
    while loc < len(source):
      for symbol, expression in self.non_terminals:
        match = re.match(expression, source[loc:])
        if match:
          print(f"{symbol} := {match.groupdict()}")
          loc = match.end(); break
      else: loc += 1  # skip unrecognized characters
        
  @staticmethod
  def _create_non_terminals(grammar):
    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    return re.findall(BNF, grammar)

