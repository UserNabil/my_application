// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';
import 'my_level_menu/my_level.dart';
import 'next_match_menu/next_match.dart';

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

    if (widget.index != oldWidget.index) {
      print('Index changed to ${widget.index}');
    }
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

class MyMatch extends StatelessWidget {
  MyMatch({super.key, required this.carouselController});
  final CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TeamCarousel(carouselController: carouselController),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  carouselController.previousPage();
                },
                child: const Icon(Icons.chevron_left),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  carouselController.nextPage();
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class MyLevel extends StatelessWidget {
  const MyLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.transparent,
      ),
      child: const MyCardLevel(),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(3, 26.0502);
    path_0.cubicTo(3, 16.2017, 10.5637, 7.97556, 20.3785, 7.16141);
    path_0.cubicTo(138.092, -2.60306, 210.568, -2.18116, 326.571, 7.19946);
    path_0.cubicTo(336.407, 7.99489, 344, 16.2298, 344, 26.0985);
    path_0.lineTo(344, 202.557);
    path_0.cubicTo(344, 212.284, 336.616, 220.452, 326.936, 221.411);
    path_0.cubicTo(210.419, 232.951, 137.791, 232.787, 20.1115, 221.376);
    path_0.cubicTo(10.4112, 220.436, 3, 212.259, 3, 202.513);
    path_0.lineTo(3, 26.0502);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DeformedContainer extends StatelessWidget {
  final double width;
  final Color color;

  const DeformedContainer({Key? key, required this.width, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(41, 157, 157, 157),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            height: 237,
            width: width,
            color: color,
          ),
        ),
      ],
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
        const Padding(
            padding: EdgeInsets.only(top: 15),
            child: DeformedContainer(width: 347, color: MyColors.white)),
        const Padding(
            padding: EdgeInsets.only(top: 10),
            child: DeformedContainer(width: 347, color: MyColors.white)),
        const Padding(
            padding: EdgeInsets.only(top: 5),
            child: DeformedContainer(width: 347, color: MyColors.white)),
        const DeformedContainer(width: 347, color: MyColors.white),
        MyCard(index: index)
      ],
    );
  }
}
