int mov_symbol_symbol() {
  int a = 0;
  int b = a;
  return b;
}

int mov_symbol_expression() {
  int a = 0 + 1;
  return a;
}

int mov_symbol_constant() {
  int a = 0;
  return a;
}
