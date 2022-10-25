import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/fitness.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/population.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

import 'genetic_algorithm/pair.dart';

int calculate() {
  GeneticAlgorithm(numberOfGenes: 6).start();
  return 0;
}

class GeneticAlgorithm {
  final int numberOfGenes;

  Population? population;
  List<Chromosome> parents = [];
  List<Chromosome> children = [];
  int cutIndex = 0;

  GeneticAlgorithm({required this.numberOfGenes});

  void start() {
    _initializePopulation();
    _sortPopulation();
    _selectParents();
    while (children.length < population!.individuals.length) {
      _defineCut();
      _crossoverParents();
    }
    print(children);
  }

  void _initializePopulation() {
    var individuals = <Chromosome>[];
    for (int i = 0; i < numberOfGenes; i++) {
      var pair = Pair(generateRandomBetween(0, 8), generateRandomBetween(0, 8));
      individuals.add(Chromosome(pair, i, fitness));
    }

    print("\nInicializando a População:");
    population = Population(individuals);
    print(population!);
  }

  void _sortPopulation() {
    population!.sort();
  }

  void _selectParents() {
    print("Selecionando parentes:");
    parents.add(population!.individuals[0]);
    parents.add(population!.individuals[1]);

    _printParents();
  }

  void _defineCut() {
    cutIndex = generateRandomBetween(0, numberOfGenes - 1);
  }

  void _crossoverParents() {
    var result = "";

    String parent1 = parents[0].binaryValue;
    String parent2 = parents[1].binaryValue;

    result += parent1.substring(0, cutIndex);
    result += parent2.substring(cutIndex, numberOfGenes);
    result += parent1.substring(cutIndex, numberOfGenes);
    result += parent2.substring(0, cutIndex);

    print("cut at $cutIndex");
    print("crossover: $result");

    var child1 = Chromosome.fromBinary(
        result.substring(0, numberOfGenes), children.length, fitness);
    children.add(child1);
    var child2 = Chromosome.fromBinary(
        result.substring(numberOfGenes, numberOfGenes * 2),
        children.length,
        fitness);
    children.add(child2);

    _updateParents(child1, child2);
  }

  void _updateParents(Chromosome parent1, Chromosome parent2) {
    print("\nAtualizando parentes:");
    parents.clear();
    parents.addAll([parent1, parent2]);

    _printParents();
  }

  void _printParents() {
    var auxPop = Population(parents);
    print(auxPop);
  }
}
