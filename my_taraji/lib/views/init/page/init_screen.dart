import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:my_taraji/services/service_api.dart';
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
  var apiService = ApiService();

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
    onInitData();
  }

  void updateCurrentIndex(int index) {
    if (index != currentSelectedIndex) {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  void onInitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = await apiService.getUserData();
    List<Challenge> challenges = await apiService.getAllChallenges();
    List<Campaign> campaigns = await apiService.getAllCampaigns();
    for (var campaign in campaigns) {
      prefs.setBool(campaign.id, true);
    }
    prefs.setString('id', userData.id);
    prefs.setString('coins', userData.myRewards.coins.toString());
    prefs.setString('name', userData.pseudo);
    prefs.setString('xp', userData.myGamification.expPoints.toString());
    prefs.setString('phone', userData.phone);
    saveChallenges(challenges);
    saveCampaigns(campaigns);
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
