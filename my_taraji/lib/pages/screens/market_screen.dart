import 'package:flutter/material.dart';

class MyMarket extends StatelessWidget {
  const MyMarket({super.key});
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [const Text('MyMarket')];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}
