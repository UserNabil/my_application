import 'package:my_taraji/views/home/provider/home_provider.dart';

import '../../../init/components/my_card.dart';
import '../../../../core/components/background_top.dart';
import '../../import.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  context.read<HomeProvider>().setCurrentCardIndex(index);
                },
              ),
              const SizedBox(height: 20),
              const Cards(),
            ],
          ),
        ),
      ],
    );
  }
}
