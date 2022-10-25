import 'dart:math';

double fitness(int x, int y) {
  return sqrt(pow(x, 3) + pow(y, 4)) + 1;
}
