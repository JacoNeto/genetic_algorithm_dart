import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/fitness.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/population.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

import 'genetic_algorithm/pair.dart';

int calculate() {
  GeneticAlgorithm().start();
  return 0;
}

class GeneticAlgorithm {
  Population? population;
  List<Chromosome> parents = [];

  void start() {
    initializePopulation();
    sortPopulation();
    selectParents();
  }

  void initializePopulation() {
    var individuals = <Chromosome>[];
    for (int i = 0; i < 6; i++) {
      var pair = Pair(generateRandomBetween(0, 7), generateRandomBetween(0, 7));
      individuals.add(Chromosome(pair, i, fitness));
    }

    print("\nInicializando a População:");
    population = Population(individuals);
    print(population!);
  }

  void sortPopulation() {
    population!.sort();
  }

  void selectParents() {
    print("Selecionando parentes:");
    parents.add(population!.individuals[0]);
    parents.add(population!.individuals[1]);

    printParents();
  }

  void printParents() {
    var auxPop = Population(parents);
    print(auxPop);
  }
}
