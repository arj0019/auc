int sub_symbol_symbol() {
  int a = 0;
  int b = 1;
  int c = a - b;
  return c;
}

int sub_symbol_expression() {
  int a = 0;
  int b = a - 1 - 2;
  return b;
}

int sub_symbol_constant() {
  int a = 0;
  int b = a - 1;
  return b;
}

int sub_constant_symbol() {
  int a = 0;
  int b = 1 - a;
  return b;
}

int sub_constant_expression() {
  int a = 0 - 1 - 2;
  return a;
}

int sub_constant_constant() {
  return 0 - 1;
}
