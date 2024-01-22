import '../../../init/components/my_card.dart';
import '../../../../core/components/background_top.dart';

import '../../import.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  TopScreenState createState() => TopScreenState();
}

class TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    int myIndex = 1;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 500,
        ),
        const CustomContainer(
          colorTo: MyColors.red,
          colorFrom: MyColors.redDarker,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 80),
              MyNavBar(
                items: [
                  NavBarItem(
                      icon: TablerIcons.shirt_sport, label: 'Gamification'),
                  NavBarItem(icon: TablerIcons.soccer_field, label: 'Matchs'),
                ],
                onItemSelected: (index) {
                  setState(() {
                    myIndex = index;
                  });
                },
              ),
              const SizedBox(height: 20),
              Cards(index: myIndex),
            ],
          ),
        ),
      ],
    );
  }
}
