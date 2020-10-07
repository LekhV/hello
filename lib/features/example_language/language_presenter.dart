import 'package:flutter/widgets.dart';

class LanguagePresenter extends ChangeNotifier {
  Locale _locale = Locale('en');
  Locale get locale => _locale;

  void changelocale(Locale l) {
    _locale = l;
    notifyListeners();
  }
}
