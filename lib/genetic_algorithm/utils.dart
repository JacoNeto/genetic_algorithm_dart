import 'dart:math';

import 'package:binary/binary.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/pair.dart';

String intToBin(int value) {
  return value.toBinaryPadded(3);
}

int binToInt(String binaryString) {
  return int.parse(binaryString, radix: 2);
}

// random values >= min and < max
int generateRandomBetween(int min, int max) {
  final random = Random();

  return min + random.nextInt(max - min);
}

Pair binToPair(String binaryValue) {
  return Pair(
      binToInt(binaryValue.substring(0, binaryValue.length ~/ 2)),
      binToInt(
          binaryValue.substring(binaryValue.length ~/ 2, binaryValue.length)));
}
