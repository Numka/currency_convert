import 'package:bloc/bloc.dart';
import 'package:currency_convert/features/features.dart';
import 'package:equatable/equatable.dart';

part 'conversion_state.dart';

class ConversionCubit extends Cubit<ConversionState> {
  ConversionCubit() : super(const ConversionState.initial());

  void setFromCurrency(Currency? currency) {}

  void setToCurrency(Currency? currency) {}

  void setAmount(double amount) {}

  void setCurrencies(List<Currency> currencies) {}

  void calculateConversion() {}
}
