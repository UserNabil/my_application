import 'package:flutter/material.dart';

import '../../../../core/theme/my_color.dart';

class BackgroundBar extends StatelessWidget {
  const BackgroundBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: currentIndex == 2 ? MyColors.blueDark : MyColors.redDarker,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
