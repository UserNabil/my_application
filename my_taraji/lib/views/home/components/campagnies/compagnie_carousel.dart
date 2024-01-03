import 'compagnie_card.dart';
import 'compagnie_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';

class ListCarouselCompagnes extends StatefulWidget {
  const ListCarouselCompagnes({super.key, required this.campagnes});
  final List<Campaign> campagnes;

  @override
  ListCarouselCompagnesState createState() => ListCarouselCompagnesState();
}

class ListCarouselCompagnesState extends State<ListCarouselCompagnes> {
  @override
  Widget build(BuildContext context) {
    if (widget.campagnes.isEmpty) {
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
                      builder: (context) => AllCompagnesPage(
                        compagnes: widget.campagnes,
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
              for (final campaign in widget.campagnes)
                CompaignCard(
                  context: context,
                  campaign: campaign,
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
