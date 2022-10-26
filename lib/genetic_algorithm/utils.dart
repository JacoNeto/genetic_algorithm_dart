import 'dart:math';

import 'package:binary/binary.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/pair.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/population.dart';

// converts an int value to an binary one
String intToBin(int value) {
  return value.toBinaryPadded(3);
}

// converts an binary value to an binary one
int binToInt(String binaryString) {
  return int.parse(binaryString, radix: 2);
}

// random values >= min and < max
int generateRandomBetween(int min, int max) {
  final random = Random();

  return min + random.nextInt(max - min);
}

// converts an binary value to a [x,y] pair
Pair binToPair(String binaryValue) {
  return Pair(
      binToInt(binaryValue.substring(0, binaryValue.length ~/ 2)),
      binToInt(
          binaryValue.substring(binaryValue.length ~/ 2, binaryValue.length)));
}

// returns the Chromossome with min value in a Population
Chromosome minFitness(Population? population) {
  return population!.individuals
      .reduce((curr, next) => curr.fitness < next.fitness ? curr : next);
}
