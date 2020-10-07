/* FLUTTER */
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    @required this.onTap,
    @required this.textOnButton,
  });

  final VoidCallback onTap;
  final String textOnButton;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: Container(
        width: 120,
        color: Colors.grey[300],
        child: Text(
          textOnButton,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
