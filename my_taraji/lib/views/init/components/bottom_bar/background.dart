import 'package:flutter/material.dart';

import '../../../../core/theme/my_color.dart';

class BackgroundBar extends StatelessWidget {
  const BackgroundBar({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.redDarker,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
