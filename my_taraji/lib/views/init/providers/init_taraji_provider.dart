import 'package:flutter/material.dart';
import 'package:my_taraji/views/fanpay/page/fanpay_screen.dart';
import 'package:my_taraji/views/selfcare/view/self_care_page.dart';
import '../../fanzone/page/fanzone_screen.dart';
import '../../home/page/home_screen.dart';
import '../../shop/page/shop_screen.dart';

class InitProvider with ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SelfCarePage(),
    const MyFanPay(),
    const MyFanZone(),
    const MyShop(),
  ];

  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
    }
    notifyListeners();
  }

  void initCurrentIndex() {
    _currentIndex = 0;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;
}
