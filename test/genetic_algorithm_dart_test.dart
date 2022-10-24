import 'dart:math';

import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/fitness.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/pair.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(fitness(1, 1), sqrt(2));
  });

  test('calculate object', () {
    var chromo = Chromosome(Pair(1, 1), 1, fitness);
    expect(chromo.fitness, sqrt(2));
    expect(chromo.binaryValue, "001001");
  });

  test('binInt', () {
    expect(intToBin(7), "111");
  });

  test('intToBin', () {
    expect(binToInt("1010"), 10);
  });
}
