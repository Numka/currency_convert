import 'package:currency_convert/features/features.dart';
import 'package:dio/dio.dart';

class CurrencyRepository implements CurrencyInterface {
  CurrencyRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Currency>> getCurrencies() async {
    final response = await dio.get('https://api.coincap.io/v2/rates');
    final data = response.data['data'] as List;
    return data.map((e) => Currency.fromMap(e as Map<String, dynamic>)).toList();
  }
}
