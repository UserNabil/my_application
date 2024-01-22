import 'package:flutter/material.dart';
import 'package:my_taraji/services/local_service.dart';
import 'package:my_taraji/views/fanpay/page/fanpay_screen.dart';
import 'package:my_taraji/views/init/components/bottom_bar/bar.dart';
import 'package:my_taraji/views/selfcare/view/self_care_page.dart';
import '../../fanzone/page/fanzone_screen.dart';
import '../../home/page/home_screen.dart';
import '../../selfcare/page/selfcare_screen.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return const Initiate();
  }
}

class Initiate extends StatefulWidget {
  const Initiate({super.key});

  @override
  InitiateState createState() => InitiateState();
}

class InitiateState extends State<Initiate> {
  int currentIndex = 0;
  String currentContent = '';
  LocalService localService = LocalService();

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    localService.getCurrentLocation();
    localService.getUserData();
    pages = [
      const HomeScreen(),
      const MySelfCare(),
      MyFanPay(
        function: (index) => updateCurrentIndex(index),
      ),
      const MyFanZone(),
      const SelfCarePage(),
      //const MyShop(),
    ];
  }

  onPressed(String content) {
    // ignore: avoid_print
    print(content);
    setState(() {
      if (content == 'return') {
        currentContent = 'return';
      } else {
        currentContent = content;
      }
    });
  }

  updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[currentIndex]),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyBottomBar(
              active: items[currentIndex],
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
