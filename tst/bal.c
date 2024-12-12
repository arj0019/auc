int bal_constant() {
  int a = (0);
  return a;
}

int bal_symbol() {
  int a = (0);
  int b = (a);
  return b;
}

int bal_expression() {
  int a = (0);
  int b = (a + 1);
  int c = ((a) + 2);
  int d = (a + (3));
  int e = ((a) + (4));
  int f = ((a) + (5 + 6));
  return f;
}

int bal_return() {
  return (0);
}
