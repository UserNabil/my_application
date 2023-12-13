import 'package:flutter/material.dart';

import '../components/top/my_top.dart';
import '../content/list_compagnies_screen.dart';
import '../content/list_news_screen.dart';
import '../content/list_partenaire_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Content();
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopScreen(),
      const ListCompagnesScreen(),
      const ListNewsScreen(),
      const ListPartenaireScreen(),
    ];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}
