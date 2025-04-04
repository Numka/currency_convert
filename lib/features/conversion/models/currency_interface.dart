import 'package:currency_convert/features/features.dart';

abstract class CurrencyInterface {
  Future<List<Currency>> getCurrencies();
}
