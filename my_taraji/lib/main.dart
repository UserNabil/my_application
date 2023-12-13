import 'package:flutter/material.dart';
import 'pages/main_screen.dart';
import 'pages/reset_password.dart';
import 'dart:async';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
<<<<<<< HEAD
import 'pages/content/loading_page.dart';
=======
import 'pages/components/loading_page.dart';
>>>>>>> Develop
import 'pages/screens/fanpay_screen.dart';
import 'pages/screens/fanzone_screen.dart';
import 'pages/screens/market_screen.dart';
import 'pages/screens/selfcare_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(
      const Duration(seconds: 5),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Taraji',
      theme: ThemeData(
        fontFamily: 'Poppins',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: isLoading ? const LoadingScreen() : const MyMain(),
      // home: isLoading ? const LoadingScreen() : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/home': (context) => const MyMain(),
        '/home/selfcare': (context) => const MySelfCare(),
        '/home/fanpay': (context) => const MyFanPay(),
        '/home/fanzone': (context) => const MyFanZone(),
        '/home/market': (context) => const MyMarket(),
      },
    );
  }
}
