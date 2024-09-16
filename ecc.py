import re


BNF = r'<(\w+)>\s*::=\s*(.*?)\s*(?=<\w+>\s*::=|$)'


class Parser():
  def __init__(self, grammar):
    self.non_terminals = self._create_non_terminals(grammar)

  def parse(self, source):
    loc = 0
    while loc < len(source):
      for non_terminal in self.non_terminals:
        match = re.match(non_terminal.expression, source[loc:])
        if match:
          print(f"{non_terminal.__name__} := {match.groupdict()}")
          loc = match.end(); break
      else: loc += 1  # skip unrecognized characters
        
  @staticmethod
  def _create_non_terminals(grammar):
    grammar = re.sub(r'\s*\n\s*', ' ', grammar)
    grammar = [(symbol, re.split(r'\s*\|\s*', expressions))
               for (symbol, expressions)
               in re.findall(BNF, grammar)]
    
    non_terminals = []
    for symbol, expressions in grammar:
      base_non_terminal = type(symbol,
                               (object,),
                               {'expression':expressions[0]})

      if (len(expressions) > 1):
        for expression in expressions:
          args = re.findall(r'\w+', expression)
          _symbol = symbol + '_' + '_'.join(args)
          non_terminals.append(type(_symbol,
                                    (base_non_terminal,),
                                    {'expression':expression,
                                     'val':None}))
      else: non_terminals.append(base_non_terminal)

    return non_terminals

