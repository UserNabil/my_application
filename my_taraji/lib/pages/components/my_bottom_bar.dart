// import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'my_color.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: MyColors.redDarker,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: MotionTabBar(
          labels: const ["HOME", "SELFCARE", "FANPAY", "FANZONE", "MARKET"],
          icons: const [
            FluentIcons.home_24_regular,
            FluentIcons.heart_24_regular,
            FluentIcons.credit_card_toolbox_24_regular,
            FluentIcons.people_team_24_regular,
            FluentIcons.shopping_bag_24_regular,
            // EneftyIcons.home_outline,
            // EneftyIcons.heart_add_bold,
            // EneftyIcons.card_outline,
            // EneftyIcons.people_outline,
            // EneftyIcons.shop_outline
          ],
          initialSelectedTab: "HOME",
          textStyle: const TextStyle(
            color: MyColors.yellow,
            fontSize: 10,
          ),
          tabIconColor: MyColors.white,
          tabSelectedColor: MyColors.redDarker,
          tabIconSelectedColor: MyColors.yellow,
          tabIconSize: 24.0,
          tabIconSelectedSize: 24.0,
          tabBarColor: MyColors.transparent,
          tabBarHeight: 60,
          tabSize: 50,
          onTabItemSelected: (int value) {
            // print('Tab $value selected');
          },
        ),
      ),
    );
  }
}
