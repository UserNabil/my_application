// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_bottom_bar.dart';
import 'package:my_taraji/pages/screens/fanpay_screen.dart';
import 'package:my_taraji/pages/screens/fanzone_screen.dart';
import 'package:my_taraji/pages/screens/market_screen.dart';
import 'package:my_taraji/pages/screens/selfcare_screen.dart';

import 'screens/home_screen.dart';

class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  _MyMainState createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Content(currentIndex: _currentIndex),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyBottomBar(
              currentIndex: _currentIndex,
              onTabSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MySelfCare();
      case 2:
        return const MyFanPay();
      case 3:
        return const MyFanZone();
      case 4:
        return const MyMarket();
      default:
        return const HomeScreen();
    }
  }
}
