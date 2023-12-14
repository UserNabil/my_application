// ignore_for_file: library_private_types_in_public_api, unused_element
import 'package:flutter/material.dart';
import '../../../core/components/background_top.dart';
import '../../../core/components/top_navigation.dart';
import '../../init/components/my_card.dart';
import '../../../core/theme/my_color.dart';
import '../components/list_selfcare_page.dart';

class MySelfCare extends StatelessWidget {
  const MySelfCare({super.key});
  static const routeName = '/selfcare';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SelfCare(),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: InitScreen(currentIndex: 1, active: active),
          // ),
        ],
      ),
    );
  }
}

class SelfCare extends StatelessWidget {
  const SelfCare({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const Stack(
        children: [
          CustomContainer(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 10),
              TopNavigation(title: "Selfcare"),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: DeformedContainer(width: 347, color: MyColors.yellow)),
            ]),
          ),
          Column(children: [
            SizedBox(height: 125),
            SelfCareContent(),
            SizedBox(height: 50),
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
