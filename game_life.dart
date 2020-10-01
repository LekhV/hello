import 'dart:math';
import 'dart:async';

const MAX_ALIVE = 3;
const MIN_ALIVE = 2;
const SIZE = 10;

void main() {
  int numberOfGeneration = 50;

  Generation generation = Generation.getRandomGeneration(SIZE);

  for (final row in generation.matrix) {
    print(row);
  }
  print("------------------");

  for (int i = 0; i < numberOfGeneration; i++) {
    generation = generation.getNextGeneration();

    for (final row in generation.matrix) {
      print(row);
    }
    print("------------------");

    int aliveCell = 0;

    for (final row in generation.matrix) {
      aliveCell =
          row.fold(aliveCell, (previousValue, element) => previousValue += element.isAlive ? 1 : 0);
    }

    if (aliveCell == 0) {
      break;
    }

    print("$i------------------");
  }
}

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

class CellRepository {
  final Stream stream;

  // for (final row in generation.matrix) {
  //   print(row);
  // }

  CellRepository() : stream = Stream.periodic(Duration(seconds: 1));
}

class GenerationService {
  GenerationService(
    this._cellRepository,
  );

  final CellRepository _cellRepository;
}
