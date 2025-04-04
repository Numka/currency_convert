import 'package:bloc/bloc.dart';
import 'package:currency_convert/features/features.dart';
import 'package:equatable/equatable.dart';

part 'conversion_state.dart';

class ConversionCubit extends Cubit<ConversionState> {
  ConversionCubit() : super(const ConversionState.initial());

  void setFromCurrency(Currency? currency) {
    final exactCurrency = state.currencies.firstWhere(
      (c) => c.id == currency?.id,
      orElse: () => currency!,
    );
    emit(state.copyWith(fromCurrency: exactCurrency));
  }

  void setToCurrency(Currency? currency) {
    final exactCurrency = state.currencies.firstWhere(
      (c) => c.id == currency?.id,
      orElse: () => currency!,
    );
    emit(state.copyWith(toCurrency: exactCurrency));
  }

  void setAmount(double amount) {
    emit(state.copyWith(amount: amount));
  }

  void setCurrencies(List<Currency> currencies) {
    emit(state.copyWith(amount: 0, currencies: currencies));
  }

  void calculateConversion() {
    if (state.fromCurrency == null ||
        state.toCurrency == null ||
        state.amount <= 0 ||
        state.fromCurrency == state.toCurrency) {
      return;
    }

    final fromValue = state.fromCurrency!.rateUsd;
    final toValue = state.toCurrency!.rateUsd;
    final amount = state.amount;

    final convertedAmount = _convertCurrencyHelper(fromValue, toValue, amount);

    final tax = convertedAmount * 0.03;
    final total = convertedAmount + tax;

    emit(
      state.copyWith(
        result: ConversionResult(
          fromAmount: amount,
          toAmount: convertedAmount,
          tax: tax,
          total: total,
        ),
      ),
    );
  }

  double _convertCurrencyHelper(
    double firstCurrencyInUSD,
    double secondCurrencyInUSD,
    double amount,
  ) {
    final amountInUSD = amount / firstCurrencyInUSD;
    final convertedAmount = amountInUSD * secondCurrencyInUSD;

    return convertedAmount;
  }
}
