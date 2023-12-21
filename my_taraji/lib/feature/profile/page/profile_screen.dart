import 'package:flutter/material.dart';
import '../../../core/components/background_top.dart';
import '../../../core/components/custom_card.dart';
import '../../../core/components/top_navigation.dart';
import '../../../core/theme/my_color.dart';
import '../components/profile_menu.dart';

class MyProfileSettings extends StatelessWidget {
  const MyProfileSettings({super.key});
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Profile(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool isParent = true;
  String profileContent = '';

  @override
  void initState() {
    super.initState();
  }

  void onPressed(String content) {
    setState(() {
      if (content == 'return') {
        profileContent = 'return';
      } else {
        profileContent = content;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      Stack(
        children: [
          const CustomContainer(
            colorTo: MyColors.red,
            colorFrom: MyColors.redDarker,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(height: 10),
              TopNavigation(
                  title: "Profil",
                  onPressed: onPressed,
                  currentContent: profileContent),
              const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CustomCard(
                      svgUrl: '',
                      color: MyColors.yellow,
                      width: 347,
                      height: 237)),
            ]),
          ),
          Column(children: [
            const SizedBox(height: 125),
            ProfileMenu(onPressed: onPressed, profileContent: profileContent),
            const SizedBox(height: 50),
          ]),
        ],
      )
    ];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}
