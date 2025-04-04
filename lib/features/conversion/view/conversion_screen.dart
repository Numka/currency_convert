import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/features/features.dart';
import 'package:currency_convert/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ConversionScreen extends StatelessWidget {
  const ConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initialCurrencyState = context.read<CurrencyListCubit>().state;

    return BlocProvider(
      create: (context) {
        final cubit = getIt<ConversionCubit>();
        if (initialCurrencyState.status.isSuccess) {
          cubit.setCurrencies(initialCurrencyState.currencies);
        }
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Currency Conversion')),
        body: BlocListener<CurrencyListCubit, CurrencyListState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ConversionCubit>().setCurrencies(state.currencies);
            }
          },
          child: BlocBuilder<ConversionCubit, ConversionState>(
            builder: (context, state) {
              if (state.currencies.isNotEmpty) {
                return _buildConversionForm(context, state);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildConversionForm(BuildContext context, ConversionState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
          const SizedBox(height: 16),
          _buildCurrencyDropdown(
            context,
            'To',
            state.toCurrency,
            state.currencies,
            (currency) {
              context.read<ConversionCubit>().setToCurrency(currency);
            },
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          if (state.result != null) _buildResult(state),
        ],
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '(${result.toAmount.toStringAsFixed(2)} $toSymbol + 3%)',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
