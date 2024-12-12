int bal_constant() {
  int a = (0);
  return a;
}

int bal_symbol() {
  int a = (0);
  int b = (a);
  return b;
}

int bal_return() {
  return (0);
}

int bal_simple_b() {
  int a = (0);
  int b = (a + 1);
}

int bal_simple_c() {
  int a = (0);
  int c = ((a) - 1);
  return c;
}

int bal_simple_d() {
  int a = (0);
  int d = (a * (1));
  return d;
}

int bal_simple_e() {
  int a = (0);
  int e = ((a) / (1));
  return e;
}

int bal_complex_b() {
  int a = (0);
  int b = ((a + 1) - (2));
  return b;
}

int bal_complex_c() {
  int a = (0);
  int c = ((a) * (1 / 2));
  return c;
}

int bal_complex_d() {
  int a = (0);
  int d = ((a + 1) - (2 * 3));
  return d;
}
