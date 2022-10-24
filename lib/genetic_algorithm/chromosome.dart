import 'package:genetic_algorithm_dart/genetic_algorithm/pair.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

class Chromosome {
  Pair pair;
  String binaryValue;
  double fitness;
  int id;

  Chromosome(this.pair, this.id, double Function(int x, int y) fitnessFunction)
      : binaryValue = intToBin(pair.x) + intToBin(pair.y),
        fitness = fitnessFunction(pair.x, pair.y);

  @override
  String toString() {
    return '([${pair.x},${pair.y}] | $binaryValue | ${fitness.toStringAsFixed(2)})\n';
  }
}
