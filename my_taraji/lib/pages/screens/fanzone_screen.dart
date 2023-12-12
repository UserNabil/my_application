import 'package:flutter/material.dart';

class MyFanZone extends StatelessWidget {
  const MyFanZone({super.key});
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [const Text('MyFanZone')];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}
