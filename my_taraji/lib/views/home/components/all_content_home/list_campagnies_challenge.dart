import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/home/components/all_content_home/all_content_list.dart';
import 'package:my_taraji/views/home/components/campagnies/compagnie_card.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_card.dart';

class AllContent extends StatefulWidget {
  const AllContent(
      {super.key, required this.campagnes, required this.challenges});
  final List<Campaign> campagnes;
  final List<Challenge> challenges;

  @override
  AllContentState createState() => AllContentState();
}

class AllContentState extends State<AllContent> {
  @override
  Widget build(BuildContext context) {
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: MyColors.transparent,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Campagnes',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllContentPage(
                        compagnes: widget.campagnes,
                        challenges: widget.challenges,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'VOIR TOUS',
                  style: TextStyle(
                    backgroundColor: MyColors.transparent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: MyColors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 195,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(milliseconds: 5000),
              enlargeFactor: 0.2,
            ),
            items: [
              ...widget.campagnes.map(
                (campaign) => CompaignCard(
                  context: context,
                  campaign: campaign,
                  titleFontSize: 15.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
              ),
              ...widget.challenges.map(
                (challenge) => ChallengeCard(
                  context: context,
                  challengeName: challenge.title,
                  title: challenge.title,
                  description: challenge.description,
                  imageUrl: "images/pngs/challenge1.jpg",
                  coins: challenge.title,
                  titleFontSize: 13.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
