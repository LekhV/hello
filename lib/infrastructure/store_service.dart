import 'package:flutter/material.dart';
import 'package:hello/config.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreInteractor {
  final String _currentLocaleKey = GetIt.instance<Config>().currentLocaleKey;

  Future<Locale> getCurrentLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(_currentLocaleKey);
    return locale != null ? Locale(locale) : WidgetsBinding.instance.window.locale;
  }

  Future<void> setCurrentLocale(Locale currentLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLocaleKey, currentLocale.toString());
  }
}
