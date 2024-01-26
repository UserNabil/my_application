import 'package:flutter/material.dart';
import 'package:my_taraji/views/selfcare/view/self_care_page.dart';
import '../../views/fanpay/views/fanpay/fanpay.dart';
import '../../views/fanzone/page/fanzone_screen.dart';
import '../../views/home/page/home_screen.dart';
import '../../views/shop/page/shop_screen.dart';
import 'package:my_taraji/views/init/page/init_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SelfCarePage.routeName: (context) => const SelfCarePage(),
  MyFanPay.routeName: (context) => const MyFanPay(),
  MyFanZone.routeName: (context) => const MyFanZone(),
  MyShop.routeName: (context) => const MyShop(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
