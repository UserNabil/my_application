import 'dart:async';

import 'package:flutter/material.dart';
import '../../feature/init/components/my_taraji_logo.dart';
import '../theme/my_color.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const routeName = '/loading';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
          Navigator.pushNamed(context, '/login');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [MyColors.redDarker, MyColors.red],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTarajiLogo(
                      logoImagePath: 'images/pngs/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 100,
                      textSize: 16,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Queney © 2024',
                style: TextStyle(
                  color: MyColors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
