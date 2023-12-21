import 'package:flutter/material.dart';
import '../components/fanpay/fanpay_top.dart';

class MyFanPay extends StatelessWidget {
  const MyFanPay({super.key});
  static const routeName = '/fanpay';

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopFanPay(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widgetsToDisplay.length,
                  itemBuilder: (context, index) {
                    return widgetsToDisplay[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
