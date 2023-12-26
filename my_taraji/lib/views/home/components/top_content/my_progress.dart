import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../../../../core/theme/my_color.dart';

class MyProgressBar extends StatelessWidget {
  final double value;
  final double width;
  final double height;

  const MyProgressBar({
    super.key,
    required this.value,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SimpleAnimationProgressBar(
        height: height,
        width: width,
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
        foregrondColor: MyColors.yellow,
        ratio: value,
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
