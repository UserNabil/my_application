// ignore_for_file: library_private_types_in_public_api

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'my_card.dart';
import 'my_color.dart';
import 'my_navbar.dart';
import 'my_profile.dart';
import 'my_taraji_logo.dart';

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
                      ProfileSection(
                        name: 'John Doe',
                        phoneNumber: '50 500 444',
                        profileImagePath: 'images/profile.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MyNavBar(
                    items: [
                      NavBarItem(
                          icon: FluentIcons.trophy_24_regular,
                          label: 'Gamification'),
                      NavBarItem(
                          icon: FluentIcons.sport_soccer_24_regular,
                          label: 'Matchs'),
                    ],
                    onItemSelected: (index) {
                      setState(() {
                        myIndex = (myIndex + 1) % 2;
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/header.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.05),
            BlendMode.dstATop,
          ),
        ),
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [MyColors.redDarker, MyColors.red],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }
}
