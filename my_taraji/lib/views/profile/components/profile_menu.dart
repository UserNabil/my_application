import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../../core/models/row_item.dart';
import '../../../../core/theme/my_color.dart';
import '../../init/components/my_profile.dart';
import '../../init/components/my_taraji_logo.dart';
import '../../selfcare/components/selfcare/animation_selfcare.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu(
      {super.key, required this.profileContent, required this.onPressed});
  final String profileContent;
  final Function onPressed;

  @override
  ProfileMenuState createState() => ProfileMenuState();
}

class ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: const BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      alignment: Alignment.center,
      child: manageRoute(widget.profileContent),
    );
  }

  Widget rowItemWidget(
      {required BuildContext context,
      required String title,
      required String location,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onPressed(location);
          });
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: MyColors.yellow,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              TablerIcons.chevron_right,
              color: MyColors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget manageRoute(String route) {
    switch (route) {
      case 'return':
        return AnimationSelfCareMenu(
            animationDirection: -1, child: profileContainer());
      case 'account':
        return AnimationSelfCareMenu(
          animationDirection: 1,
          child: TextButton(
            onPressed: () => {
              setState(() {
                widget.onPressed('profile');
              })
            },
            child: const Text("Mon compte"),
          ),
        );
      case 'address':
        return const AnimationSelfCareMenu(
            animationDirection: 1,
            child: Text("adresse", style: TextStyle(color: MyColors.black)));
      case 'settings':
        return const AnimationSelfCareMenu(
            animationDirection: 1,
            child: Text("paramètres", style: TextStyle(color: MyColors.black)));
      case 'helps':
        return const AnimationSelfCareMenu(
            animationDirection: 1,
            child:
                Text("centre d'aide", style: TextStyle(color: MyColors.black)));
      case 'contact':
        return const AnimationSelfCareMenu(
            animationDirection: 1,
            child: Text("contact", style: TextStyle(color: MyColors.black)));
      default:
        return profileContainer();
    }
  }

  Widget profileContainer() {
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          'images/icons/drag.svg',
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            MyProfile(
              textPosition: TextPositionLogo.right,
              nameTextColor: MyColors.black,
              coinsTextColor: MyColors.grey,
              photoSize: 60,
            ),
          ],
        ),
        const SizedBox(height: 30),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: rows.length,
          itemBuilder: (context, index) {
            return rowItemWidget(
              context: context,
              title: rows[index].title,
              location: rows[index].location,
              icon: rows[index].icon,
            );
          },
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              'Déconnexion',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: MyColors.yellow,
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

final List<RowItem> rows = [
  RowItem(
    title: 'Mon compte',
    location: 'account',
    icon: TablerIcons.user_circle,
  ),
  RowItem(
    title: 'Adresse',
    location: 'address',
    icon: TablerIcons.pin,
  ),
  RowItem(
    title: 'Paramètres',
    location: 'settings',
    icon: TablerIcons.settings,
  ),
  RowItem(
    title: "Centre d'aide",
    location: 'helps',
    icon: TablerIcons.help,
  ),
  RowItem(
    title: 'Contact',
    location: 'contact',
    icon: TablerIcons.phone,
  ),
];
