import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/my_color.dart';

class Slider extends StatelessWidget {
  const Slider({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.transparent,
      child: Center(
        child: SvgPicture.asset(
          'images/icons/${(currentIndex == 0 ? 'current_left' : currentIndex == 4 ? 'current_right' : 'current')}.svg',
          color: MyColors.redDarker,
        ),
      ),
    );
  }
}
