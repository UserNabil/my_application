import 'package:flutter/material.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:my_taraji/views/init/components/bottom_bar/bar.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().setCurrentLocation();
    context.read<HomeProvider>().getUserData();
    List<Widget> pages = context.watch<InitProvider>().pages;

    Widget buildContent(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            pages[context.watch<InitProvider>().currentIndex],
            // AnimatedSwitcher(
            //     duration: const Duration(milliseconds: 300),
            //     child: pages[context.watch<InitProvider>().currentIndex]),
            Align(
              alignment: Alignment.bottomCenter,
              child: MyBottomBar(
                active: items[context.watch<InitProvider>().currentIndex],
                onTap: (item) {
                  context.read<InitProvider>().setCurrentIndex(item.index);
                },
              ),
            ),
          ],
        ),
      );
    }

    return buildContent(context);
  }
}
