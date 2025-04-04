import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ConversionScreen extends StatelessWidget {
  const ConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Conversion')),
      body: BlocListener<CurrencyListCubit, CurrencyListState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<ConversionCubit>().setCurrencies(state.currencies);
          }
        },
        child: BlocBuilder<ConversionCubit, ConversionState>(
          builder: (context, state) {
            if (state.status.isLoading || state.currencies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  _buildCurrencyDropdown(
                    context,
                    'From',
                    state.fromCurrency,
                    state.currencies,
                    (currency) {
                      context.read<ConversionCubit>().setFromCurrency(currency);
                    },
                  ),
                  _buildCurrencyDropdown(
                    context,
                    'To',
                    state.toCurrency,
                    state.currencies,
                    (currency) {
                      context.read<ConversionCubit>().setToCurrency(currency);
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final amount = double.tryParse(value) ?? 0;
                      context.read<ConversionCubit>().setAmount(amount);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (state.fromCurrency != null &&
                          state.toCurrency != null &&
                          state.amount > 0 &&
                          state.fromCurrency != state.toCurrency) {
                        context.read<ConversionCubit>().calculateConversion();
                      }
                    },
                    child: const Text('Convert'),
                  ),
                  if (state.result != null) _buildResult(state),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(
    BuildContext context,
    String label,
    Currency? selectedCurrency,
    List<Currency> currencies,
    void Function(Currency?) onChanged,
  ) {
    final uniqueCurrencies = currencies
        .fold<Map<String, Currency>>({}, (map, currency) {
          map.putIfAbsent(currency.id, () => currency);
          return map;
        })
        .values
        .toList();

    return DropdownButtonFormField<Currency>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      isExpanded: true,
      value: selectedCurrency,
      items: uniqueCurrencies
          .map(
            (currency) => DropdownMenuItem<Currency>(
              value: currency,
              child: Text('${currency.symbol} - ${currency.id}'),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select a currency';
        }
        return null;
      },
    );
  }

  Widget _buildResult(ConversionState state) {
    final result = state.result!;
    final fromSymbol = state.fromCurrency!.symbol;
    final toSymbol = state.toCurrency!.symbol;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${state.amount.toStringAsFixed(2)} $fromSymbol -> ${result.total.toStringAsFixed(2)} $toSymbol',
        ),
        Text(
          '(${result.toAmount.toStringAsFixed(2)} $toSymbol + 3%)',
        ),
      ],
    );
  }
}
