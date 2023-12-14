// ignore_for_file: library_private_types_in_public_api
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter/material.dart';
import 'my_navbar.dart';
import '../../../init/components/my_card.dart';
import '../../../../core/components/background_top.dart';
import '../../../init/components/my_profile.dart';
import '../../../init/components/my_taraji_logo.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 450,
        child: Stack(
          children: [
            const CustomContainer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTarajiLogo(
                        logoImagePath: 'images/taraji.png',
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
                      NavBarItem(
                          icon: TablerIcons.soccer_field, label: 'Matchs'),
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
        ));
  }
}
