/* FLUTTER */
import "package:flutter/material.dart";

/* COMPONENTS */
import 'package:hello/features/game_life/cell.dart';

class CellWidget extends StatelessWidget {
  CellWidget({this.cell});

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    final opacity = cell.isAlive ? 1.0 : 0.5;
    final color = cell.isAlive ? Colors.red : Colors.lime;

    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        height: 20.0,
        width: 20.0,
      ),
    );
  }
}
