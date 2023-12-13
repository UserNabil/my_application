// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/core/my_color.dart';
import '../components/my_level_menu/my_level.dart';
import '../components/next_match_menu/next_match.dart';

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
  const MyMatch({super.key, required this.carouselController});
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
    double width = 23;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1);
    path_0.cubicTo(0, size.height * 0.05, width * 0.1, 0, width * 0.2, 0);
    path_0.cubicTo(width * 0.6, 0, width * 0.8, size.height * 0.2, width,
        size.height * 0.1);
    path_0.lineTo(width, size.height - size.height * 0.1);
    path_0.cubicTo(width, size.height - size.height * 0.05, width * 0.9,
        size.height, width * 0.8, size.height);
    path_0.cubicTo(width * 0.4, size.height, width * 0.2,
        size.height - size.height * 0.2, 0, size.height * 0.1);
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
