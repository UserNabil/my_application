import 'package:flutter/material.dart';
// import 'package:my_taraji/feature/profile/page/profile_screen.dart';
import '../../feature/fanpay/page/fanpay_screen.dart';
import '../../feature/fanzone/page/fanzone_screen.dart';
import '../../feature/home/page/home_screen.dart';
import '../../feature/shop/page/shop_screen.dart';
import '../../feature/selfcare/page/selfcare_screen.dart';
import 'package:my_taraji/core/pages/loading_page.dart';
import 'package:my_taraji/core/pages/login_screen.dart';
import 'package:my_taraji/core/pages/register_screen.dart';
import 'package:my_taraji/feature/init/page/init_screen.dart';

import '../pages/reset_password.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  MySelfCare.routeName: (context) => const MySelfCare(),
  MyFanPay.routeName: (context) => const MyFanPay(),
  MyFanZone.routeName: (context) => const MyFanZone(),
  MyShop.routeName: (context) => const MyShop(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  LoadingScreen.routeName: (context) => const LoadingScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  // MyProfile.routeName: (context) => const MyProfile(),
};

class CustomPageRoute extends PageRouteBuilder {
  final String routeName;

  CustomPageRoute({required this.routeName})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            final WidgetBuilder? builder = routes[routeName];
            return builder != null ? builder(context) : const SizedBox.shrink();
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
