import 'package:flutter/material.dart';
import '../../../core/components/background_top.dart';
import '../../../core/components/custom_card.dart';
import '../../../core/components/top_navigation.dart';
import '../../../core/theme/my_color.dart';
import '../components/selfcare/selfcare_menu.dart';

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
  SelfCareState createState() => SelfCareState();
}

class SelfCareState extends State<SelfCare> {
  bool isParent = true;
  String currentContent = '';

  @override
  void initState() {
    super.initState();
  }

  void onPressed(String content) {
    setState(() {
      if (content == 'return') {
        currentContent = 'return';
      } else {
        currentContent = content;
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
                  title: currentContent == 'profile' ? 'Profil' : "Selfcare",
                  onPressed: onPressed,
                  currentContent: currentContent),
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
            SelfCareMenu(onPressed: onPressed, currentContent: currentContent),
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
