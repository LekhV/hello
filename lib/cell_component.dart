/* FLUTTER */
import "package:flutter/material.dart";

class CellComponent extends StatelessWidget {
  CellComponent({this.isActive});

  bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.lime,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: 20.0,
      width: 20.0,
    );
  }
}
