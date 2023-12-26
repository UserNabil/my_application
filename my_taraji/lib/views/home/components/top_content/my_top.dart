import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'my_navbar.dart';
import '../../../init/components/my_card.dart';
import '../../../../core/components/background_top.dart';
import '../../../init/components/my_profile.dart';
import '../../../init/components/my_taraji_logo.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  TopScreenState createState() => TopScreenState();
}

class TopScreenState extends State<TopScreen> {
  int myIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          const CustomContainer(
            colorTo: MyColors.red,
            colorFrom: MyColors.redDarker,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTarajiLogo(
                      logoImagePath: 'images/pngs/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 40,
                      textSize: 17,
                      textPosition: TextPosition.right,
                    ),
                    MyProfile(
                      greetingText: 'Bonjour',
                      textPosition: TextPosition.left,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyNavBar(
                  items: [
                    NavBarItem(
                        icon: TablerIcons.shirt_sport, label: 'Gamification'),
                    NavBarItem(icon: TablerIcons.soccer_field, label: 'Matchs'),
                  ],
                  onItemSelected: (index) {
                    setState(() {
                      myIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Cards(index: myIndex)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
