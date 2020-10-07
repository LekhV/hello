// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'package:get_it/get_it.dart';
// import 'package:hello/infrastructure/store_service.dart';

// class LanguageService {
//   final _streamController = StreamController<Locale>();
//   Stream<Locale> get appLanguageStream => _streamController.stream;

//   Future<Locale> getAppLanguage() async {
//     Locale locale = await GetIt.instance<StoreInteractor>().getCurrentLocale();

//     return locale;
//   }

//   Future<void> updateAppLanguage(Locale locale) async {
//     appLanguageStream.listen((value) {
//       print('Value from controller: $value');
//     });
//     if (locale != null) {
//       await GetIt.instance<StoreInteractor>().setCurrentLocale(locale);
//       _streamController.add(locale);
//     } else {
//       _streamController.add(await getAppLanguage());
//     }
//   }
// }
