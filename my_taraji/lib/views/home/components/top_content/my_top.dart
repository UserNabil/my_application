import '../../../init/components/my_card.dart';
import '../../../../core/components/background_top.dart';
import '../../../init/components/my_profile.dart';
import '../../../init/components/my_taraji_logo.dart';
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
    return Container(
      color: Colors.transparent,
      foregroundDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      decoration: const BoxDecoration(
        backgroundBlendMode: BlendMode.multiply,
        gradient: LinearGradient(
          colors: [
            MyColors.white,
            MyColors.white,
            MyColors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 450,
      child: Stack(
        children: [
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
      ),
    );
  }
}
