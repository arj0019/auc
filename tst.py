import json
import os

from ecc import Parser


SRC = './src/'  # Directory where grammar files are located (<lang>.s)
TGT = './tgt/'  # Directory where grammar files are located (<lang>.t)
TST = './tst/'  # Directory where source files are located (<src>.<lang>)

VALIDATE = os.environ.get('VALIDATE', False)


def create_test(sgrammar, stest):
  """ Create a parser test for a given grammar and source.

  Args:
    sgrammar (str): name, with extension, of the grammar file
    stest (str): name, with extension, of the source file
  """
  def _test(self):
    with open(os.path.join(SRC, sgrammar), 'r') as file: grammar = file.read()
    parser = Parser(grammar)

    with open(os.path.join(TST, stest), 'r') as file: source = file.read()
    ast = parser.parse(source)

    _path = os.path.join(TST + 'sol/', stest + '.sol')
    if VALIDATE:  # save test output as verified solution
      with open(_path, 'w') as file: json.dump(ast, file, indent=2)
    else:  # assert test output matches verified solution
      with open(_path, 'r') as file: _ast = json.load(file)
      assert ast == _ast

  return _test

def create_test_groups():
  """ Dynamically create groups of tests for each grammar and test source.

  For each grammar <lang>.s in $SRC, create a set of test groups consisting of
  all sources <src>.<lang> in $TST.
  """
  for sgrammar in [s for s in os.listdir(SRC) if s.endswith('.s')]:
    lang = sgrammar.split('.')[0]  # extract language identifier

    # create a test group for each grammar
    class_name = f"Test_{lang.capitalize()}"
    cls = type(class_name, (object,), {})
    
    # create a test method for each test file
    for stest in [s for s in os.listdir(TST) if s.endswith(f".{lang}")]:
      test_name = f"test_{stest.replace('.', '_')}"
      test = create_test(sgrammar, stest)
      setattr(cls, test_name, test)

    globals()[class_name] = cls  # register the test group for global access

create_test_groups()
