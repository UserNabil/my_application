import 'package:flutter/material.dart';
import '../components/top_content/my_top.dart';
import '../components/compagnies/compagnie_carousel.dart';
import '../components/list_news_screen.dart';
import '../components/list_partenaire_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopScreen(),
      const ListCompagnes(),
      const ListNews(),
      const ListPartenaire(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widgetsToDisplay.length,
                  itemBuilder: (context, index) {
                    return widgetsToDisplay[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
