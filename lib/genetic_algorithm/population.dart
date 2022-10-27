import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';

/*
  This class encapsulates a list of Chromosomes and the operations
  that can be done with it.
*/

class Population {
  List<Chromosome> individuals;
  double? sum;

  Population(this.individuals);

  @override
  String toString() {
    var str = "\n";
    for (int i = 0; i < individuals.length; i++) {
      str += "C${individuals[i].id + 1}: ";
      str += individuals[i].toString();
    }
    return str;
  }

  double getSum() {
    double sum = 0;
    for (Chromosome individual in individuals) {
      sum += individual.fitness;
    }
    return sum;
  }

  // sort individuals in decrescent order
  void sort() {
    individuals.sort((a, b) => a.fitness.compareTo(b.fitness));
  }
}
