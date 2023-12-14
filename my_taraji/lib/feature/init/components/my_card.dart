// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/theme/my_color.dart';

import '../../home/components/top_content/my_level.dart';
import '../../home/components/top_content/my_match.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.index});
  final int index;

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final CarouselController carouselController = CarouselController();

  @override
  void didUpdateWidget(covariant MyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 347,
      height: 237,
      child: widget.index == 0
          ? MyMatch(carouselController: carouselController)
          : const Padding(padding: EdgeInsets.all(30), child: MyLevel()),
    );
  }
}

class DeformedContainer extends StatelessWidget {
  final double width;
  final Color color;
  const DeformedContainer({Key? key, required this.width, required this.color})
      : super(key: key);

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
            'images/icons/card.svg',
            width: width,
            height: 237,
            color: color,
          ),
        ],
      )
    ]);
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: DeformedContainer(width: 347, color: MyColors.white)),
        ),
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: DeformedContainer(width: 347, color: MyColors.white)),
        ),
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: DeformedContainer(width: 347, color: MyColors.white)),
        ),
        const Center(
          child: DeformedContainer(width: 347, color: MyColors.white),
        ),
        Center(child: MyCard(index: index))
      ],
    );
  }
}
