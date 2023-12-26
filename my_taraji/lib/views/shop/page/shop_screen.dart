import 'package:flutter/material.dart';

class MyShop extends StatelessWidget {
  const MyShop({super.key});
  static const routeName = '/market';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      'MyMarket',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: InitScreen(currentIndex: 4, active: active),
          // ),
        ],
      ),
    );
  }
}
