import 'package:flutter/material.dart';
import 'package:my_taraji/feature/init/components/bottom_bar/bar.dart';
import '../../fanpay/page/fanpay_screen.dart';
import '../../fanzone/page/fanzone_screen.dart';
import '../../home/page/home_screen.dart';
import '../../shop/page/shop_screen.dart';
import '../../selfcare/page/selfcare_screen.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  static String routeName = "/";

  @override
  InitScreenState createState() => InitScreenState();
}

class InitScreenState extends State<InitScreen> {
  late LiquidController liquidController;
  int currentSelectedIndex = 0;
  int lastKnownPage = 0;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  void updateCurrentIndex(int index) {
    if (index != currentSelectedIndex) {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  final pages = const [
    HomeScreen(),
    MySelfCare(),
    MyFanPay(),
    MyFanZone(),
    MyShop(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: pages[currentSelectedIndex],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyBottomBar(
              active: items[currentSelectedIndex],
              onTap: (item) {
                updateCurrentIndex(item.index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
