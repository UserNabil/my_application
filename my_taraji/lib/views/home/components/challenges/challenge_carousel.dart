import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_card.dart';

class ListChallenges extends StatefulWidget {
  const ListChallenges({super.key, required this.challenges});
  final List<Challenge> challenges;

  @override
  ListChallengesState createState() => ListChallengesState();
}

class ListChallengesState extends State<ListChallenges> {
  List<Challenge> _challenges = [];
  @override
  void initState() {
    super.initState();
    _loadCampaigns();
  }

  void _loadCampaigns() async {
    _saveCampaigns();
    List<Challenge> loadedCampaigns = await getChallenges();
    setState(() {
      _challenges = loadedCampaigns;
    });
  }

  void _saveCampaigns() {
    if (widget.challenges.isEmpty) return;
    saveChallenges(widget.challenges);
  }

  @override
  Widget build(BuildContext context) {
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
              // InkWell(
              //   onTap: () {},
              //   child: const Text(
              //     'VOIR TOUS',
              //     style: TextStyle(
              //       backgroundColor: MyColors.transparent,
              //       fontSize: 12.0,
              //       fontWeight: FontWeight.w500,
              //       color: MyColors.grey,
              //     ),
              //   ),
              // ),
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
              for (final newsData in _challenges)
                ChallengeCard(
                  context: context,
                  challengeName: newsData.challengeName,
                  title: newsData.title,
                  subtitle: newsData.subtitle,
                  imagePath: newsData.imagePath,
                  coins: newsData.coins,
                  titleFontSize: 15.0,
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
