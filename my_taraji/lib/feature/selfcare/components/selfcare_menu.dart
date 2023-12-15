import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/feature/selfcare/components/list_commande_screen.dart';
import '../../../core/theme/my_color.dart';
import '../../init/components/my_profile.dart';
import '../../init/components/my_taraji_logo.dart';
import 'list_transaction.dart';
import 'mon_status.dart';

class SelfCareMenu extends StatefulWidget {
  const SelfCareMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelfCareMenuState createState() => _SelfCareMenuState();
}

class _SelfCareMenuState extends State<SelfCareMenu>
    with TickerProviderStateMixin {
  String currentContent = '';
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildSlideTransition(Widget child) {
    return SlideTransition(
      position: _animation,
      child: child,
    );
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
      child: manageRoute(currentContent),
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
              currentContent = location;
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
                  fontSize: 18,
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
        ));
  }

  Widget manageRoute(String route) {
    switch (route) {
      case 'profile':
        return selfContainer();
      case 'payments':
        _controller.forward();
        return buildSlideTransition(const ListTransaction());
      case 'statut':
        _controller.forward();
        return buildSlideTransition(const MonStatus());
      // case 'Notifications':
      //   return const MyMarket();
      case 'orders':
        return const ListCommandeScreen();
      default:
        return selfContainer();
    }
  }

  Widget selfContainer() {
    return Column(children: [
      const SizedBox(height: 20),
      SvgPicture.asset(
        'images/icons/drag.svg',
        height: 5,
        width: 5,
      ),
      const SizedBox(height: 20),
      const MyProfile(
        textPosition: TextPosition.right,
        nameTextColor: MyColors.black,
        coinsTextColor: MyColors.grey,
        photoSize: 60,
      ),
      const SizedBox(height: 30),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: row.length,
        itemBuilder: (context, index) {
          return rowItemWidget(
            context: context,
            title: row[index].title,
            location: row[index].location,
            icon: row[index].icon,
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MyColors.yellow,
            ),
          ),
        ),
      ),
      const SizedBox(height: 100),
    ]);
  }
}

final List<RowItem> row = [
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

class RowItem {
  final IconData icon;
  final String title;
  final String location;

  RowItem({
    required this.icon,
    required this.title,
    required this.location,
  });
}
