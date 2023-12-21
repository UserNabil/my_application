import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.svgUrl,
      required this.color,
      required this.width,
      required this.height})
      : super(key: key);
  final String svgUrl;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(41, 157, 157, 157),
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            svgUrl != '' ? svgUrl : 'images/icons/card.svg',
            width: 347,
            height: 237,
            color: color,
          ),
        ],
      )
    ]);
  }
}
