import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/views/selfcare/components/list_commande.dart';
import '../../../../core/models/row_item.dart';
import '../../../../core/theme/my_color.dart';
import '../../../init/components/my_profile.dart';
import '../../../init/components/my_taraji_logo.dart';
import '../../../profile/components/profile_menu.dart';
import '../list_transaction.dart';
import '../mon_status.dart';
import 'animation_selfcare.dart';

class SelfCareMenu extends StatefulWidget {
  const SelfCareMenu(
      {super.key, required this.currentContent, required this.onPressed});
  final String currentContent;
  final Function onPressed;

  @override
  SelfCareMenuState createState() => SelfCareMenuState();
}

class SelfCareMenuState extends State<SelfCareMenu> {
  String profileContent = '';

  void onProfilePressed(String content) {
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
      child: manageRoute(widget.currentContent),
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
            animationDirection: -1, child: selfContainer());
      case 'profile':
        return AnimationSelfCareMenu(
            animationDirection: 1,
            child: ProfileMenu(
                onPressed: onProfilePressed, profileContent: profileContent));
      case 'payments':
        return const AnimationSelfCareMenu(
            animationDirection: 1, child: ListTransaction());
      case 'statut':
        return const AnimationSelfCareMenu(
            animationDirection: 1, child: MonStatus());
      case 'orders':
        return const AnimationSelfCareMenu(
            animationDirection: 1, child: ListCommande());
      default:
        return selfContainer();
    }
  }

  Widget selfContainer() {
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
              textPosition: TextPosition.right,
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
    title: 'Mon profil',
    location: 'profile',
    icon: TablerIcons.user_circle,
  ),
  RowItem(
    title: 'Mes transactions',
    location: 'payments',
    icon: TablerIcons.credit_card,
  ),
  RowItem(
    title: 'Mon status',
    location: 'statut',
    icon: TablerIcons.military_award,
  ),
  RowItem(
    title: 'Notifications',
    location: 'alerts',
    icon: TablerIcons.bell,
  ),
  RowItem(
    title: 'Parraiange',
    location: 'sponsorship',
    icon: TablerIcons.discount_check,
  ),
  RowItem(
    title: 'Mes commandes',
    location: 'orders',
    icon: TablerIcons.box_seam,
  ),
];
