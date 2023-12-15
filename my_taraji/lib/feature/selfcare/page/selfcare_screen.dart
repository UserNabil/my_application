// ignore_for_file: library_private_types_in_public_api, unused_element
import 'package:flutter/material.dart';
import '../../../core/components/background_top.dart';
import '../../../core/components/top_navigation.dart';
import '../../init/components/my_card.dart';
import '../../../core/theme/my_color.dart';
import '../components/selfcare_menu.dart';

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
        ],
      ),
    );
  }
}

class SelfCare extends StatefulWidget {
  const SelfCare({super.key});

  @override
  _SelfCareState createState() => _SelfCareState();
}

class _SelfCareState extends State<SelfCare> {
  bool isParent = true;

  @override
  void initState() {
    super.initState();
  }

  void onPressed() {
    setState(() {
      isParent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      Stack(
        children: [
          const CustomContainer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(height: 10),
              TopNavigation(
                  title: "Selfcare", onPressed: onPressed, isParent: isParent),
              const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: DeformedContainer(width: 347, color: MyColors.yellow)),
            ]),
          ),
          const Column(children: [
            SizedBox(height: 125),
            SelfCareMenu(),
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
