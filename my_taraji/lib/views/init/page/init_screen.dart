import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/page/fanpay_screen.dart';
import 'package:my_taraji/views/init/components/bottom_bar/bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fanzone/page/fanzone_screen.dart';
import '../../home/page/home_screen.dart';
import '../../shop/page/shop_screen.dart';
import '../../selfcare/page/selfcare_screen.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  InitScreenState createState() => InitScreenState();
}

class InitScreenState extends State<InitScreen> {
  late LiquidController liquidController;
  int currentSelectedIndex = 0;
  int lastKnownPage = 0;
  bool isDragging = false;
  var apiService = UserService();

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
    getCurrentLocation();
    getUserData();
  }

  getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      LocationSettings locationSettings =
          const LocationSettings(accuracy: LocationAccuracy.high);
      Position position = await geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      setState(() {
        prefs.setDouble('latitude', position.latitude);
        prefs.setDouble('longitude', position.longitude);
      });
    } catch (e) {
      throw Exception('getCurrentLocation error : $e');
    }
  }

  void getUserData() async {
    var userService = UserService();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserData userData = await userService.getUserData();
    prefs.setString('id', userData.id);
    prefs.setString('coins', userData.myRewards.coins.toString());
    prefs.setString('name', userData.pseudo);
    prefs.setString('xp', userData.myGamification.expPoints.toString());
    prefs.setString('phone', userData.phone);
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
            duration: const Duration(milliseconds: 300),
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
