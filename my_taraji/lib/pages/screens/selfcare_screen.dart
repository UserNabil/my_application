// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
<<<<<<< HEAD
import '../core/my_card.dart';
import '../core/my_color.dart';
import '../core/my_profile.dart';
import '../core/my_taraji_logo.dart';
=======
import '../components/my_card.dart';
import '../components/my_color.dart';
import '../components/my_profile.dart';
import '../components/my_taraji_logo.dart';
>>>>>>> Develop
import '../self_care/list_transaction_screen.dart';

class MySelfCare extends StatelessWidget {
  const MySelfCare({super.key});
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [const SelfCareContent()];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}

class SelfCareContent extends StatelessWidget {
  const SelfCareContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CustomContainer(),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            SizedBox(height: 10),
            TopNavigation(),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: DeformedContainer(width: 347, color: MyColors.yellow)),
          ]),
        ),
        Column(children: [
          SizedBox(height: 125),
          SelfCare(),
        ]),
      ],
    );
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

class TopNavigation extends StatelessWidget {
  const TopNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
      title: const Center(
        child: Text(
          'Selfcare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}

class SelfCare extends StatefulWidget {
  const SelfCare({Key? key}) : super(key: key);

  @override
  _SelfCareState createState() => _SelfCareState();
}

class _SelfCareState extends State<SelfCare> {
  String currentContent = '';
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
        return const ListTransactionScreen();
      // case 'Mon status':
      //   return const MyFanZone();
      // case 'Notifications':
      //   return const MyMarket();
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
        phoneNumberTextColor: MyColors.grey,
        photoSize: 60,
        name: 'John Doe',
        phoneNumber: '50 500 444',
        profileImagePath:
            'https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp',
      ),
      const SizedBox(height: 30),
      ListView.builder(
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
      const Center(
        child: Text(
          'Déconnexion',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: MyColors.yellow,
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
