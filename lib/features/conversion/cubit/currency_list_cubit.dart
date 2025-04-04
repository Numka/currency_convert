import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  CurrencyListCubit() : super(CurrencyListInitial());
}
