import 'package:flutter/material.dart';

class MyFanZone extends StatelessWidget {
  const MyFanZone({super.key});
  static const routeName = '/fanzone';

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
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'MyFanZone',
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
          //   child: InitScreen(currentIndex: 3, active: active),
          // ),
        ],
      ),
    );
  }
}
