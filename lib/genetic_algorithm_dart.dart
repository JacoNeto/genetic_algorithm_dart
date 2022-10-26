import 'dart:developer';

import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/fitness.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/population.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

import 'genetic_algorithm/pair.dart';

int calculate() {
  GeneticAlgorithm(numberOfGenes: 6, populationSize: 8).start();
  return 0;
}

class GeneticAlgorithm {
  final int numberOfGenes;
  final int populationSize;

  Population? population;
  List<Chromosome> parents = [];
  List<Chromosome> children = [];
  int cutIndex = 0;

  GeneticAlgorithm({required this.numberOfGenes, required this.populationSize});

  void start() {
    _initializePopulation();

    for (int i = 0; i < 3; i++) {
      _sortPopulation();
      _selectParents();
      while (children.length < population!.individuals.length) {
        _defineCut();
        _crossoverParents();
      }
      population = Population(children);
      print("${i + 2}ª geração:\n$population");
      parents.clear();
    }
  }

  void _initializePopulation() {
    var individuals = <Chromosome>[];
    for (int i = 0; i < populationSize; i++) {
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
    print("Selecionando pais:");
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
    child1 = _mutate(child1);
    children.add(child1);

    var child2 = Chromosome.fromBinary(
        result.substring(numberOfGenes, numberOfGenes * 2),
        children.length,
        fitness);
    child2 = _mutate(child2);
    children.add(child2);

    _updateParents(child1, child2);
  }

  Chromosome _mutate(Chromosome child) {
    int aux = 0;
    final oldChild = child.binaryValue;
    for (int i = 0; i < child.binaryValue.length; i++) {
      if (generateRandomBetween(0, 100) < 5) {
        aux++;
        if (child.binaryValue[i] == '0') {
          child.binaryValue = child.binaryValue.replaceRange(i, i + 1, '1');
        } else {
          child.binaryValue = child.binaryValue.replaceRange(i, i + 1, '0');
        }
      }
    }

    if (aux > 0) {
      print("MUTAÇÃO: $oldChild ---> ${child.binaryValue}");
    }
    return child;
  }

  void _updateParents(Chromosome parent1, Chromosome parent2) {
    print("\nPróximos pais:");
    parents.clear();
    parents.addAll([parent1, parent2]);

    _printParents();
  }

  void _printParents() {
    var auxPop = Population(parents);
    print(auxPop);
  }
}
