// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_bottom_bar.dart';
import 'components/list_compagnies_screen.dart';
import 'components/list_news_screen.dart';
import 'components/list_partenaire_screen.dart';
import 'components/my_top.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Content(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyBottomBar(),
          ),
        ],
      ),
    );
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
