import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/app/app_router.dart';
import 'package:currency_convert/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BottomTabScreen extends StatelessWidget {
  const BottomTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyListCubit, CurrencyListState>(
      builder: (context, state) {
        return AutoTabsScaffold(
          routes: const [
            CurrencyListRoute(),
            ConversionRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            final currenciesLoaded = state.status.isSuccess;

            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: currenciesLoaded
                  ? tabsRouter.setActiveIndex
                  : (index) => _showLoadingSnackbar(
                        context,
                      ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Currencies',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows),
                  label: 'Convert',
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLoadingSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please wait until currencies load'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
