// ignore_for_file: cascade_invocations

import 'package:currency_convert/app/app_router.dart';
import 'package:currency_convert/features/features.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerFactory(AuthCubit.new);
  getIt.registerFactory(
    () => CurrencyListCubit(currencyRepo: getIt()),
  );
  getIt.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepository(dio: getIt()),
  );
  getIt.registerLazySingleton(Dio.new);
}
