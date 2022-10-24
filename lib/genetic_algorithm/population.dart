import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';

class Population {
  List<Chromosome> individuals;

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

  void sort() {
    individuals.sort((a, b) => a.fitness.compareTo(b.fitness));
  }
}
