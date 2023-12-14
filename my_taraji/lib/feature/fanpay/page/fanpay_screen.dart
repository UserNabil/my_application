import 'package:flutter/material.dart';

class MyFanPay extends StatelessWidget {
  const MyFanPay({super.key});
  static const routeName = '/fanpay';
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

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
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'MyFanPay',
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
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: InitScreen(),
          // ),
        ],
      ),
    );
  }
}
