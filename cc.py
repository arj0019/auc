import re


TERMINALS = []
class Terminal():
  def __init__(self, value):
    self.value = value

  def __repr__(self):
    return f"TERMINAL::{self.__class__.__name__}::{self.value}"

  @classmethod
  def __init_subclass__(cls, regex=None, **kwargs):
    super().__init_subclass__(**kwargs)
    TERMINALS.append((re.compile(regex), cls))

class Delimeter(Terminal, regex=r'[]()[{}]'): pass

class Identifier(Terminal, regex=r'([A-Za-z_][0-9A-Za-z_]*)'): pass

class Value(Terminal, regex=r'\b\d+\b'): pass

class Type(Terminal, regex=r'\b(?:void|int)'): pass


def tokenize(source):
    pos, tokens = 0, []
    while pos < len(source):
        for regex, cls in TERMINALS:
            if match := regex.match(source, pos):
                tokens.append(cls(match.group(0)))
                pos = match.end(); break
        else: pos += 1  # skip unrecognized characters
    return tokens

