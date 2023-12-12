// // ignore_for_file: library_private_types_in_public_api
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
// import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

// import 'my_color.dart';

// class MyBottomBar extends StatefulWidget {
//   const MyBottomBar({super.key, required this.motionTabBarController});
//   final MotionTabBarController motionTabBarController;

//   @override
//   _MyBottomBarState createState() => _MyBottomBarState();
// }

// class _MyBottomBarState extends State<MyBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: MyColors.redDarker,
//         borderRadius: BorderRadius.all(Radius.circular(50)),
//       ),
//       child: Padding(
//         // padding: const EdgeInsets.only(),
//         padding: const EdgeInsets.only(bottom: 2, right: 30, left: 30),
//         child: MotionTabBar(
//           controller: widget.motionTabBarController,
//           initialSelectedTab: "Home",
//           labels: const ["Home", "Selfcare", "Fanpay", "Fanzone", "Market"],
//           icons: const [
//             TablerIcons.smart_home,
//             TablerIcons.heart_handshake,
//             TablerIcons.credit_card,
//             TablerIcons.map_pin_heart,
//             TablerIcons.brand_appgallery
//           ],
//           tabSize: 30,
//           tabBarHeight: 70,
//           textStyle: const TextStyle(
//             fontSize: 11,
//             color: MyColors.yellow,
//             fontWeight: FontWeight.w500,
//             height: 4,
//           ),
//           useSafeArea: true,
//           tabIconColor: Colors.white,
//           tabIconSize: 30.0,
//           tabIconSelectedSize: 30.0,
//           tabSelectedColor: MyColors.redDarker,
//           tabIconSelectedColor: MyColors.yellow,
//           tabBarColor: MyColors.redDarker,
//           onTabItemSelected: (int value) {
//             setState(() {
//               widget.motionTabBarController.index = value;
//               // Navigator.pushReplacementNamed(context, path[value]);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// List<String> path = ['/home', '/selfcare', '/fanpay', '/fanzone', '/market'];

// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'my_color.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar(
      {Key? key, required this.currentIndex, required this.onTabSelected});
  final int currentIndex;
  final Function(int) onTabSelected;

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: MyColors.redDarker,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, right: 30, left: 30),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              widget.onTabSelected(index); // Appel de la fonction de rappel
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                TablerIcons.smart_home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.heart_handshake),
              label: 'Selfcare',
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.credit_card),
              label: 'Fanpay',
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.map_pin_heart),
              label: 'Fanzone',
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.brand_appgallery),
              label: 'Market',
            ),
          ],
          selectedItemColor: MyColors.yellow,
          unselectedItemColor: Colors.white,
          backgroundColor: MyColors.redDarker,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
