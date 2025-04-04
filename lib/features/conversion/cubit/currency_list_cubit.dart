import 'package:bloc/bloc.dart';
import 'package:currency_convert/features/conversion/data/remote/currency_repository.dart';
import 'package:currency_convert/features/features.dart';
import 'package:equatable/equatable.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  CurrencyListCubit({required this.currencyRepo}) : super(const CurrencyListState());

  final CurrencyRepository currencyRepo;

  Future<void> fetchCurrencies() async {
    // add timer so no spam allowed TODO:
    emit(state.copyWith(status: CurrencyListStatus.loading));
    try {
      final currencies = await currencyRepo.getCurrencies();
      emit(state.copyWith(currencies: currencies, status: CurrencyListStatus.success));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: CurrencyListStatus.failure));
    }
  }

  Future<void> watchCurrencies() async {
    // watch every 30 sec, TODO:
  }
}
