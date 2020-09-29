/* DART */
import 'dart:math';

/* FLUTTER */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* COMPONENTS */
import 'package:hello/cell_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int size = 10;
  int numberOfGeneration = 50;

  Generation generation;

  List<List<Cell>> matrix = [];
  List<List<Cell>> newMatrix = [];

  @override
  initState() {
    super.initState();

    generation = Generation.getRandomGeneration(SIZE);
    matrix = generation.matrix;

    for (final row in matrix) {
      rows = row;
      print(row);
    }
  }

  List<Cell> rows = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: matrix.asMap().keys.map(
              (x) {
                return Row(
                  children: matrix.asMap().keys.map(
                    (y) {
                      return CellComponent(
                        isActive: matrix[x][y].isAlive,
                      );
                    },
                  ).toList(),
                );
              },
            ).toList(),
          ),
          CupertinoButton(
            onPressed: () {
              setState(() {
                for (int i = 0; i < numberOfGeneration; i++) {
                  newMatrix = generation.getNextGeneration().matrix;

                  for (final row in newMatrix) {
                    print(row);
                  }

                  int aliveCell = 0;

                  for (final row in newMatrix) {
                    aliveCell = row.fold(aliveCell,
                        (previousValue, element) => previousValue += element.isAlive ? 1 : 0);
                  }

                  if (aliveCell == 0) {
                    break;
                  }

                  print("$i------------------");
                }
              });
            },
            child: Container(
              width: 200,
              color: Colors.lime,
              child: Text("Start Game", textAlign: TextAlign.center),
            ),
          ),
          Column(
            children: newMatrix.asMap().keys.map(
              (x) {
                return Row(
                  children: newMatrix.asMap().keys.map(
                    (y) {
                      return CellComponent(
                        isActive: newMatrix[x][y].isAlive,
                      );
                    },
                  ).toList(),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

const MAX_ALIVE = 3;
const MIN_ALIVE = 2;
const SIZE = 10;

class Cell {
  Cell(this.isAlive);
  final isAlive;

  @override
  String toString() {
    return isAlive ? '1' : '0';
  }
}

class Generation {
  final List<List<Cell>> matrix;

  Generation(this.matrix);

  factory Generation.getRandomGeneration(int size) {
    final matrix = <List<Cell>>[];

    for (int i = 0; i < size; i++) {
      final list = List<Cell>();

      for (int j = 0; j < size; j++) {
        final randomBool = Random().nextBool();

        list.add(Cell(randomBool));
      }

      matrix.add(list);
    }

    return Generation(matrix);
  }

  Cell _getByCoordinates(int x, int y) {
    return matrix[x][y];
  }

  Generation getNextGeneration() {
    final newMatrix = <List<Cell>>[];

    for (int i = 0; i < matrix.length; i++) {
      final row = List<Cell>();

      for (int j = 0; j < matrix[i].length; j++) {
        int count = _getAliveNeighboursNumber(i, j);

        if (matrix[i][j].isAlive) {
          if (count >= MIN_ALIVE && count <= MAX_ALIVE) {
            row.add(Cell(true));
          } else {
            row.add(Cell(false));
          }
        } else {
          if (count == 3) {
            row.add(Cell(true));
          } else {
            row.add(Cell(false));
          }
        }
      }
      newMatrix.add(row);
    }
    return Generation(newMatrix);
  }

  int _getAliveNeighboursNumber(int x, int y) {
    int count = 0;

    count += _getAmountByAliveCell(_isAliveByCoordinates(x - 1, y + 1));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x - 1, y));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x - 1, y - 1));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x + 1, y + 1));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x + 1, y));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x + 1, y - 1));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x, y - 1));

    count += _getAmountByAliveCell(_isAliveByCoordinates(x, y + 1));

    return count;
  }

  bool _isAliveByCoordinates(int x, int y) {
    try {
      Cell cell = _getByCoordinates(x, y);

      return cell.isAlive;
    } on RangeError catch (e) {
      return false;
    }
  }

  int _getAmountByAliveCell(bool isAlive) => isAlive ? 1 : 0;
}
