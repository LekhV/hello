/* DART */
import 'dart:math';

import 'package:hello/features/game_life/cell.dart';

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

const MAX_ALIVE = 3;
const MIN_ALIVE = 2;
