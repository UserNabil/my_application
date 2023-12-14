import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../../../../core/theme/my_color.dart';

class MyProgressBar extends StatelessWidget {
  final double value;

  const MyProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 285,
      height: 15,
      child: SimpleAnimationProgressBar(
        height: 20,
        width: 400,
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
        foregrondColor: MyColors.yellow,
        ratio: 0.5,
        direction: Axis.horizontal,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        gradientColor: const LinearGradient(
            colors: [Color.fromARGB(255, 220, 220, 220), MyColors.yellow]),
      ),
    );
  }
}
