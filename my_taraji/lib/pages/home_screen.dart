import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';
import 'package:my_taraji/pages/components/my_navbar.dart';
import 'package:my_taraji/pages/components/my_profile.dart';
import 'package:my_taraji/pages/components/my_taraji_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 275,
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/header.jpg'),
                fit: BoxFit.fill,
                opacity: 0.05,
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [MyColors.redDarker, MyColors.red],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
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
                ),
                MyNavBar(
                  items: [
                    NavBarItem(
                        icon: Icons.sports_esports_outlined,
                        label: 'Gamification'),
                    NavBarItem(icon: Icons.sports_soccer, label: 'Matchs'),
                  ],
                  onItemSelected: (index) {
                    print('Onglet $index sélectionné');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
