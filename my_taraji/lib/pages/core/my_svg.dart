import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySvgIcon extends StatelessWidget {
  final String svgPath;

  const MySvgIcon({required this.svgPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      width: 24, 
      height: 24,
    );
  }
}