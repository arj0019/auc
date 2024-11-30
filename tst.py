import os
import subprocess
import logging


SRC = './src/'  # Directory where grammar files are located (<lang>.s)
TGT = './tgt/'  # Directory where grammar files are located (<lang>.t)
TST = './tst/'  # Directory where source files are located (<src>.<lang>)

VALIDATE = os.environ.get('VALIDATE', False)

LOGGER = logging.getLogger(__name__)


def create_test(src, tgt, tst):
  """ Create a parser test for a given grammar and source.

  Args:
    src (str): name, with extension, of the source grammar file
    tgt (str): name, with extension, of the target grammar file
    tst (str): name, with extension, of the source code file
  """
  def _test(self, caplog):
    with caplog.at_level(logging.DEBUG):
      args = [os.path.join(SRC, src),
              os.path.join(TGT, tgt),
              os.path.join(TST, tst),
              "-vINFO"]

      process = subprocess.run(["python3", "./ecc.py"] + args,
                               capture_output=True,
                               text=True)

    src_name = src.split('.')[0]
    tgt_name = tgt.split('.')[0]
    tst_name = tst.split('.')[0]
    path = os.path.join(TST + 'sol/', f"{src_name}_{tgt_name}_{tst_name}.sol")
    if VALIDATE:  # save test output as verified solution
      with open(path, 'w') as file: file.write(process.stderr)
    else:  # assert test output matches verified solution
      with open(path, 'r') as file: log = file.read()
      assert process.stderr == log

  return _test

def create_test_groups():
  """ Dynamically create groups of tests for each grammar and test source.

  For each grammar <lang>.s in $SRC, create a set of test groups consisting of
  all sources <src>.<lang> in $TST.
  """
  for sgrammar in [src for src in os.listdir(SRC) if src.endswith('.s')]:
    for tgrammar in [tgt for tgt in os.listdir(TGT) if tgt.endswith('.t')]:
      sid = sgrammar.split('.')[0]  # extract source grammar identifier
      tid = tgrammar.split('.')[0]  # extract target grammar identifier

      # create a test group for each combination of grammars
      class_name = f"Test_{sid.capitalize()}_{tid.capitalize()}"
      cls = type(class_name, (object,), {})

      # create a test method for each test file
      for tst in [tst for tst in os.listdir(TST) if tst.endswith(f".{sid}")]:
        name = f"test_{sid}_{tid}_{tst.split('.')[0]}"
        setattr(cls, name, create_test(sgrammar, tgrammar, tst))

      globals()[class_name] = cls  # register the test group for global access

create_test_groups()
