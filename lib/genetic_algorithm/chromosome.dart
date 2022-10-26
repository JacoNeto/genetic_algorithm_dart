import 'package:genetic_algorithm_dart/genetic_algorithm/pair.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

/*
  A chromosome is the most important entity in this algorithm. It has
  the value as a pair of [x,y] and every representations and operations
  needed for the program as a whole. 
*/

class Chromosome {
  Pair pair; // value as a pair
  String binaryValue; // value as a binary representation
  double fitness; // fitness of the value
  int id; // identifier
  double? probability;

  /// Default constructor. Receives a value as a [pair], an identifier [id] and
  /// the [fitnessFunction]. This class' [binaryValue] and [fitness] are calculated
  /// immediatly.
  Chromosome(this.pair, this.id, double Function(int x, int y) fitnessFunction)
      : binaryValue = intToBin(pair.x) + intToBin(pair.y),
        fitness = fitnessFunction(pair.x, pair.y);

  /// Binary constructor. Receives a value as a [binaryValue], an identifier [id]
  /// and the [fitnessFunction]. This class' [pair] and [fitness] are calculated
  /// immediatly.
  Chromosome.fromBinary(
      this.binaryValue, this.id, double Function(int x, int y) fitnessFunction)
      : pair = binToPair(binaryValue),
        fitness =
            fitnessFunction(binToPair(binaryValue).x, binToPair(binaryValue).y);

  @override
  String toString() {
    if (probability != null) {
      return '([${pair.x},${pair.y}] | $binaryValue | ${fitness.toStringAsFixed(2)} | ${probability!.toStringAsFixed(2)}%)\n';
    }
    return '([${pair.x},${pair.y}] | $binaryValue | ${fitness.toStringAsFixed(2)})\n';
  }
}
