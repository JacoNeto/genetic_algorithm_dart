import 'package:ansicolor/ansicolor.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/chromosome.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/fitness.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/population.dart';
import 'package:genetic_algorithm_dart/genetic_algorithm/utils.dart';

import 'genetic_algorithm/pair.dart';

int calculate() {
  GeneticAlgorithm(numberOfGenes: 6, populationSize: 10, fitness: fitness)
      .start();
  return 0;
}

class GeneticAlgorithm {
  final int numberOfGenes; // number of genes in each chromosome
  final int populationSize; // population size
  final double Function(int x, int y) fitness; // fitness function

  Population? population; // Population of the current generation
  List<Chromosome> parents = []; // Current parents
  List<Chromosome> children = []; // Current children

  int cutIndex = 0; // index being cutted in the crossover

  // Default constructor
  GeneticAlgorithm(
      {required this.numberOfGenes,
      required this.populationSize,
      required this.fitness});

  // Code execution
  void start() {
    _initializePopulation();
    int i = 0;
    while (minFitness(population).fitness > 1) {
      _sortPopulation();
      _selectParents();
      while (children.length < population!.individuals.length) {
        _defineCut();
        _crossoverParents();
      }
      _updatePopulation();
      _printGeneration(i + 2, population);
      _clearGeneration();
      i++;
    }
  }

  // Initualize the population with chromossomes created from random pair values
  void _initializePopulation() {
    var individuals = <Chromosome>[];

    for (int i = 0; i < populationSize; i++) {
      var pair = Pair(generateRandomBetween(0, 8), generateRandomBetween(0, 8));
      individuals.add(Chromosome(pair, i, fitness));
    }

    for (Chromosome individual in individuals) {
      individual.probability =
          calcProbability(individual, List.of(individuals));
    }

    print("\nInicializando a População:");
    population = Population(individuals);
    _printPopulation();
  }

  // sort population in ascending order
  void _sortPopulation() {
    population!.sort();
  }

  // select two chromossomes with most probability to be the parents
  void _selectParents() {
    print("Selecionando pais:");
    parents.add(population!.individuals[0]);
    parents.add(population!.individuals[1]);

    _printParents();
  }

  // define randomly the position of the cut to the crossover
  void _defineCut() {
    cutIndex = generateRandomBetween(0, numberOfGenes - 1);
  }

  // crossover procedure
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

  // mutation procedure (5% probability)
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

  void _updatePopulation() {
    for (Chromosome individual in List.of(children)) {
      individual.probability =
          calcProbability(individual, List.of(List.of(children)));
    }
    population = Population(List.of(children));
  }

  void _clearGeneration() {
    parents.clear();
    children.clear();
  }

  /*
  *
  *
  *
  * Exibition functions
  *
  *
  *
  */
  void _printParents() {
    var auxPop = Population(parents);
    print(auxPop);
  }

  void _printPopulation() {
    var indexOfMin = population!.individuals.indexOf(minFitness(population));
    var populationLines = population.toString().split('\n');

    AnsiPen pen = AnsiPen()..green(bold: true);

    populationLines[indexOfMin + 1] = pen(populationLines[indexOfMin + 1]);

    for (String splitted in populationLines) {
      print(splitted);
    }
  }

  void _printGeneration(int gen, Population? population) {
    print("*******************************");
    print("$genª geração:");
    _printPopulation();
    print("*******************************");
  }
}
