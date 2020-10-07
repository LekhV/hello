import 'package:get_it/get_it.dart';

import 'package:hello/config.dart';
import 'package:hello/infrastructure/store_service.dart';

void setupLocator() {
  GetIt locator = GetIt.instance;

  locator.registerSingleton<Config>(Config());
  locator.registerSingleton<StoreInteractor>(StoreInteractor());
}
