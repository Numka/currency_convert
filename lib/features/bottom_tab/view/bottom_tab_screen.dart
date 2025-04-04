import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/app/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BottomTabScreen extends StatelessWidget {
  const BottomTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        CurrencyListRoute(),
        ConversionRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
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
  }
}
