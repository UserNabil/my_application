import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_card.dart';

class ListCarouselChallenges extends StatefulWidget {
  const ListCarouselChallenges({super.key, required this.challenges});
  final List<Challenge> challenges;

  @override
  ListCarouselChallengesState createState() => ListCarouselChallengesState();
}

class ListCarouselChallengesState extends State<ListCarouselChallenges> {
  @override
  Widget build(BuildContext context) {
    if (widget.challenges.isEmpty) {
      return Container();
    } else {
      return buildContainer(context);
    }
  }

  Widget buildContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: MyColors.transparent,
          padding: const EdgeInsets.all(15),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Challenges',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(milliseconds: 3000),
              enlargeFactor: 0.2,
            ),
            items: [
              for (final newsData in widget.challenges)
                ChallengeCard(
                  context: context,
                  challengeName: newsData.title,
                  title: newsData.title,
                  description: newsData.description,
                  imageUrl: "images/pngs/challenge1.jpg",
                  coins: newsData.title,
                  titleFontSize: 13.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
