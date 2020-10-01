class Cell {
  Cell(this.isAlive);
  final isAlive;

  @override
  String toString() {
    return isAlive ? '1' : '0';
  }
}
