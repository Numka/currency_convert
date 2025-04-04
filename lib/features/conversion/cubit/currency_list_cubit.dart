import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_convert/features/features.dart';
import 'package:equatable/equatable.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  CurrencyListCubit({required this.currencyRepo}) : super(const CurrencyListState());

  final CurrencyRepository currencyRepo;
  StreamSubscription<dynamic>? fetchSubscription;
  Timer? spamTimer;

  void watchCurrencies() {
    fetchSubscription?.cancel();

    fetchSubscription = Stream.periodic(
      const Duration(seconds: 30),
      (_) => fetchCurrencies(),
    ).listen((_) {});

    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    if (spamTimer?.isActive ?? false) return;

    spamTimer = Timer(const Duration(seconds: 1), () {});

    emit(state.copyWith(status: CurrencyListStatus.loading));
    try {
      final currencies = await currencyRepo.getCurrencies();
      emit(state.copyWith(currencies: currencies, status: CurrencyListStatus.success));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: CurrencyListStatus.failure));
    }
  }
}
