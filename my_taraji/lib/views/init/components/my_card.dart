import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/theme/my_color.dart';

import '../../home/components/top_content/my_level.dart';
import '../../home/components/top_content/my_match.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.index});
  final int index;

  @override
  MyCardState createState() => MyCardState();
}

class MyCardState extends State<MyCard> {
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
      child: widget.index == 1
          ? MyMatch(carouselController: carouselController)
          : const Padding(padding: EdgeInsets.all(30), child: MyLevel()),
    );
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
              child: CustomCard(
                  svgUrl: '', color: MyColors.white, width: 347, height: 237)),
        ),
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: CustomCard(
                  svgUrl: '', color: MyColors.white, width: 347, height: 237)),
        ),
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: CustomCard(
                  svgUrl: '', color: MyColors.white, width: 347, height: 237)),
        ),
        const Center(
            child: CustomCard(
                svgUrl: '', color: MyColors.white, width: 347, height: 237)),
        Center(child: MyCard(index: index))
      ],
    );
  }
}
