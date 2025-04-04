import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/app/app_router.dart';
import 'package:currency_convert/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrencyListScreen extends StatelessWidget {
  const CurrencyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Rates'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () async {
              context.read<AuthCubit>().logout();
              await context.router.replace(const AuthRoute());
            },
          ),
        ],
      ),
      body: BlocBuilder<CurrencyListCubit, CurrencyListState>(
        builder: (context, state) {
          if (state.status.isInitial || state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status.isFailure) {
            return Center(child: Text(state.errorMessage!));
          } else if (state.status.isSuccess) {
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                final currency = state.currencies[index];
                return ListTile(
                  title: Text(currency.symbol),
                  subtitle: Text(currency.id),
                  trailing: Text(
                    currency.rateUsd.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CurrencyListCubit>().fetchCurrencies();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
