import argparse
from collections import OrderedDict
import logging
import pprint
import re
import shutil


TERMSIZE = shutil.get_terminal_size()  # get the terminal size for formatting


HEADER = lambda text: f"――― {text} {'―' * (TERMSIZE.columns - len(text) - 5)}"

PPRINT = lambda text: pprint.pformat(text, sort_dicts=False)


DEL = r'\.del\s+(?P<exprs>.+?)(?=\.\w+\s+|$)'
REG = r'\.reg\s+(?P<regs>.+?)(?=\.\w+\s+|$)'

FMT = r'\.fmt\s+(?P<sym>\w+)\s*::=\s*(?P<exprs>.*?)(?=\.\w+\s+|$)'
MAP = r'\.map\s+(?P<sym>\w+)\s*::=\s*(?P<exprs>.*?)(?=\.\w+\s+|$)'

INS = r'(?P<opc>[&*#]?\w+)(?:\s+(?P<tgt>[&*#]\w+))?\s*(?:,\s*(?P<src>[&*#]\w+))?'

OR = r'\s*\|\s*'
AND = r'\s*;\s*'


class Parser():
  def __init__(self, grammar, **kwargs):
    """ Initialize a source code parser from a given source language grammar.

    Args:
      grammar (str): source language grammar
    """
    grammar = re.sub(r'\s{2,}', '\t', grammar)
    grammar = re.sub(r'(\n|\t)', '', grammar)

    self.sdel = re.findall(DEL, grammar)

    logging.debug(HEADER('Source Grammar'))
    sfmt = [(sym, re.split(OR, exprs)) for sym, exprs in re.findall(FMT, grammar)]
    self.sfmt = OrderedDict(sfmt)
    logging.debug(PPRINT(dict(self.sfmt)))

    logging.debug(HEADER('Source Map'))
    smap = {sym: [[re.match(INS, expr).groupdict()
                   for expr in re.split(AND, exprs)]
                  for exprs in re.split(OR, exprss)]
            for sym, exprss in re.findall(MAP, grammar)}
    self.smap = OrderedDict(smap)
    logging.debug(PPRINT(dict(self.smap)))

  def parse(self, source):
    """ Parse the given source code into an AST with recursive decent, that is
    translated into an internal representation.

    Args:
      source (str): source code to parse; formatted according to grammar

    Returns:
      ir (list, dict): internal representation of the given source code
    """
    logging.info(HEADER('Source Code'))
    logging.info(source)

    logging.info(HEADER('Abstract Syntax'))
    _source = self._preprocess(source)
    ast = Parser._reduce(self._parse(_source, self.sfmt.items()))
    logging.info(PPRINT(ast))

    logging.info(HEADER('Internal Representation'))
    ir = Parser._reduce(self._translate(ast))
    logging.info(PPRINT(ir))

    return ir

  def _preprocess(self, source):
    """ Modify given source code according to grammar configuration

    Args:
      self._del (str): characters to exclude
      source (str): source code to preprocess

    Returns:
      source (str): preprocessed source code
    """
    for _del in self.sdel: source = re.sub(_del, '', source)
    return source

  def _parse(self, source, targets):
    """ Parse the given source code into an AST with recursive decent.

    Args:
      source (str): source code to parse; formatted according to grammar
      targets (dict): targeted symbol(s) of recursive decent

    Returns:
      ast (list, dict): abstract syntax tree of the given source code
    """
    ast = []
    while source:  # sequentially match source to grammar
      for sym, exprs in targets:
        for expr in exprs:
          if not (match := re.match(expr, source, re.DOTALL)): continue

          # recursively parse subexpressions (grammar references)
          _ast = {sym: {}}
          try:
            if (_match := match.groupdict().items()):
              for _sym, _expr in _match:
                if not _expr: continue
                _targets = {_sym: self.sfmt[_sym]}.items()
                _ast[sym][_sym] = self._parse(_expr, _targets)
            else:
              _ast[sym] = match.group(0)
            ast.append(_ast); break

          except: continue
        else: continue
        source = source[match.end():]; break

      else: raise SyntaxError(f"{source}")
    return ast

  def _translate(self, ast):
    """ Translate the given AST into an internal representation.

    Args:
      ast (list, dict): abstract syntax tree of the given source code

    Returns:
      ir (list, dict): internal representation of the given source code
    """
    ir = []
    for _ast in ast if isinstance(ast, list) else [ast]:
      for sym, attrs in _ast.items():  # identify ast variant
        for var, expr in enumerate(self.sfmt[sym]):
          groups = re.compile(expr).groupindex.keys()
          if isinstance(attrs, dict) and set(attrs.keys()) == set(groups): break
          elif not isinstance(attrs, dict) and re.match(expr, attrs): break
        else: raise SyntaxError(f"{_ast}")

        for ins in self.smap[sym][var]:  # construct ir from ast
          if (opc := ins['opc']).startswith('&'):  # if opc is dereferenced...
            opc = self._translate({opc[1:]: attrs[opc[1:]]})
          elif opc.startswith('#'): opc = '#' + attrs  # if opc is explicit...
          elif opc.startswith('*'): opc = '*' + attrs  # if opc is a symbol...

          # initialize ir from instruction
          ins = {attr: val for attr, val in ins.items()
                 if (attr != 'opc') and (val != None)}
          if not ins: ir.append(opc); continue

          # recursively translate slices of the ast
          ir.append({opc: {attr: (self._translate({val[1:]: attrs[val[1:]]})
                                  if val.startswith('&') else val)
                     for attr, val in ins.items()}})
    return ir if len(ir) > 1 else ir[0]

  @staticmethod
  def _reduce(struct):
    """ Recursively reduce nested lists and dictionaries.

    Reduce any list with a single element to that element.
    
    In any dictionary, if the value corresping to a key is a dictionary with
    only one key, and that key is the same as the outer key, reduce the value
    corresonding to the outer key to the value corresponding to the inner key.
    """
    if isinstance(struct, list):
      # recursively reduce lists by element(s)
      _struct = [Parser._reduce(item) for item in struct]

      # if a list has one element, replace it with that element
      if len(_struct) == 1: return _struct[0]
      else: return _struct

    elif isinstance(struct, dict):
      _struct = {}
      for key, value in struct.items():  # recursively reduce dictionaries by key
        _value = Parser._reduce(value)
        if (isinstance(_value, dict) and len(_value) == 1 and key in _value):
          _struct[key] = _value[key]
        else: _struct[key] = _value
      return _struct

    else: return struct


