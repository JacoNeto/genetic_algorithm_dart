import 'dart:math';

import 'package:binary/binary.dart';

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
