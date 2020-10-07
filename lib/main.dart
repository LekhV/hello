import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hello/localizations.dart';
import 'package:hello/features/game_life/game_life_screen.dart';
import 'package:hello/infrastructure/service_locator.dart';
import 'features/example_language/language_presenter.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

const _supportedLocales = [
  Locale('en', ' '),
  Locale('ru', ' '),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguagePresenter(),
      child: Builder(builder: (context) {
        final locale = context.watch<LanguagePresenter>().locale;

        print(locale);

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          locale: locale,
          home: GameLifeScreen(),
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: _supportedLocales,
        );
      }),
    );
  }
}
