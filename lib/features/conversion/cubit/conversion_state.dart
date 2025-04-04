part of 'conversion_cubit.dart';

enum ConversionStatus { initial, loading, success, failure }

extension ConversionStatusX on ConversionStatus {
  bool get isInitial => this == ConversionStatus.initial;
  bool get isLoading => this == ConversionStatus.loading;
  bool get isSuccess => this == ConversionStatus.success;
  bool get isFailure => this == ConversionStatus.failure;
}

final class ConversionState extends Equatable {
  const ConversionState({
    this.status = ConversionStatus.initial,
    this.fromCurrency,
    this.toCurrency,
    this.amount = 0,
    this.currencies = const [],
    this.result,
  });

  const ConversionState.initial({
    this.status = ConversionStatus.initial,
    this.fromCurrency,
    this.toCurrency,
    this.amount = 0,
    this.currencies = const [],
    this.result,
  });

  final ConversionStatus status;
  final Currency? fromCurrency;
  final Currency? toCurrency;
  final double amount;
  final List<Currency> currencies;
  final ConversionResult? result;

  ConversionState copyWith({
    Currency? fromCurrency,
    Currency? toCurrency,
    double? amount,
    List<Currency>? currencies,
    ConversionResult? result,
  }) {
    return ConversionState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      currencies: currencies ?? this.currencies,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [fromCurrency, toCurrency, amount, currencies, result];
}

class ConversionResult {
  const ConversionResult({
    required this.fromAmount,
    required this.toAmount,
    required this.tax,
    required this.total,
  });
  final double fromAmount;
  final double toAmount;
  final double tax;
  final double total;

  static const empty = ConversionResult(
    fromAmount: 0,
    toAmount: 0,
    tax: 0,
    total: 0,
  );
}
