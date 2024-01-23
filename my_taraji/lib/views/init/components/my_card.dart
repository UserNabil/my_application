import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../home/components/top_content/my_level.dart';
import '../../home/components/top_content/my_match.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCustomCard(topPadding: 15),
        _buildCustomCard(topPadding: 10),
        _buildCustomCard(topPadding: 5),
        _buildCustomCard(topPadding: 0),
        const Center(child: MyCard()),
      ],
    );
  }

  Widget _buildCustomCard({required double topPadding}) {
    const cardWidth = 347.0;
    const cardHeight = 237.0;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: const CustomCard(
          svgUrl: '',
          color: MyColors.white,
          width: cardWidth,
          height: cardHeight,
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselController carouselController = CarouselController();
    return SizedBox(
      width: 347,
      height: 237,
      child: context.watch<HomeProvider>().currentCardIndex == 0
          ? const Padding(
              padding: EdgeInsets.all(30),
              child: MyLevel(),
            )
          : MyMatch(carouselController: carouselController),
    );
  }
}
