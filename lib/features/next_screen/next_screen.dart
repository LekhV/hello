/* FLUTTER */
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';

import 'package:hello/localizations.dart';

class NextScreen extends StatefulWidget {
  static const _routeName = '/example_locator_screen';
  NextScreen();

  static PageRoute<NextScreen> getPageRoute() {
    final routeSettings = RouteSettings(name: _routeName);

    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) => NextScreen(),
    );
  }

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.green[100],
        child: Text(
          locale.title,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
