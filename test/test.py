import json
import os

from ecc import Parser


LANG = './lang/'  # Directory where <lang>.g files are located
TEST = './test/'  # Directory where <file>.<lang> test files are located

VALIDATE = os.environ.get('VALIDATE', False)


def create_test(fgrammar, ftest):
  """ Create a parser test for a given grammar and source.

  Args:
    fgrammar (str): name, with extension, of the grammar file
    ftest (str): name, with extension, of the source file
  """
  def _test(self):
    with open(os.path.join(LANG, fgrammar), 'r') as file: grammar = file.read()
    parser = Parser(grammar)

    with open(os.path.join(TEST, ftest), 'r') as file: source = file.read()
    ast = parser.parse(source)

    _path = os.path.join(TEST + 'sol/', ftest + '.sol')
    if VALIDATE:  # save test output as verified solution
      with open(_path, 'w') as file: json.dump(ast, file, indent=2)
    else:  # assert test output matches verified solution
      with open(_path, 'r') as file: _ast = json.load(file)
      assert ast == _ast

  return _test

def create_test_groups():
  """ Dynamically create groups of tests for each grammar and test source.

  For each grammar <lang>.g in $LANG, create a set of test groups consisting of
  all sources <source>.<lang> in $TEST.
  """
  for fgrammar in [f for f in os.listdir(LANG) if f.endswith('.g')]:
    lang = fgrammar.split('.')[0]  # extract language identifier

    # create a test group for each grammar
    class_name = f"Test_{lang.capitalize()}"
    cls = type(class_name, (object,), {})
    
    # create a test method for each test file
    for ftest in [f for f in os.listdir(TEST) if f.endswith(f".{lang}")]:
      test_name = f"test_{ftest.replace('.', '_')}"
      test = create_test(fgrammar, ftest)
      setattr(cls, test_name, test)

    globals()[class_name] = cls  # register the test group for global access

create_test_groups()
