// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../fanpay/page/fanpay_screen.dart';
import '../../fanzone/page/fanzone_screen.dart';
import '../../home/page/home_screen.dart';
import '../../shop/page/shop_screen.dart';
import '../../selfcare/page/selfcare_screen.dart';
// import '../core/my_color.dart';
// import '../../models/menu_item.dart';

// List<String> path = ['/home', '/selfcare', '/fanpay', '/fanzone', '/market'];
// List items = [
//   MenuItem(
//       index: 0,
//       x: -1.0,
//       name: "Home",
//       fileName: 'home',
//       color: MyColors.yellow),
//   MenuItem(
//       index: 1,
//       x: -0.5,
//       name: "Selfcare",
//       fileName: 'selfcare',
//       color: MyColors.yellow),
//   MenuItem(
//       index: 2,
//       x: 0.0,
//       name: "Fanpay",
//       fileName: 'fanpay',
//       color: MyColors.yellow),
//   MenuItem(
//       index: 3,
//       x: 0.5,
//       name: "Fanzone",
//       fileName: 'fanzone',
//       color: MyColors.yellow),
//   MenuItem(
//       index: 4, x: 1.0, name: "Shop", fileName: 'shop', color: MyColors.yellow),
// ];

// class InitScreen extends StatefulWidget {
//   const InitScreen({super.key});
//   static String routeName = "/";

//   @override
//   State<InitScreen> createState() => NavBarState();
// }

// class NavBarState extends State<InitScreen> {
//   MenuItem active = items[0];

//   void updateCurrentIndex(MenuItem index) {
//     setState(() {
//       active = index;
//     });
//   }

//   final pages = [
//     const HomeScreen(),
//     const MySelfCare(),
//     const MyFanPay(),
//     const MyFanZone(),
//     const MyMarket(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.redDarker,
//       body: pages[active.index],
//       bottomNavigationBar: test(context),
//     );
//   }

//   Widget childItem(MenuItem item) {
//     return GestureDetector(
//       onTapDown: (TapDownDetails details) {
//         setState(() {
//           // Navigator.pushNamed(context, path[item.index]);
//         });
//       },
//       child: AspectRatio(
//         aspectRatio: .3,
//         child: Padding(
//             padding: EdgeInsets.only(top: item.index == active.index ? 20 : 50),
//             child: AnimatedCrossFade(
//               crossFadeState: item.index == active.index
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 500),
//               firstChild: FutureBuilder(
//                   future: Future.delayed(
//                     const Duration(milliseconds: 200),
//                     () => true,
//                   ),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Container();
//                     } else {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 'images/icons/${item.fileName}.svg',
//                                 color: MyColors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   }),
//               secondChild: FutureBuilder(
//                   future: Future.delayed(
//                     const Duration(milliseconds: 500),
//                     () => true,
//                   ),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Container();
//                     } else {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 'images/icons/${item.fileName}.svg',
//                                 color: MyColors.yellow,
//                               ),
//                               const SizedBox(height: 13),
//                               item.index == active.index
//                                   ? Text(
//                                       item.name,
//                                       maxLines: 1,
//                                       style: const TextStyle(
//                                         fontSize: 8.5,
//                                         color: MyColors.yellow,
//                                       ),
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   }),
//             )),
//       ),
//       onTap: () {
//         // setState(() {
//         //   active = item;
//         // });
//       },
//     );
//   }

//   Widget test(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(color: MyColors.transparent),
//       height: 120,
//       width: 360,
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 30),
//             child: Container(
//                 height: 70,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: MyColors.redDarker,
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               alignment: Alignment(active.x, -1),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 0),
//                 height: 50,
//                 width: active.index != 0 && active.index != 4
//                     ? 330 * 0.38
//                     : 330 * 0.41,
//                 color: Colors.transparent,
//                 child: Slider(currentIndex: active.index),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 45),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: items.map((item) => childItem(item)).toList(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Slider extends StatelessWidget {
//   const Slider({super.key, required this.currentIndex});
//   final int currentIndex;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: Center(
//         child: SvgPicture.asset(
//           'images/icons/${(currentIndex == 0 ? 'current_left' : currentIndex == 4 ? 'current_right' : 'current')}.svg',
//           color: MyColors.redDarker,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../core/theme/my_color.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    const MySelfCare(),
    const MyFanPay(),
    const MyFanZone(),
    const MyShop(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: MyColors.white,
        backgroundColor: MyColors.redDarker,
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(TablerIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(TablerIcons.user),
            label: "Selfcare",
          ),
          BottomNavigationBarItem(
            icon: Icon(TablerIcons.credit_card),
            label: "Fanpay",
          ),
          BottomNavigationBarItem(
            icon: Icon(TablerIcons.heart),
            label: "Fanzone",
          ),
          BottomNavigationBarItem(
            icon: Icon(TablerIcons.shopping_bag),
            label: "Shop",
          ),
        ],
        selectedItemColor: MyColors.yellow,
      ),
    );
  }
}
