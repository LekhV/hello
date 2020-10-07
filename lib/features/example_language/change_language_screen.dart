/* FLUTTER */
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:hello/features/example_language/language_presenter.dart';
import 'package:hello/features/game_life/widgets/custom_button_widget.dart';
import 'package:hello/features/next_screen/next_screen.dart';
import 'package:hello/localizations.dart';

class ChangeLanguageScreen extends StatefulWidget {
  static const _routeName = '/example_locator_screen';
  ChangeLanguageScreen();

  static PageRoute<ChangeLanguageScreen> getPageRoute() {
    final routeSettings = RouteSettings(name: _routeName);

    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) => ChangeLanguageScreen(),
    );
  }

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButtonWidget(
                onTap: () => context.read<LanguagePresenter>().changelocale(Locale("en", '')),
                textOnButton: "English",
              ),
              CustomButtonWidget(
                onTap: () => context.read<LanguagePresenter>().changelocale(Locale("ru", '')),
                textOnButton: "Русский",
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.red[100],
            child: Text(
              locale.title,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          CustomButtonWidget(
            onTap: () => Navigator.of(context).push(NextScreen.getPageRoute()),
            textOnButton: "Next screen",
          ),
        ],
      ),
    );
  }
}
