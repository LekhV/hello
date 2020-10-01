/* FLUTTER */
import "package:flutter/material.dart";

/* COMPONENTS */
import 'package:hello/features/game_life/cell.dart';
import 'package:hello/features/game_life/widgets/cell_widget.dart';

class GenerationCellsWidget extends StatelessWidget {
  GenerationCellsWidget(this.matrix);

  final List<List<Cell>> matrix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: matrix.map(_mapCells).toList(),
    );
  }

  Widget _mapCells(List<Cell> cells) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cells.map(_mapCellsRow).toList(),
    );
  }

  Widget _mapCellsRow(Cell cell) {
    return CellWidget(
      cell: cell,
    );
  }
}
