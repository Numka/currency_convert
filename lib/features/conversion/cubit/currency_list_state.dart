part of 'currency_list_cubit.dart';

enum CurrencyListStatus { initial, loading, success, failure }

extension CurrencyListStatusX on CurrencyListStatus {
  bool get isInitial => this == CurrencyListStatus.initial;
  bool get isLoading => this == CurrencyListStatus.loading;
  bool get isSuccess => this == CurrencyListStatus.success;
  bool get isFailure => this == CurrencyListStatus.failure;
}

final class CurrencyListState extends Equatable {
  const CurrencyListState({
    this.status = CurrencyListStatus.initial,
    this.currencies = const [],
    this.errorMessage,
  });

  final CurrencyListStatus status;
  final List<Currency> currencies;
  final String? errorMessage;

  CurrencyListState copyWith({
    CurrencyListStatus? status,
    List<Currency>? currencies,
    String? errorMessage,
  }) {
    return CurrencyListState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currencies, errorMessage];
}