class Optimizer():
  def __init__(self, **kwargs):
    """ Initialize an internal representation optimizer. """

  def optimize(self, ir): return ir


class Generator():
  def __init__(self, grammar, **kwargs):
    """ Initialize a code generator from a given target language grammar.

    Args:
      grammar (str): target language grammar
    """
    grammar = re.sub(r'\s{2,}', '\t', grammar)
    grammar = re.sub(r'(\n|\t)', '', grammar)

    logging.debug(HEADER('Target Map'))
    tmap = [(sym, re.split(OR, exprs)) for sym, exprs in re.findall(MAP, grammar)]
    self.tmap = OrderedDict(tmap)
    logging.debug(PPRINT(dict(self.tmap)))

    logging.debug(HEADER('Target Grammar'))
    tfmt = [(sym, re.split(OR, exprs)) for sym, exprs in re.findall(FMT, grammar)]
    self.tfmt = OrderedDict(tfmt)
    logging.debug(PPRINT(dict(self.tfmt)))

    self.tdel = [match.encode('utf-8') \
                      .decode('unicode_escape') \
                      .expandtabs(2)
                 for match in re.findall(DEL, grammar)]

  def generate(self, ir):
    """ Generate target code from the given internal representation with
    recursive decent.

    Args:
      ir (list, dict): internal representation of the given source code

    Returns:
      code (str): generated target code; formatted according to grammar
    """
    logging.info(HEADER('Target Code'))
    code = self._generate(ir) \
               .encode() \
               .decode('unicode_escape') \
               .expandtabs(2)
    code = self._postprocess(code)
    logging.info(code)
    return code

  def _generate(self, ir, _syms={}, ofs=0):
    """ Generate target code from the given internal representation with
    recursive decent.

    Args:
      ir (list, dict): partial internal representation of the given source code

    Returns:
      code (str): generated target code; formatted according to grammar
    """
    code, syms = "", {sym:loc for sym, loc in _syms.items()}
    for _ir in ir if isinstance(ir, list) else [ir]:
      if isinstance(_ir, list):  # recursive generation of ir as list
        code += self._generate(_ir, syms, ofs)
        continue

      for opc, args in _ir.items():
        ins = {'opc':opc, 'tgt':None, 'src':None}
        for opr in ('tgt', 'src'):  # construct instruction from ir
          if not opr in args: continue
          if isinstance(args[opr], dict): ins[opr] = f"&{opr}"
          else: ins[opr] = f"{args[opr][0]}{opr}"

        for var, expr in enumerate(self.tmap[opc]):  # identify ir variant
          if ins == re.match(INS, expr).groupdict(): break
        else: raise SyntaxError(f"Could not map {_ir} to a variant of {opc}.")

        fmt = self.tfmt[opc][var]  # format mapped ir variant
        for opr in {opr:val for opr, val in args.items() if opr != 'opc'}:
          if isinstance(args[opr], dict):  # if operand is a nested ir...
            fmt = re.sub(rf"\&{opr}", self._generate(args[opr], syms, ofs), fmt)

          elif args[opr][0] == '#':  # if operand is an explicit value...
            fmt = re.sub(rf"\${opr}", args[opr][1:], fmt)

          elif args[opr][0] == '*':  # if operand is a symbol...
            if re.search(rf"!{opr}", fmt):  # if symbol is declared...
              if args[opr][1:] not in syms:  # if first declaration of symbol...
                syms[args[opr][1:]] = rf"{(ofs := ofs + 2)}"
              fmt = re.sub(rf"!{opr}", rf"&{opr}", fmt)

            if re.search(rf"&{opr}", fmt):  # if symbol is dereferenced...
              if args[opr][1:] not in syms:  # if dereference before declaration...
                raise UnboundLocalError(f"Symbol {args[opr][1:]} referenced before declaration.")
              fmt = re.sub(rf"\&{opr}", syms[args[opr][1:]], fmt)

            fmt = re.sub(rf"\${opr}", args[opr][1:], fmt)  # format raw symbol

        code += fmt
    return code

  def _postprocess(self, code):
    """ Modify given target code according to grammar configuration

    Args:
      self.tdel (str): expressions to remove
      self.tsub (str): expressions to substitute

      code (str): target code to preprocess

    Returns:
      code (str): postprocessed target code
    """
    for _del in self.tdel: code = re.sub(_del, '', code)
    return code


if __name__ == '__main__':
  parser = argparse.ArgumentParser(prog='ecc', description='x86 assembly compilers generated from Backus Naur grammar extended with regular expressions')
  parser.add_argument('source', help='source grammar file path')
  parser.add_argument('target', help='target grammar file path')
  parser.add_argument('code', help='source code file path')
  parser.add_argument('-v', '--verbose', default='WARNING',
                      choices=['DEBUG', 'INFO', 'WARNING'],
                      help="Set the logging level (default: WARNING).")
  args = parser.parse_args()

  logging.basicConfig(level=args.verbose, format=f'%(message)s')

  with open(args.source, 'r') as file: sgrammar = file.read()
  parser = Parser(sgrammar)

  with open(args.code, 'r') as file: source = file.read()
  ir = parser.parse(source)

  optimizer = Optimizer()
  ir = optimizer.optimize(ir)

  with open(args.target, 'r') as file: tgrammar = file.read()
  generator = Generator(tgrammar)

  code = generator.generate(ir)
